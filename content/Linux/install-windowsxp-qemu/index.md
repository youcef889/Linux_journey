+++
title = "Install Windows XP on QEMU - Complete Guide"
date = "2026-03-18T16:06:36+01:00"
draft = false
description = "Learn how to install Windows XP in QEMU virtual machine. Covers IDE and virtio methods, network drivers, and configuration."
summary = "Complete guide to installing Windows XP on QEMU. Covers boot configuration, virtio drivers, network setup, and troubleshooting."
slug = "install-windows-xp-qemu"
categories = ["Virtualization", "QEMU", "Windows"]
tags = ["windows-xp", "qemu", "virtualization", "install", "vm"]
keywords = ["install windows xp qemu", "qemu windows xp", "windows xp virtual machine", "qemu virtualization"]
+++


Got it 👍
You have **everything needed** to install Windows XP SP3 with **virtio drivers**.

I’ll give you **two correct commands** using **exactly those files**, then short install steps.

---

# ✅ OPTION 1 (RECOMMENDED): Stable & easy (IDE + e1000)

Uses **no virtio**, simplest and most reliable.

```bash
qemu-system-i386 \
  -machine pc,accel=kvm \
  -cpu pentium3 \
  -m 1024 \
  -drive file=winxp.qcow2,if=ide \
  -cdrom en_windows_xp_professional_with_service_pack_3_x86_cd_vl_x14-73974.iso \
  -boot d \
  -vga std \
  -usb -device usb-tablet \
  -nic user,model=e1000 \
  -monitor stdio
```

### Install steps

1. Boot → XP installer starts
2. Enter key from `key.txt`
3. Finish install
4. Done ✅ (network works automatically)

---

# ✅ OPTION 2: q35 + virtio (advanced, your files match this)

Uses:

* `xp_q35_x86.img` → floppy drivers (setup)
* `virtio-win-0.1.285.iso` → full drivers (after install)

```bash
qemu-system-i386 \
  -machine q35,accel=kvm \
  -cpu  qemu32 \
  -m 2048 \
  -global q35-pcihost.x-pci-hole64-fix=false \
  -drive file=winxp.qcow2,if=virtio \
  -drive if=floppy,file=xp_q35_x86.img,format=raw \
  -cdrom en_windows_xp_professional_with_service_pack_3_x86_cd_vl_x14-73974.iso \
  -device VGA,vgamem_mb=64 \
  -usb -device usb-tablet \
  -nic user,model=virtio \
  -monitor stdio
```

### Install steps (IMPORTANT)

1. XP setup starts
2. When it asks for storage → **load driver from floppy**
3. Select **VirtIO Block Driver (XP 32-bit)**
4. Continue installation
5. After desktop loads:

   ```bash
   qemu-system-i386 ... -cdrom virtio-win-0.1.285.iso
   ```
6. Install **Network + Balloon drivers**

---

# 🔑 Notes

* `key.txt` → only for manual typing
* RAM **must stay ≤ 2GB**
* XP + q35 can freeze → Option 1 is safer
* `-cpu host` ❌ don’t use it with i386

---


```
qemu-system-i386 -M q35,usb=on,acpi=on,hpet=off -global q35-pcihost.x-pci-hole64-fix=false -m 4G -cpu host -accel kvm -drive if=virtio,file=winxp.qcow2 -drive if=floppy,file=xp_q35_x86.img,format=raw -device usb-tablet -device VGA,vgamem_mb=64 -nic user,model=virtio -monitor stdio -cdrom en_windows_xp_professional_with_service_pack_3_x86_cd_vl_x14-73974.iso -boot d
```
