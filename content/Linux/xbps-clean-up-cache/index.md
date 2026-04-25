+++
title = "How to Clean XBPS Cache on Void Linux"
date = "2026-03-18T16:06:37+01:00"
draft = false
description = "Learn how to clean XBPS package cache on Void Linux. Remove old packages safely to free up disk space."
summary = "Guide to cleaning Void Linux package cache using xbps-remove commands. Covers removing all cached packages, obsolete packages, and manual cleanup."
slug = "xbps-clean-cache-void-linux"
categories = ["Linux", "Void Linux", "How-To"]
tags = ["void-linux", "xbps", "cache", "maintenance", "package-manager"]
keywords = ["void linux clean cache", "xbps remove cache", "free disk space void linux"]
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


