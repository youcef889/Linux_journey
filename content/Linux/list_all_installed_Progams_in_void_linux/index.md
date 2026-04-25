+++
title = "List Installed Packages on Void Linux - Complete Guide"
date = "2026-03-18T16:06:37+01:00"
draft = false
description = "Learn how to list all installed packages on Void Linux using XBPS. Covers xbps-query commands for all packages, explicit installs, versions, and orphans."
summary = "Guide to listing installed packages on Void Linux. Uses xbps-query to show all packages, manually installed programs, versions, and orphaned dependencies."
slug = "void-linux-list-packages"
categories = ["Linux", "Void Linux", "Package Management"]
tags = ["void-linux", "xbps", "packages", "installed", "sysadmin"]
keywords = ["void linux list packages", "xbps-query", "list installed programs void linux", "xbps list"]
+++


On **Void Linux**, installed programs are managed by **XBPS**. Here are the common and useful ways to list them, depending on what you want to see.

---

## 1. List all installed packages (most common)

```bash
xbps-query -l
```

This shows **all installed packages**, including libraries and dependencies.

Example output:

```
ii firefox-121.0_1
ii vim-9.1.0042_1
ii glibc-2.38_2
```

---

## 2. List only explicitly installed packages (not dependencies)

```bash
xbps-query -m
```

This is usually what people mean by “programs I installed myself”.

---

## 3. List installed packages with versions

```bash
xbps-query -l | awk '{print $2}'
```

Or more detailed:

```bash
xbps-query -l -v
```

---

## 4. Check if a specific program is installed

```bash
xbps-query -s firefox
```

Or exact match:

```bash
xbps-query -l | grep firefox
```

---

## 5. List installed packages and save to a file

Useful for backups or migration:

```bash
xbps-query -m > installed-packages.txt
```

Restore later with:

```bash
sudo xbps-install -S -y $(cat installed-packages.txt)
```

---

## 6. List files installed by a specific package

```bash
xbps-query -f firefox
```

---

## 7. List orphaned packages (unused dependencies)

```bash
xbps-remove -o
```

---

### Quick recommendation

If you just want *“everything I installed”*, use:

```bash
xbps-query -m
```

If you want *everything on the system*, use:

```bash
xbps-query -l
```


