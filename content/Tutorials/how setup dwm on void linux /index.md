+++
title = "Install DWM and ST on Void Linux - Suckless Tools"
date = "2025-08-16T12:43:06+01:00"
lastmod = "2026-07-08T14:30:00+01:00"
draft = false
description = "Learn how to install and configure DWM and ST on Void Linux. Minimalistic window manager and terminal from suckless.org."
summary = "Guide to installing DWM (Dynamic Window Manager) and ST terminal on Void Linux. Covers build from source, patches, and configuration."
slug = "install-dwm-st-void-linux"
categories = ["Linux", "Void Linux", "Desktop"]
tags = ["dwm", "st", "suckless", "window-manager", "void-linux"]
keywords = ["install dwm void linux", "dwm window manager", "suckless tools", "minimal wm"]
+++

## How to install and configure Dwm on void linux

### Why Dwm

dwm (Dynamic Window Manager) is a minimalistic, lightweight window manager for X11. It has very few dependencies since it's designed to be simple and efficient.

### Dependencies

first you should have  all this **Dependencies**:

```
git 
wget 
Xlib,libX11-devel
libXinerama-devel
freetype-devel
make 
gcc
libXft-devel
libXrandr-devel
```
| Package           | Purpose               |
| ----------------- | --------------------- |
| gcc               | Compile source code   |
| make              | Build software        |
| git               | Download repositories |
| libX11-devel      | X11 headers           |
| libXft-devel      | Font rendering        |
| libXinerama-devel | Multi-monitor support |
| freetype-devel    | Font support          |
| libXrandr-devel   | Screen resolution     |

Before building suckless tools from source on Void Linux, you need to install the necessary development tools and X11 header files using `xbps-install`. 

Run the following  command to install  all required dependencies : 
```
sudo xbps-install -S git wget make gcc libX11-devel libXinerama-devel freetype-devel libXft-devel libXrandr-devel
```
### Installation

After installing dependencies, you can clone, configure, and build dwm ,st and dmenu:


#### Install Dwm

```
mkdir programs
cd programs
# INSTALL dWM 
git clone https://git.suckless.org/dwm
cd dwm
sudo make clean install
```

#### Install ST

```
git clone https://git.suckless.org/st
cd st 
sudo make clean install
cd ..
```

#### Install dmenu

```
#INSTALL dmenu (like a program launcher) 
git clone https://git.suckless.org/dmenu
cd dmenu 
sudo make clean install
```

after that you have a minimal system with dwm



## Next Steps

You now have a functional, ultra-minimal desktop environment powered by suckless software. To launch your new setup, ensure you add `exec dwm` to your local `~/.xinitrc` file and start your session using `startx`.

## Popular DWM Patches

- Vanity Gaps
- Systray
- Fullgaps
- Alpha
- Pertag
- Fibonacci Layout

