+++
date = '2026-03-18T16:06:38+01:00'
draft = false
title = 'Phon File Transfer Linux'
categories = ["Operating Systems", "Linux"]
tags = ["linux", "sysadmin"]
+++


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

Would you like me to show you how to **automatically mount the phone** whenever you plug it in (using `udev` or a small script)?

