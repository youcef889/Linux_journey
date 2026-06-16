---
title: "Fix: modprobe FATAL Module dm_mod Not Found in Void Linux"
date: 2026-05-26
lastmod: 2026-05-26
draft: false
description: "Step-by-step guide to fix the 'modprobe: FATAL: Module dm_mod not found' error in Void Linux caused by a missing or broken initramfs, wrong kernel version, or incomplete kernel installation."
summary: "Encountering 'modprobe: FATAL: Module dm_mod not found in directory /lib/modules/...' on Void Linux? This guide walks you through chrooting from a live ISO and rebuilding your initramfs and kernel hooks with xbps-reconfigure."
keywords: ["void linux dm_mod not found", "modprobe FATAL module not found void linux", "void linux initramfs rebuild", "xbps-reconfigure void linux", "void linux kernel modules missing", "dm_mod fix linux"]
tags: ["void linux", "linux", "kernel", "troubleshooting", "dm_mod", "initramfs"]
categories: ["Linux", "Troubleshooting"]
robots: "index,follow"
showHero: true
heroStyle: "big"
sharingLinks: ["linkedin", "twitter", "reddit"]
authors: ["youcef"]
---

## Fix: modprobe FATAL — Module dm_mod Not Found in Void Linux

If your Void Linux system fails to boot and drops you into a recovery shell with the following error:

```
modprobe: FATAL: Module dm_mod not found in directory /lib/modules/6.x.x
```

you are not alone. This is a relatively common issue and is almost always fixable without reinstalling.

---

## What Causes This Error?

The `dm_mod` kernel module is part of the **Device Mapper** subsystem, which is required by LVM, LUKS encryption, and several other storage-layer features. This error typically means one of the following:

- **Kernel modules are missing** — the `/lib/modules/<version>/` directory is incomplete or absent
- **Kernel version mismatch** — the running kernel does not match the installed modules
- **Corrupted or missing initramfs** — the initial ramdisk was not generated correctly
- **Incomplete kernel installation** — a partial update left the system in an inconsistent state
- **Device Mapper compiled into the kernel directly** — instead of as a loadable module (rare)

---

## Step 1: Boot from a Void Linux Live ISO

Since the system cannot boot normally, you need to boot from a **Void Linux live ISO**. You can download the latest one from the [official Void Linux downloads page](https://voidlinux.org/download/).

Once you are in the live environment, open a terminal and proceed to the next step.

---

## Step 2: Mount Your System and Chroot Into It

Identify your root and boot partitions (use `lsblk` or `fdisk -l` if unsure), then mount them and bind the necessary pseudo-filesystems:

```bash
# Replace /dev/sdXY with your actual partitions
mount /dev/your_root_partition /mnt
mount /dev/your_boot_partition /mnt/boot

mount --bind /sys  /mnt/sys
mount --bind /dev  /mnt/dev
mount --bind /proc /mnt/proc

chroot /mnt
```

> **Tip:** If you use an EFI system, you may also need to mount the EFI partition:
> ```bash
> mount /dev/your_efi_partition /mnt/boot/efi
> ```

---

## Step 3: Rebuild the Initramfs and Kernel Hooks

Once inside the chroot, run the following command to fully reconfigure all installed packages, including the kernel:

```bash
xbps-reconfigure -fa
```

This single command handles all of the following:

- Rebuilds the **initramfs**
- Re-runs all **kernel hooks**
- Regenerates **boot files**

This is the most reliable fix for missing or broken `dm_mod` and related module errors on Void Linux.

---

## Step 4: Verify That dm_mod Exists

After reconfiguring, confirm that the `dm-mod` module file is now present for your kernel version:

```bash
find /lib/modules/$(uname -r) -name 'dm-mod*'
```

If this returns a path like `/lib/modules/6.x.x/kernel/drivers/md/dm-mod.ko.zst`, the module is installed correctly.

> **Note:** Inside a chroot, `uname -r` returns the kernel version of the **live ISO**, not your installed system. Either substitute the correct version manually, or check the `/lib/modules/` directory directly with `ls /lib/modules/`.

---

## Step 5: Regenerate the GRUB Configuration

If your system uses GRUB as its bootloader, regenerate the GRUB configuration to ensure it points to the correct kernel and initramfs:

```bash
grub-mkconfig -o /boot/grub/grub.cfg
```

---

## Step 6: Reboot

Exit the chroot, unmount everything, and reboot:

```bash
exit

umount -R /mnt
reboot
```

Your system should now boot normally with `dm_mod` loading correctly.

---

## Summary

| Step | Command | Purpose |
|------|---------|---------|
| Mount partitions | `mount /dev/... /mnt` | Access the broken system |
| Chroot | `chroot /mnt` | Work as if running the installed OS |
| Rebuild | `xbps-reconfigure -fa` | Fix initramfs, kernel hooks, and boot files |
| Verify | `find /lib/modules/... -name 'dm-mod*'` | Confirm the module exists |
| GRUB | `grub-mkconfig -o /boot/grub/grub.cfg` | Update bootloader config |
| Reboot | `reboot` | Boot into the fixed system |

---

## Still Not Working?

If the error persists after following all steps, check the following:

- Run `xbps-install -Su` inside the chroot to ensure the kernel and all packages are fully up to date
- Verify that `linux` (or your specific kernel variant like `linux-lts`) is properly installed: `xbps-query linux`
- Check if Device Mapper was intentionally compiled into your kernel rather than as a module — in this case, `dm_mod` will not appear as a file but the feature is still available

---

*Found this helpful? Share it with others using the links below.*

