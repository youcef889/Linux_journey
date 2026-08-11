---
title: Mount Android Phone on Linux - File Transfer Guide
date: 2026-03-18T16:06:38+01:00
tags:
  - android
  - mtp
  - file-transfer
  - usb
categories:
  - Linux
  - Android
draft: false
summary: Guide to mounting Android phone on Linux for file transfer. Covers MTP
  protocol, USB debugging mode, and troubleshooting mount point errors.
keywords:
  - android file transfer linux
  - mount phone linux
  - mtp linux
  - adb file transfer
slug: mount-android-phone-linux
description: Learn how to mount and transfer files between Android phone and
  Linux. Covers MTP, USB debugging, and file manager configuration.
---


That error simply means the mount point (`~/Phone`) doesn’t exist yet — you just need to create that folder before mounting.

Here’s how to fix it step-by-step 👇

```bash
# 1. Create a folder to mount the phone
mkdir -p ~/Phone

# 2. Mount the phone again
jmtpfs ~/Phone
```

✅ If successful, your phone’s internal storage will now appear inside `~/Phone`.

To verify:

```bash
ls ~/Phone
```

You should see folders like `DCIM`, `Pictures`, `Downloads`, etc.

---

### 📤 When you’re done

Always unmount properly before unplugging:

```bash
fusermount -u ~/Phone
```

---
