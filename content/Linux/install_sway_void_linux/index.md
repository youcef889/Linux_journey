+++
title = "Install Sway on Void Linux - Complete Guide"
date = "2026-03-18T16:06:37+01:00"
draft = false
description = "Complete guide to installing and configuring Sway on Void Linux. Covers seatd, greetd, waybar, and common fixes."
summary = "Step-by-step guide to install Sway on Void Linux. Includes seatd setup, greetd display manager, waybar configuration, and troubleshooting."
slug = "install-sway-void-linux"
categories = ["Linux", "Void Linux", "Sway", "Desktop"]
tags = ["sway", "void-linux", "wayland", "tiling-wm", "linux-desktop"]
keywords = ["install sway void linux", "sway wayland", "void linux desktop", "sway config", "tiling window manager"]
+++


Here is a **clean, simple guide to install and run Sway on Void Linux**, including Wayland utilities, login setup, and common fixes.

---

## ✅ **Install Sway on Void Linux**

### 1️⃣ Install Sway and essential tools

```sh
sudo xbps-install -S sway swaybg swayidle swaylock \
  waybar foot wl-clipboard grim slurp bemenu-wayland \
  kanshi mako
```

### Optional but useful:

```sh
sudo xbps-install -S network-manager-applet \
  brightnessctl alsa-utils seatd
```

---

# ✅ **Enable seatd (needed for input devices)**

Void uses **seatd**, not elogind by default.

### Enable & start seatd:

```sh
sudo ln -s /etc/sv/seatd /var/service/
sudo sv up seatd
```

Allow your user to use seatd:

```sh
sudo usermod -aG seatd $USER
```

Then **log out and log back in**.

---

# ✅ **Start Sway**

### Start directly from TTY:

```sh
sway
```

If you get:

```
permission denied: /dev/dri/card0
```

→ You must be in the **video** group:

```sh
sudo usermod -aG video $USER
```

---

# ✅ **Autostart Sway with greetd (recommended)**

Void does **not** ship a Wayland display manager by default.

### Install greetd + tuigreet:

```sh
sudo xbps-install -S greetd greetd-tuigreet
```

### Create config:

```sh
sudo nano /etc/greetd/config.toml
```

Put this:

```toml
[terminal]
vt = 1

[default_session]
command = "tuigreet --time --cmd sway"
user = "your_username"
```

Enable greetd:

```sh
sudo ln -s /etc/sv/greetd /var/service/
```

---

# ✅ **Basic Sway Config (~/.config/sway/config)**

If you want a minimal config:

```sh
mkdir -p ~/.config/sway
nano ~/.config/sway/config
```

Paste:

```
set $mod Mod4

# Terminal
bindsym $mod+Return exec foot

# Exit
bindsym $mod+Shift+e exec "swaymsg exit"

# Reload config
bindsym $mod+Shift+c reload

# Kill focused window
bindsym $mod+Shift+q kill

# Run launcher
bindsym $mod+d exec bemenu-run

# Lock screen
bindsym $mod+Shift+l exec swaylock
```

---

# ✅ **Waybar (panel)**

Create config:

```sh
mkdir -p ~/.config/waybar
cp /etc/xdg/waybar/config ~/.config/waybar/
cp /etc/xdg/waybar/style.css ~/.config/waybar/
```

Start automatically by adding into sway config:

```
exec waybar
```

---

# 🔧 **Common problems & fixes**

### ❌ Sway crashes / black screen

Install correct video driver:

* Intel:

  ```sh
  sudo xbps-install -S mesa-intel-dri
  ```
* AMD GPU:

  ```sh
  sudo xbps-install -S mesa-amdgpu-dri
  ```
* Nvidia (only nouveau works on Wayland):

  ```sh
  sudo xbps-install -S mesa-dri
  ```

---

### ❌ Clipboard not working

Install:

```sh
sudo xbps-install -S wl-clipboard
```

Copy:

```sh
wl-copy
```

Paste:

```sh
wl-paste
```

---

### ❌ No sound

```sh
sudo xbps-install -S alsa-utils
alsamixer
```

---


