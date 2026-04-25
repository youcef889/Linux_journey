+++
title = "Install DWM and ST on Void Linux - Suckless Tools"
date = "2025-08-16T12:43:06+01:00"
draft = false
description = "Learn how to install and configure DWM and ST on Void Linux. Minimalistic window manager and terminal from suckless.org."
summary = "Guide to installing DWM (Dynamic Window Manager) and ST terminal on Void Linux. Covers build from source, patches, and configuration."
slug = "install-dwm-st-void-linux"
categories = ["Linux", "Void Linux", "Desktop"]
tags = ["dwm", "st", "suckless", "window-manager", "void-linux"]
keywords = ["install dwm void linux", "dwm window manager", "suckless tools", "minimal wm"]
+++

## How to install and configer Dwm on void linux

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

### Installtion

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

after that you have a minmal system with dwm








