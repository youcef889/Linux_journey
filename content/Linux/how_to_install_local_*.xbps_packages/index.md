---
title: Install Local XBPS Packages on Void Linux
date: 2026-03-18T16:06:36+01:00
tags:
  - xbps
  - local-packages
  - package-management
categories:
  - Package Management
draft: false
summary: Guide to installing downloaded XBPS packages on Void Linux manually.
  Uses xbps-rindex to index packages and xbps-install to install locally.
keywords:
  - install local xbps
  - void linux manual install
  - xbps install local
slug: install-local-xbps-packages
description: Learn how to install local .xbps packages on Void Linux manually.
  Covers xbps-rindex and xbps-install commands.
---



Manual package download and install: 

# Download the package manually 
```
curl -O https://repo-fastly.voidlinux.org/current/clang19-headers-19.1.4_8.x86_64.xbps

```

```
xbps-rindex -a *.xbps
xbps-install --repository=$PWD pkgname
```
