+++
title = "Install Local XBPS Packages on Void Linux"
date = "2026-03-18T16:06:36+01:00"
draft = false
description = "Learn how to install local .xbps packages on Void Linux manually. Covers xbps-rindex and xbps-install commands."
summary = "Guide to installing downloaded XBPS packages on Void Linux manually. Uses xbps-rindex to index packages and xbps-install to install locally."
slug = "install-local-xbps-packages"
categories = ["Linux", "Void Linux", "Package Management"]
tags = ["xbps", "void-linux", "local-package", "package-install"]
keywords = ["install local xbps", "void linux manual install", "xbps install local"]
+++



Manual package download and install: 

# Download the package manually 
```
curl -O https://repo-fastly.voidlinux.org/current/clang19-headers-19.1.4_8.x86_64.xbps

```

```
xbps-rindex -a *.xbps
xbps-install --repository=$PWD pkgname
```
