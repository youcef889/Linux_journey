+++
date = '2026-03-18T16:06:37+01:00'
draft = false
title = 'Xbps Clean Up Cache'
categories = ["Notes", "Reference"]
tags = ["notes"]
+++


On Void Linux, XBPS keeps downloaded packages in a cache directory. You can clean it safely like this:

---

## ✅ Remove all cached packages

Run as root:

```bash
sudo xbps-remove -O
```

This is the **recommended** way—it deletes old cached packages in:

```
/var/cache/xbps/
```

---

## 🧹 Remove only obsolete packages (not installed anymore)

```bash
sudo xbps-remove -o
```

---

## 📦 Clean manually (optional)

If you want to delete everything in the cache:

```bash
sudo rm -rf /var/cache/xbps/*
```

⚠️ This is safe, but `xbps-remove -O` is cleaner because it understands the package database.

---

## 🔍 Check cache size before cleaning

```bash
du -sh /var/cache/xbps
```

---

If you want, tell me what you’re trying to achieve—free disk space, fix broken installs, or maintenance script—and I can suggest the best combo 👍

