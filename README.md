# APT repository for T2 Macs

Run the following to add this repo

```bash
curl -s --compressed "https://adityagarg8.github.io/t2-ubuntu-repo/KEY.gpg" | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/t2-ubuntu-repo.gpg >/dev/null
sudo curl -s --compressed -o /etc/apt/sources.list.d/t2.list "https://adityagarg8.github.io/t2-ubuntu-repo/t2.list"
sudo apt update
```

You should be able to install and update the following packages with `apt`.

**WARNING** :- **apple-bce**, **apple-ibridge** and **apple-gmux-t2** packages should NOT be installed if installing the t2-kernel-script package, as t2 kernels have these drivers built in.

- **apple-bce**: Exposes Keyboard, Camera, Touchbar, etc as USB devices. Also does audio.
- **apple-touchbar**: Driver for touchbar and keyboard backlight on T2 Macs.
- **applesmc-t2**: Driver for the System Management Controller on T2 Macs.
- **apple-t2-audio-config**: Audio config files for the audio device apple-bce has.
- **bcm5974-t2**: Driver for trackpad gestures.
- **linux-apfs**: Debian package for the [linux-apfs-rw](https://github.com/linux-apfs/linux-apfs-rw) driver.
- **t2fand**: Daemon to control fan speed on T2 Macs. For configuration instructions, refer to [this page](https://github.com/NoaHimesaka1873/t2fand).
- **t2-kernel-script**: The kernel update script for Ubuntu Mainline T2 kernels.
- **t2-kernel-script-lts**: The kernel update script for Ubuntu LTS T2 kernels.
- **t2-kernel-script-debian**: The kernel update script for Debian Mainline T2 kernels.
- **t2-apple-audio-dsp-mic**: Mic configuration files for T2 Macs.
- **t2-apple-audio-dsp-speakers161**: Pipewire filterchain configuration files for Macbook Pro 16 inch, 2019
