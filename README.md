# APT repository for T2 Macs

This GitHub repository has various apt repos, that can roughly be classified into 2 types:

1. A **common apt repo** having packages for **Debian** and **Ubuntu**.
2. **Release specific repo** for **Debian** and **Ubuntu**

## Adding the Common apt repo

You have to add the **common apt repo** irrespective of whether you are using Debian or Ubuntu. Run the following to add this repo:

```bash
curl -s --compressed "https://adityagarg8.github.io/t2-ubuntu-repo/KEY.gpg" | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/t2-ubuntu-repo.gpg >/dev/null
sudo curl -s --compressed -o /etc/apt/sources.list.d/t2.list "https://adityagarg8.github.io/t2-ubuntu-repo/t2.list"
sudo apt update
```

## Adding the Release specific apt repo

Now after you have added the common apt repo, you additionally have to add a **release specific repo** for kernel updates and `tiny-dfr`. Follow the steps below:

1. Identify your release codename. It is: 
  
    a) `jammy` for **Ubuntu 22.04**

    b) `noble` for **Ubuntu 24.04**

    c) `oracular` for **Ubuntu 24.10**

    d) `plucky` for **Ubuntu 25.04**

    e) `bookworm` for **Debian 12**

    f) `testing` for **Debian testing**

3. Run the following (taking `noble` as the example, just replace it with your release codename in the first line):

```bash
CODENAME=noble
echo "deb [signed-by=/etc/apt/trusted.gpg.d/t2-ubuntu-repo.gpg] https://github.com/AdityaGarg8/t2-ubuntu-repo/releases/download/${CODENAME} ./" | sudo tee -a /etc/apt/sources.list.d/t2.list
sudo apt update
```

**Note: You will have to add the release specific apt repo again whenever you upgrade Ubuntu/Debian to a newer release.**

You should be then be able to install and update the following packages with `apt`.

**WARNING** :- **apple-bce**, **apple-touchbar**, **applesmc-t2**, **apfs-dkms** and **bcm5974-t2** packages should NOT be installed if installing the `linux-t2` or `linux-t2-lts` package, as t2 kernels have these drivers built in.

- **apple-bce**: Exposes Keyboard, Camera, Touchbar, etc as USB devices. Also does audio. (DO NOT USE IF INSTALLING `linux-t2`, `linux-t2-lts`, `linux-t2-xanmod` or `linux-t2-xanmod-lts`)
- **apple-touchbar**: Driver for touchbar and keyboard backlight on T2 Macs. (DO NOT USE IF INSTALLING `linux-t2`, `linux-t2-lts`, `linux-t2-xanmod` or `linux-t2-xanmod-lts`)
- **applesmc-t2**: Driver for the System Management Controller on T2 Macs. (DO NOT USE IF INSTALLING `linux-t2`, `linux-t2-lts`, `linux-t2-xanmod` or `linux-t2-xanmod-lts`)
- **apple-t2-audio-config**: Audio config files for the audio device apple-bce has.
- **apple-firmware-script**: Debian package for the [script](https://wiki.t2linux.org/tools/firmware.sh) to get Wi-Fi and Bluetooth firmware from macOS. Run using `get-wifi-firmware`.
- **apfs-dkms**: Debian package for the [linux-apfs-rw](https://github.com/linux-apfs/linux-apfs-rw) driver. (DO NOT USE IF INSTALLING `linux-t2`, `linux-t2-lts`, `linux-t2-xanmod` or `linux-t2-xanmod-lts`)
- **bcm5974-t2**: Driver for trackpad gestures. (DO NOT USE IF INSTALLING `linux-t2` or `linux-t2-lts`)
- **linux-t2**: Kernel package for Mainline kernels.
- **linux-t2-lts**: Kernel package for LTS kernels.
- **linux-t2-xanmod**: Kernel package for Mainline [Xanmod](https://xanmod.org/) kernels.
- **linux-t2-xanmod-lts**: Kernel package for LTS [Xanmod](https://xanmod.org/) kernels.
- **t2fanrd**: Daemon to control fan speed on T2 Macs. For configuration instructions, refer to [this page](https://github.com/GnomedDev/T2FanRD).
- **t2-apple-audio-dsp-mic**: Mic configuration files for T2 Macs.
- **t2-apple-audio-dsp-speakers161**: Pipewire filterchain configuration files for Macbook Pro 16 inch, 2019
- **tiny-dfr**: Function row daemon for touchbar on Macs

## Donate

If you've really loved the work I've done so far for T2 Macs, and wanna help me out financially, you can donate me (AdityaGarg8) by following the instructions given [here](https://wiki.t2linux.org/contribute/#support-our-maintainers).
