---
title: " How to install Hyprland on Void linux "
slug: "Hyprland-Void-linux "
description: The easiest way to install Hyprland on Void Linux is using the
  binary repository which is built automatically using GitHub Actions whenever a
  new commit is pushed to this repository.
date: 2026-10-13T08:35:00.000+00:00
tags:
  - hyprland
  - wayland
  - desktop-environment
  - service-management
  - window-manager
categories:
  - desktop
  - void-linux
draft: true
---
## Add the  repo to you  repos :

```
echo repository=https://raw.githubusercontent.com/Makrennel/hyprland-void/repository-x86_64-glibc | sudo tee /etc/xbps.d/hyprland-void.conf
```

before add  this  repo  you should  new  what is  your  repository provides if it is  :

* `x86_64-glibc`
* `x86_64-musl`
* `aarch64-glibc`
* `aarch64-musl`

## Synchronize the repository

```
sudo xbps-install  -S 
```

## Search hypr

```
sudo xbps-query -Rs hypr
```

you well get

```
[-] hyprpicker-0.4.7_2                  Wlroots-compatible Wayland color picker that does not suck
[-] hyprutils-0.11.0_1                  Hyprland utilities library used across the ecosystem
[-] hyprwayland-scanner-0.4.5_1         Hyprland implementation of wayland-scanner, in and for C++
[-] hyprcursor-0.1.12_1                 Hyprland cursor format, library and utilities
[-] hyprgraphics-0.1.3_2                hyprland graphics resources and utilities
[-] hypridle-0.1.6_2                    Hyprland's idle daemon
[-] hyprland-0.49.0_1                   Dynamic tiling Wayland compositor that doesn't sacrifice on its looks
[-] hyprland-devel-0.49.0_1             Dynamic tiling Wayland compositor - development files
[-] hyprland-protocols-0.6.4_1          Wayland protocol extensions for Hyprland
[-] hyprland-qt-support-0.1.0_1         QML style provider for Hypr* QT apps
[-] hyprland-qtutils-0.1.4_1            Qt/QML utility apps for Hyprland
[-] hyprlang-0.6.3_1                    Official implementation library for the hypr config language
[-] hyprlock-0.8.2_1                    Hyprland's GPU-accelerated screen locking utility
[-] hyprpaper-0.7.5_1                   Fast wallpaper utility for wlroots compositors with IPC controls
[-] hyprpolkitagent-0.1.2_1             Simple polkit authentication agent for Hyprland, written in QT/QML
[-] hyprsunset-0.2.0_1                  An application to enable a blue-light filter on Hyprland
[-] hyprsysteminfo-0.1.3_1              A tiny qt6/qml application to display information about the running system
[-] hyprutils-0.7.1_1                   A small C++ library used across the Hypr* ecosystem
[-] hyprwayland-scanner-0.4.4_1         Hyprland's implementation of wayland-scanner in/for C++
[-] xdg-desktop-portal-hyprland-1.3.9_2 Backend of xdg-desktop-portal for Hyprland
[-] hyprutils-32bit-0.11.0_1            Hyprland utilities library used across the ecosystem (32bit)
[-] hyprwayland-scanner-32bit-0.4.5_1   Hyprland implementation of wayland-scanner, in and for C++ (32bit)
```

## Then install  what you need

```
sudo xbps-install  xdg-desktop-portal-hyprland hyprland
```

Before Running hayprland  you need : 

* [session and seat manager ](https://docs.voidlinux.org/config/session-management.html)
* [graphics drivers](https://docs.voidlinux.org/config/graphical-session/graphics-drivers/index.html)
* add the user to the `_seatd` group 

first new which groups you are in  by typing `groups $USER`  
then  add you self to `_seatd` group : 
`sudo usermod -aG _seatd $USER` 
