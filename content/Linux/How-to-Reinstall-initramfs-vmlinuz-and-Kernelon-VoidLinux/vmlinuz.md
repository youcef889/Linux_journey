---
title: "How to Reinstall initramfs, vmlinuz, and Kernel on Void Linux"
description: "Complete guide to restore deleted initramfs, vmlinuz, and kernel configuration files on Void Linux using a live USB boot and chroot recovery method."
summary: "Learn step-by-step how to recover your Void Linux system when initramfs, vmlinuz, or kernel files are deleted, by booting from a live USB and using xbps-install with dracut."
url: "/linux/reinstall-initramfs-void-linux/"
tags: ["Void Linux","initramfs"]
keywords: ["Void Linux kernel reinstall", "restore initramfs Void Linux", "vmlinuz recovery", "initrd generation Void", "boot repair guide"]
date: 2026-04-25
---
How reinstall the deleted initramfs, vmlinuz, and configuration files on a Void Linux system using a live USB, you'll need to boot from the live ISO, mount your existing Void installation, and then use xbps-install to reinstall the necessary packages. You may also need to recreate the initial RAM disk (initrd) using dracut. 
Here's a more detailed breakdown:
1. Boot from the Void Linux Live USB:

    Insert the live USB and restart your computer.
    Access the boot menu (usually by pressing F2, F12, Delete, or Esc during startup) and select the USB drive as the boot device.
    Boot into the Void Linux live environment. 

2. Mount the Existing Void Installation:

    Open a terminal in the live environment.
    Identify your root partition (e.g., /dev/sda1 or /dev/nvme0n1p2).
    Mount the root partition: sudo mount /dev/your_root_partition /mnt.
    If you have a separate /boot partition, mount it: 
```
    sudo mount /dev/your_boot_partition /mnt/boot.
    Bind mount necessary directories for chroot:
        sudo mount --bind /dev /mnt/dev
        sudo mount --bind /proc /mnt/proc
        sudo mount --bind /sys /mnt/sys. 
```
3. Chroot into the Existing Installation:

    Change the root directory to your mounted installation: 
```
    sudo chroot /mnt. 
```
4. Reinstall Kernel and Related Packages:

    Reinstall the linux package: `xbps-install -S linux`.
    Reinstall any other kernel-related packages that were removed, such as kernel headers.
    Reinstall the void-system-image package (if you used it): xbps-install -S void-system-image. 

5. Recreate the Initial RAM Disk (initrd):

    Use dracut to generate the initrd: 

```
    dracut -f /boot/initramfs-linux.img 
    $(xbps-query -Rs linux | grep linux | head -n 1 | cut -d ' ' -f 1).
```
This command uses xbps-query to find the latest installed kernel, extracts the kernel version, and then uses dracut to create a new initramfs file in /boot.
        Adjust the path /boot/initramfs-linux.img if your initramfs file is located elsewhere. 

6. Update GRUB (if needed):

    If you've removed or modified your GRUB configuration, you might need to update it. If you have a separate /boot/grub directory, you may need to mount it as well:
```
sudo mount /dev/your_boot_partition /mnt/boot/grub 
```   
   Update GRUB:
```
   grub-mkconfig -o /boot/grub/grub.cfg.
```
   If your /boot directory is not mounted, you may need to specify the boot directory:
```
   grub-mkconfig -o /boot/grub/grub.cfg 
```
7. Exit and Reboot:

    Exit the chroot environment: exit. 

Unmount the partitions:
```
sudo umount /mnt/dev, sudo umount /mnt/proc, sudo umount /mnt/sys 
```
and finally, 
```
sudo umount /mnt. 
```
Reboot your system: `sudo reboot`. 

This process should restore your kernel, initramfs, and configuration files, allowing you to boot into your Void Linux installation. 
