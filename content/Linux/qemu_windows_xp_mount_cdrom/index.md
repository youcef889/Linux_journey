+++
title = "QEMU Windows XP - Mount Multiple CD-ROMs Tutorial"
date = "2026-03-18T16:06:37+01:00"
draft = true
description = "Learn how to mount and use multiple CD-ROMs in QEMU for Windows XP installation. Perfect for multi-disc software like SolidWorks."
summary = "Complete guide to installing Windows XP in QEMU with multiple CD-ROMs. Covers ISO mounting, IDE configuration, and driver installation for multi-disc setups."
slug = "qemu-windows-xp-multiple-cdrom"
categories = ["Virtualization", "Windows", "QEMU"]
tags = ["qemu", "windows-xp", "cdrom", "iso", "solidworks", "virtualization"]
keywords = ["qemu windows xp", "multiple cdrom qemu", "windows xp installation", "solidworks qemu", "qemu iso mount"]
+++


Your QEMU command is **almost correct**, but the problem is here 👇

```
-cdrom
```

You did **not** specify the ISO file, so QEMU has nothing mounted.

You also have **three SolidWorks CDs**, so you must mount **CD1 first**, then swap to CD2 and CD3 during install.

---

# ✅ Correct Command — Mount CD1

Run this:

```bash
sudo qemu-system-i386 \
  -machine pc,accel=kvm \
  -cpu pentium3 \
  -m 2048 \
  -drive file=winxp.qcow2,if=ide \
  -cdrom "SolidWorks 2004 SP0 CD1.ISO" \
  -boot c \
  -vga std \
  -usb \
  -device usb-host,vendorid=0x0781,productid=0x5567 \
  -nic user,model=e1000 \
  -monitor stdio
```

---

# 🔄 When Installer Asks for CD2 or CD3

Do **NOT** close QEMU.

In the QEMU monitor (`(qemu)`), type:

```
eject ide1-cd0
```

Then change ISO:

```
change ide1-cd0 "SolidWorks 2004 SP0 CD2.ISO"
```

Later:

```
change ide1-cd0 "SolidWorks 2004 SP0 CD3.ISO"
```

---

# ✅ Alternative (clearer CD handling)

You can explicitly define the CD drive:

```bash
-drive file="SolidWorks 2004 SP0 CD1.ISO",media=cdrom,if=ide
```

Instead of `-cdrom`.

---

# ⚠️ Important Notes for SolidWorks 2004

Since you’re installing on **Windows XP in QEMU**:

✔ 32-bit only — correct
✔ Pentium III CPU is good
✔ 2 GB RAM perfect
✔ IDE disk correct
✔ VGA std OK

---

# 🧠 Quick checklist if SolidWorks doesn't see USB

Inside XP:

* Device Manager → Universal Serial Bus controllers
* Must show USB Mass Storage Device

If not, use the **raw disk method** instead of usb-host.

---

If SolidWorks setup fails or crashes, tell me:

1️⃣ Exact error message
2️⃣ At which CD it stops
3️⃣ Screenshot text (type it)

We’ll fix it 👍

# Mount multiple Iso cdrom to  vm

Short answer: **No — not with only one CD drive.**
But **YES, you *can* mount all 3 ISOs at once** if you add **multiple virtual CD-ROM drives** to QEMU 👍

SolidWorks 2004 was designed for physical PCs that sometimes had more than one drive, so this works fine.

---

# ✅ Run with 3 CD Drives (CD1 + CD2 + CD3)

Use this command:

```bash
sudo qemu-system-i386 \
  -machine pc,accel=kvm \
  -cpu pentium3 \
  -m 2048 \
  -drive file=winxp.qcow2,if=ide \
  -drive file="SolidWorks 2004 SP0 CD1.ISO",media=cdrom,if=ide,index=1 \
  -drive file="SolidWorks 2004 SP0 CD2.ISO",media=cdrom,if=ide,index=2 \
  -drive file="SolidWorks 2004 SP0 CD3.ISO",media=cdrom,if=ide,index=3 \
  -boot c \
  -vga std \
  -usb \
  -device usb-host,vendorid=0x0781,productid=0x5567 \
  -nic user,model=e1000 \
  -monitor stdio
```

---

# 🧾 What You’ll See in Windows XP

Inside XP → **My Computer**:

* CD Drive (D:)
* CD Drive (E:)
* CD Drive (F:)

SolidWorks installer should automatically read them.

---

# ⚠️ Important Notes

• Works only if the installer supports multi-drive detection (SolidWorks usually does)
• IDE supports 4 devices per controller — we’re fine here
• If one ISO isn’t read, installer may still ask you to browse manually

---

# 🟡 Alternative (cleaner bus layout)

If QEMU complains about IDE slots, use:

```bash
-drive file="SolidWorks 2004 SP0 CD1.ISO",media=cdrom,if=none,id=cd1 \
-device ide-cd,drive=cd1,bus=ide.1

-drive file="SolidWorks 2004 SP0 CD2.ISO",media=cdrom,if=none,id=cd2 \
-device ide-cd,drive=cd2,bus=ide.2

-drive file="SolidWorks 2004 SP0 CD3.ISO",media=cdrom,if=none,id=cd3,bus=ide.3
```

---

# 🏁 Recommendation

✔ Mounting all three saves time
✔ Good for big multi-CD installers
✔ XP + SolidWorks 2004 works fine this way


