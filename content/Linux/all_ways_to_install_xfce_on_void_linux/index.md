+++
title = "Install XFCE on Void Linux - All Methods Guide"
date = "2026-03-18T16:06:37+01:00"
draft = false
description = "Multiple ways to install XFCE on Void Linux. Covers full desktop, minimal setup, LightDM, SDDM, startx, and VNC methods."
summary = "Comprehensive guide to installing XFCE on Void Linux. Covers meta-package, minimal components, display managers, startx, XWayland, VNC, and Docker methods."
slug = "install-xfce-void-linux"
categories = ["Linux", "Void Linux", "XFCE", "Desktop"]
tags = ["xfce", "void-linux", "desktop", "linux-desktop", "xfce4"]
keywords = ["install xfce void linux", "xfce desktop", "void linux xfce", "xfce4 setup"]
+++


Here are **all common ways to install and run XFCE on Void Linux**, depending on whether you want a full desktop environment, a minimal setup, or to start it manually.

---

# ⭐ 1. **Install the Full XFCE Desktop Meta-Package**

This is the easiest method.

```sh
sudo xbps-install -S xfce4
sudo xbps-install -S lightdm lightdm-gtk3-greeter
sudo ln -s /etc/sv/lightdm /var/service/
reboot
```

**What this gives you:**
✓ All XFCE core components
✓ LightDM display manager
✓ XFCE session starts automatically at login

---

# ⭐ 2. **Install a Minimal XFCE Session (no meta-package)**

If you want only the essential parts of XFCE:

```sh
sudo xbps-install -S xfce4-session xfce4-panel xfce4-settings xfwm4 xfdesktop xfce4-terminal thunar
```

Start manually (no display manager):

```sh
echo "exec startxfce4" > ~/.xinitrc
startx
```

**What this gives you:**
✓ Minimal XFCE (panel, WM, settings, terminal, Thunar)
✓ No login manager

---

# ⭐ 3. **Start XFCE via a Display Manager (DM)**

### Using LightDM

```sh
sudo xbps-install -S lightdm lightdm-gtk3-greeter
sudo ln -s /etc/sv/lightdm /var/service/
```

### Using SDDM

```sh
sudo xbps-install -S sddm
sudo ln -s /etc/sv/sddm /var/service/
```

XFCE will appear in the **session selector**.

---

# ⭐ 4. **Start XFCE without a DM (using startx)**

Useful for minimal/WM-style setups.

Install XFCE (minimal or full), then:

```sh
echo "exec startxfce4" > ~/.xinitrc
startx
```

---

# ⭐ 5. **Run XFCE Inside Wayland (Experimental)**

XFCE is still primarily X11-based, but you can run it under XWayland inside a Wayland compositor like Sway or labwc.

Example with Sway:

```sh
sudo xbps-install -S sway xwayland xfce4-panel xfce4-terminal thunar
```

Start Sway:

```sh
sway
```

Then run XFCE components manually (hybrid setup):

```sh
xfwm4 --replace
xfce4-panel &
```

---

# ⭐ 6. **Run XFCE in a Headless/Remote Session**

### Using Xvnc (for VNC desktop)

```sh
sudo xbps-install -S tigervnc xfce4
```

`~/.vnc/xstartup`:

```sh
#!/bin/sh
exec startxfce4
```

Start server:

```sh
vncserver
```

---

# ⭐ 7. **Run XFCE in a Container (chroot/LXC/Docker)**

Example with Docker:

```sh
docker run -it --rm voidlinux/voidlinux bash
xbps-install -S xfce4 tigervnc
startxfce4
```

Useful for sandboxing or remote desktop.

---

# ⭐ Summary of All Methods

| Method                                  | Description                 |
| --------------------------------------- | --------------------------- |
| **1. Meta-package (xfce4)**             | Easiest full desktop        |
| **2. Minimal components**               | Lightweight, manual control |
| **3. Display manager (LightDM/SDDM)**   | GUI login                   |
| **4. startx (.xinitrc)**                | No display manager          |
| **5. Wayland (experimental, XWayland)** | Hybrid with Sway/labwc      |
| **6. VNC (headless)**                   | Remote desktop XFCE         |
| **7. Containers**                       | Run XFCE in Docker/chroot   |

---

