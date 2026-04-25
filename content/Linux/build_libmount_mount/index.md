+++
title = "Build libmount and mount from Source on Linux"
date = "2026-03-18T16:06:36+01:00"
draft = false
description = "Learn how to build libmount and mount from source on Linux. Fix library mismatches and rebuild util-linux."
summary = "Guide to building libmount and mount from source. Covers util-linux compilation, library linking, and fixing version mismatches."
slug = "build-libmount-from-source"
categories = ["Linux", "Development", "Troubleshooting"]
tags = ["libmount", "mount", "util-linux", "build", "source"]
keywords = ["build libmount", "compile mount", "util-linux source", "library mismatch fix"]
+++


Here’s a **clear, step-by-step guide** to rebuilding **libmount + mount (util-linux)** from source on Void Linux.
This is usually **not required**, but if your system is broken due to version mismatches, building from source can fix it.

---

# ✅ **1. Install build dependencies**

You need the development tools and headers:

```bash
sudo xbps-install -Sy base-devel
sudo xbps-install -Sy pkg-config gettext-devel
```

Void Linux splits packages, so you also need required `-devel` packages:

```bash
sudo xbps-install -Sy util-linux-devel
```

If you're rebuilding because util-linux is broken, the above command may fail — that’s okay, you can still build without it.

---

# ✅ **2. Download the latest util-linux source**

Util-linux contains `mount`, `umount`, `libmount`, etc.

```bash
wget https://www.kernel.org/pub/linux/utils/util-linux/v2.41/util-linux-2.41.tar.xz
tar xf util-linux-2.41.tar.xz
cd util-linux-2.41
```

Replace `2.41` with the release you need.

---

# ✅ **3. Configure the build**

Run:

```bash
./configure --prefix=/usr --disable-all-programs --enable-mount --enable-libmount
```

Explanation:

* `--prefix=/usr` → installs into `/usr/bin` and `/usr/lib`
* `--disable-all-programs` → disables everything except what you explicitly enable
* `--enable-mount` → builds the `mount` command
* `--enable-libmount` → builds `libmount.so`

---

# ✅ **4. Build it**

```bash
make -j$(nproc)
```

This compiles `mount` and `libmount`.

---

# ✅ **5. Install (careful!)**

**This can overwrite system binaries.**
Safer method: install to a temporary directory first.

```bash
make DESTDIR="$HOME/mount-test" install
```

You’ll find new binaries in:

```
$HOME/mount-test/usr/bin/mount
$HOME/mount-test/usr/lib/libmount.so.*
```

Test them **before installing system-wide**.

---

# ⚠️ **6. Test without installing**

Run the newly-built mount using an absolute path:

```bash
$HOME/mount-test/usr/bin/mount --version
ldd $HOME/mount-test/usr/bin/mount
```

Make sure it properly links to the newly built `libmount.so`.

---

# ⚠️ **7. If everything works, install to the system**

Only do this if your current system is already broken:

```bash
sudo make install
```

---

# 🩹 **If your system is badly broken**

You may also need to temporarily set:

```bash
export LD_LIBRARY_PATH=/usr/local/lib:/usr/lib
```

Or override mount’s linked library:

```bash
LD_PRELOAD=/usr/lib/libmount.so.1 mount
```

---

# 🔍 Want easier debugging first?

I can guide you through:

* checking conflicting libmount versions
* verifying the `/usr/lib` symlinks
* using `xbps` to fetch the correct `.xbps` package
* reinstalling util-linux cleanly

---

If you want, tell me:

```bash
ls -l /usr/lib/libmount*
xbps-query -l | grep util-linux
mount --version
```


