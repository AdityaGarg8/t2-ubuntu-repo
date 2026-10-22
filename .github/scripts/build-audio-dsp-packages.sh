#!/usr/bin/env bash

set -euo pipefail

if (( $# != 2 )); then
	echo "usage: $0 KAIT2EN_SOURCE OUTPUT_DIRECTORY" >&2
	exit 2
fi

source_root=$1
output_dir=$2
dsp_root="$source_root/modules/t2bce_audio-dsp/firs"
version=${VERSION:-1.0.0}

profiles=(
	"8_1|81|MacBookAir8,1"
	"8_2|82|MacBookAir8,2"
	"9_1|91|MacBookAir9,1"
	"15_1|151|MacBookPro15,1"
	"15_4|154|MacBookPro15,4"
	"16_1|161|MacBookPro16,1"
	"16_2|162|MacBookPro16,2"
	"16_3|163|MacBookPro16,3"
	"16_4|164|MacBookPro16,4"
)

command -v dpkg-deb >/dev/null || {
	echo "dpkg-deb is required" >&2
	exit 1
}

[[ -d "$dsp_root" ]] || {
	echo "KaiT2en DSP profiles not found at $dsp_root" >&2
	exit 1
}

mkdir -p "$output_dir"
work_dir=$(mktemp -d)
trap 'rm -rf "$work_dir"' EXIT

for entry in "${profiles[@]}"; do
	IFS='|' read -r profile suffix product <<<"$entry"
	src="$dsp_root/$profile"
	package="t2-apple-audio-dsp-speakers$suffix"
	root="$work_dir/$package"
	asset_dir="$root/usr/share/t2-linux-audio/$profile"
	conf_dir="$root/etc/wireplumber/wireplumber.conf.d"
	doc_dir="$root/usr/share/doc/$package"

	[[ -f "$src/graph.json" ]] || {
		echo "missing graph for $product: $src/graph.json" >&2
		exit 1
	}

	rm -rf "$root"
	mkdir -p "$root/DEBIAN" "$asset_dir" "$conf_dir" "$doc_dir"

	find "$src" -maxdepth 1 -type f \
		\( -name '*.wav' -o -name '*.lua' -o -name 'LICENSE.*' \) \
		-exec cp -- {} "$asset_dir/" \;

	sed \
		-e 's|"target.object": "alsa_output.pci-[^"]*\.Speakers"|"target.object": "alsa_output.hw_Audio_0"|' \
		"$src/graph.json" >"$asset_dir/graph.json"

	cat >"$conf_dir/51-t2-dsp-speakers$suffix.conf" <<EOF
# Generated from the KaiT2en $product DSP profile.
node.software-dsp.rules = [
    {
        matches = [
            { alsa.card_name = "Apple T2 Audio" device.profile.name = "HiFi: Speaker: sink" }
        ]
        actions = {
            create-filter = {
                filter-path = "/usr/share/t2-linux-audio/$profile/graph.json"
                hide-parent = false
            }
        }
    }
]

wireplumber.profiles = { main = { node.software-dsp = required } }
EOF

	cat >"$root/DEBIAN/control" <<EOF
Package: $package
Version: $version
Section: sound
Priority: optional
Architecture: all
Maintainer: Aditya Garg <gargaditya08@live.com>
Depends: apple-t2-audio-config (>= 0.5.2), bankstown-lv2, lsp-plugins-lv2 (>= 1.2.14), pipewire (>= 1.4.0), wireplumber (>= 0.5.0)
Provides: t2-apple-audio-dsp-speakers
Conflicts: t2-apple-audio-dsp-speakers
Replaces: t2-apple-audio-dsp-speakers
Homepage: https://github.com/kaiT2en/KaiT2en-Fedora
Description: PipeWire speaker DSP profile for $product
 This package contains the model-specific FIR filters, PipeWire filter graph,
 and WirePlumber policy needed for the internal speakers of $product.
EOF

	cat >"$doc_dir/copyright" <<EOF
The DSP profile is sourced from KaiT2en:
https://github.com/kaiT2en/KaiT2en-Fedora

The common DSP implementation is licensed as follows:

EOF
	cat "$source_root/modules/t2bce_audio-dsp/LICENSE" >>"$doc_dir/copyright"
	if [[ -f "$src/LICENSE.asahi-audio" ]]; then
		cat >>"$doc_dir/copyright" <<EOF


The FIR files derived from Asahi Linux are licensed as follows:

EOF
		cat "$src/LICENSE.asahi-audio" >>"$doc_dir/copyright"
	fi

	dpkg-deb --build --root-owner-group -Zgzip "$root" \
		"$output_dir/${package}_${version}_all.deb"
done
