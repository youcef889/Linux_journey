+++
title = "Install Wayland on Linux - Complete Setup Guide"
date = "2026-03-18T16:06:37+01:00"
draft = false
description = "Learn how to install and configure Wayland on Linux. Covers Wayland compositors like Sway, labwc, wayfire, and required packages."
summary = "Complete guide to installing Wayland on Void Linux and other distros. Covers Sway, labwc, wayfire, seatd, and display manager setup."
slug = "install-wayland-linux"
categories = ["Linux", "Wayland", "Desktop"]
tags = ["wayland", "sway", " compositor", "wayland-compositor", "linux-desktop"]
keywords = ["install wayland", "wayland compositor", "sway window manager", "wayland setup", "linux wayland"]
+++


On Void Linux, Wayland itself is just a display protocol — you don’t "run" Wayland directly.
Instead, you install a **Wayland compositor** (like **sway**, **labwc**, or **wayfire**) that provides the Wayland display server functionality.

Here’s a clean step-by-step to get Wayland working on Void Linux.

---

## **1. Update your system**

```bash
sudo xbps-install -Syu
```

---

## **2. Install required Wayland packages**

These are the general Wayland libraries and tools:

```bash
sudo xbps-install -S wayland wayland-protocols wlroots seatd xorg-server-xwayland
```

* `wayland` – core Wayland libraries
* `wayland-protocols` – extra protocol extensions
* `wlroots` – backend library for many compositors
* `seatd` – seat management daemon (needed for input devices)
* `xorg-server-xwayland` – XWayland support for running X11 apps under Wayland

---

## **3. Pick and install a Wayland compositor**

For example, **Sway** (a tiling WM like i3 but for Wayland):

```bash
sudo xbps-install -S sway
```

Other options:

```bash
sudo xbps-install -S labwc     # lightweight Openbox-style compositor
sudo xbps-install -S wayfire   # 3D compositor like Compiz
```

---

## **4. Enable `seatd` for input device access**

```bash
sudo ln -s /etc/sv/seatd /var/service/
sudo usermod -aG video,input yourusername
```

Log out and back in so your group changes take effect.

---

## **5. Start your Wayland session**

From a TTY (not inside X11), log in and run:

```bash
sway
```

If you’re using **labwc** or **wayfire**, replace `sway` with the compositor name.

---

## **6. (Optional) Set up a display manager with Wayland**

If you want graphical login:

* **greetd** (lightweight Wayland login manager)

```bash
sudo xbps-install -S greetd greetd-gtkgreet
sudo ln -s /etc/sv/greetd /var/service/
```

Edit `/etc/greetd/config.toml` to run your compositor after login.

---

## **7. (Optional) Wayland utilities**

```bash
sudo xbps-install -S wofi grim slurp wl-clipboard
```

* `wofi` – application launcher
* `grim` + `slurp` – screenshots
* `wl-clipboard` – clipboard tools for Wayland

---

