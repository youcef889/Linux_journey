+++
title = "Chroot Tutorial - Fix Broken Linux System"
date = "2026-03-18T16:06:37+01:00"
draft = true
description = "Learn how to use chroot to fix broken Linux systems, recover from boot issues, and repair libraries. Includes OpenSSL fix examples."
summary = "Complete guide to using chroot for Linux system recovery. Covers mounting, entering chroot, fixing broken packages (libmount, openssl), and system repair."
slug = "chroot-repair-linux-system"
categories = ["Linux", "Troubleshooting", "Recovery"]
tags = ["chroot", "linux-recovery"]
keywords = ["chroot tutorial", "fix linux with chroot", "chroot recovery", "broken system fix", "rescue linux"]
+++


Here are **simple, clear instructions** to use **chroot** *and* fix a broken system (like your libmount error), plus how to work with **openssl inside a chroot**.

---

# 🧱 **PART 1 — How to use `chroot` (Void Linux or any Linux)**

`chroot` lets you “enter” another Linux system (your installed system, a rescue system, a folder, etc.) so you can repair it.

---

# ✅ **1. Mount the target system**

If you booted from a live USB (Void, Arch, Alpine, etc.), first mount your Linux root partition:

Example (replace `/dev/sda2` with your actual partition):

```bash
sudo mount /dev/sda2 /mnt
```

If you have separate partitions:

```bash
sudo mount /dev/sda2 /mnt               # /
sudo mount /dev/sda1 /mnt/boot          # /boot
sudo mount /dev/sda3 /mnt/home          # /home (optional)
```

---

# ✅ **2. Bind-mount required system directories**

```bash
sudo mount --bind /dev  /mnt/dev
sudo mount --bind /proc /mnt/proc
sudo mount --bind /sys  /mnt/sys
```

These are required for programs to run correctly inside the chroot.

---

# ✅ **3. Enter the chroot**

```bash
sudo chroot /mnt /bin/bash
```

You are now *inside* your installed system.

---

# 🧼 **4. When you are done, exit**

```bash
exit
```

And unmount:

```bash
sudo umount /mnt/sys /mnt/proc /mnt/dev
sudo umount /mnt
```

---

# 🛠️ Why use chroot?

Because inside `chroot` you can:

* reinstall broken packages (like util-linux, libmount)
* regenerate initramfs
* fix bootloader
* reset passwords
* compile packages
* run openssl

---

# 🧱 **PART 2 — How to fix your system using chroot**

Since you had:

```
mount: /usr/lib/libmount.so.1: version `MOUNT_2_41' not found
```

You can repair from inside chroot:

### 1. Boot live environment

### 2. Mount your system

### 3. Enter chroot

### 4. Reinstall util-linux:

```bash
xbps-install -Sy util-linux libmount
```

If your repo keys are outdated:

```bash
xbps-install -Sy xbps
```

This usually fixes libmount missing symbols.

---

# 🔐 PART 3 — How to use **OpenSSL** inside (or outside) a chroot

OpenSSL works normally inside a chroot as long as `/dev`, `/proc`, and `/sys` are bind-mounted.

### Example commands:

## ✔ Check OpenSSL version

```bash
openssl version
```

## ✔ Generate a private key

```bash
openssl genpkey -algorithm RSA -out key.pem -pkeyopt rsa_keygen_bits:2048
```

## ✔ Generate a CSR

```bash
openssl req -new -key key.pem -out request.csr
```

## ✔ Self-signed certificate

```bash
openssl req -x509 -new -key key.pem -out cert.pem -days 365
```

## ✔ Encrypt/Decrypt a file

Encrypt:

```bash
openssl enc -aes-256-cbc -salt -in file.txt -out file.enc
```

Decrypt:

```bash
openssl enc -aes-256-cbc -d -in file.enc -out file.txt
```

---

# ❓ Want me to walk you through your repair?

If you want, tell me these outputs:

```
ls /mnt/usr/lib/libmount*
xbps-query -l | grep util-linux
lsb_release -a  (if available)
```

I can give you exact instructions for YOUR system.



### Open ssl 

You now have **the same kind of library mismatch** as your `mount/libmount` issue — but this time with **OpenSSL**:

```
openssl: /usr/lib/libssl.so.3: version `OPENSSL_3.4.0' not found
openssl: /usr/lib/libcrypto.so.3: version `OPENSSL_3.5.0' not found
```

This means:

* Your **openssl binary** was built against **a newer OpenSSL (3.4 / 3.5)**
* But your system **has older libssl and libcrypto**
* So openssl cannot run → because the required symbol versions don’t exist

This normally occurs if:

* You mixed packages from **different Void Linux branches** (x86_64 vs x86_64-musl, stable vs rolling)
* You replaced some libs manually
* You restored incorrectly from backup
* Or your system upgrade was interrupted

---

# ✅ HOW TO FIX IT (the safe, correct way)

You must reinstall **all OpenSSL-related packages** from the correct Void Linux repo.

## **Step 1 — Enter chroot (if system is broken)**

If you’re already in chroot, skip.

If not:

```bash
mount /dev/sdXY /mnt
mount --bind /dev  /mnt/dev
mount --bind /proc /mnt/proc
mount --bind /sys  /mnt/sys
chroot /mnt /bin/bash
```

---

# ✅ **Step 2 — Update XBPS first (very important)**

Because XBPS itself may not understand the new repo data.

```bash
xbps-install -Sy xbps
```

---

# ✅ **Step 3 — Reinstall OpenSSL and everything depending on it**

```bash
xbps-install -f openssl libssl libcrypto
```

On Void Linux, the correct package names are:

```
openssl
openssl-dev
libssl3
libcrypto3
```

So the safer full reinstall is:

```bash
xbps-install -f openssl openssl-devel libssl3 libcrypto3
```

This forces reinstall and ensures matching versions.

---

# 🔍 **If you get repository key errors**

Update repository keys:

```bash
xbps-install -Sy void-repo-nonfree void-repo-multilib void-repo-multilib-nonfree void-repo-debug
```

Or if using MUSL:

```bash
xbps-install -Sy void-repo-musl
```

---

# 🛠️ **Step 4 — Verify the library versions**

Run:

```bash
strings /usr/lib/libssl.so.3 | grep OPENSSL
strings /usr/lib/libcrypto.so.3 | grep OPENSSL
```

You should see something like:

```
OPENSSL_3.4.0
OPENSSL_3.5.0
```

If they are still missing — **you have wrong libs installed** (musl vs glibc mix, or wrong repo).

---

# ⚠️ IF THE ABOVE STILL DOES NOT WORK

Then your system **has mixed architectures or mixed repos**.

Check architecture:

```bash
xbps-uhelper arch
```

Check if wrong packages are installed:

```bash
xbps-query -l | grep -E "openssl|ssl|crypto"
```

Send me the output and I can diagnose exactly what mismatch exists.

---

# ❗ LAST RESORT (if your repositories are newer than system)

Fetch the OpenSSL package manually:

```bash
xbps-fetch -R /tmp openssl
```

Then extract it:

```bash
cd /
sudo xbps-rindex -a /tmp/*.xbps
sudo xbps-install -f --repository=/tmp openssl
```

---

# 📩 If you send me this information, I can give exact fix:

Please run (inside chroot or system):

```
xbps-query -l | grep ssl
xbps-query -l | grep crypto
xbps-uhelper arch
ls -l /usr/lib/libssl*
ls -l /usr/lib/libcrypto*
```
