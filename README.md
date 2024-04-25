# APT repository for T2 Macs

This GitHub repository had various apt repos, that can roughly be classified into 2 types:

1. A **common apt repo** for **Debian** and **all variants of Ubuntu**.
2. **Release specific repo** for **Ubuntu only**.

## Adding the Common apt repo

You have to add the **common apt repo** irrespective of whether you are using Debian or Ubuntu. Run the following to add this repo:

```bash
curl -s --compressed "https://adityagarg8.github.io/t2-ubuntu-repo/KEY.gpg" | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/t2-ubuntu-repo.gpg >/dev/null
sudo curl -s --compressed -o /etc/apt/sources.list.d/t2.list "https://adityagarg8.github.io/t2-ubuntu-repo/t2.list"
sudo apt update
```

## Adding the Release specific apt repo

Now after you have added the common apt repo, if you are an **Ubuntu** user, you additionally have to add a **release specific repo** for kernel updates. Follow the steps below:

1. Identify your release codename. It is: 
  
    a) `jammy` for **Ubuntu 22.04**

    b) `mantic` for **Ubuntu 23.10**

    c) `noble` for **Ubuntu 24.04**

3. Run the following (taking `noble` as the example, just replace it with your release codename in the first line):

```bash
CODENAME=noble
echo "deb [signed-by=/etc/apt/trusted.gpg.d/t2-ubuntu-repo.gpg] https://github.com/AdityaGarg8/t2-ubuntu-repo/releases/download/${CODENAME} ./" | sudo tee -a /etc/apt/sources.list.d/t2.list
sudo apt update
```

You should be then be able to install and update the following packages with `apt`.

**WARNING** :- **apple-bce**, **apple-ibridge**, **applesmc-t2** and **bcm5974-t2** packages should NOT be installed if installing the t2-kernel-script package, as t2 kernels have these drivers built in.

- **apple-bce**: Exposes Keyboard, Camera, Touchbar, etc as USB devices. Also does audio. (DO NOT USE IF INSTALLING `linux-t2`, `linux-t2-lts` or `t2-kernel-script-debian`)
- **apple-touchbar**: Driver for touchbar and keyboard backlight on T2 Macs. (NO LONGER MAINTAINED, USE `tiny-dfr`)
- **applesmc-t2**: Driver for the System Management Controller on T2 Macs.
- **apple-t2-audio-config**: Audio config files for the audio device apple-bce has.
- **bcm5974-t2**: Driver for trackpad gestures.
- **linux-apfs**: Debian package for the [linux-apfs-rw](https://github.com/linux-apfs/linux-apfs-rw) driver.
- **linux-t2**: Kernel package for Mainline kernels (Ubuntu only).
- **linux-t2-lts**: Kernel package for LTS kernels (Ubuntu only).
- **t2fanrd**: Daemon to control fan speed on T2 Macs. For configuration instructions, refer to [this page](https://github.com/GnomedDev/T2FanRD).
- **t2-kernel-script-debian**: The kernel update script for Debian Mainline T2 kernels.
- **t2-apple-audio-dsp-mic**: Mic configuration files for T2 Macs.
- **t2-apple-audio-dsp-speakers161**: Pipewire filterchain configuration files for Macbook Pro 16 inch, 2019
- **tiny-dfr**: Function row daemon for touchbar on Macs

## Donate

If you've really loved the work I've done so far for T2 Macs, and wanna help me out financially, you can donate me (AdityaGarg8) by following the instructions given [here](https://wiki.t2linux.org/contribute/#support-our-maintainers).
