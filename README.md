# APT repository for T2 Macs

Run the following to add this repo

```bash
curl -s --compressed "https://adityagarg8.github.io/t2-ubuntu-repo/KEY.gpg" | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/t2-ubuntu-repo.gpg >/dev/null
sudo curl -s --compressed -o /etc/apt/sources.list.d/t2.list "https://adityagarg8.github.io/t2-ubuntu-repo/t2.list"
sudo apt update
```

You should be able to install and update the following packages with `apt`.

- **apple-bce**: Exposes Keyboard, Camera, Touchbar, etc as USB devices. Also does audio.
- **apple-ibridge**: Touchbar driver, keyboard backlight on mbp16,X (ones where touchbar does not have esc key in it).
- **apple-t2-audio-config**: Audio config files for the audio device apple-bce has.
- **apple-gmux-t2**: Driver for hybrid graphics on Macs with both AMD and Intel GPU.
- **t2-kernel-script**: The kernel update script for Ubuntu Mainline T2 kernels.
- **t2-kernel-script-lts**: The kernel update script for Ubuntu LTS T2 kernels.
- **t2-kernel-script-debian**: The kernel update script for Debian Mainline T2 kernels.
