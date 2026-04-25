+++
title = "Display Server vs Display Manager vs Window Manager - Explained"
date = "2025-07-27T11:00:00+01:00"
draft = false
description = "Learn the difference between display server, display manager, and window manager in Linux. Complete explanation of X11, Wayland, and desktop components."
summary = "Complete explanation of display server, display manager, and window manager. Covers X11, Wayland, LightDM, SDDM, and window managers like i3, Openbox."
slug = "display-server-manager-window-manager"
categories = ["Tech", "Tutorials", "Linux"]
tags = ["display-server", "x11", "wayland", "window-manager", "desktop"]
keywords = ["display server", "display manager", "window manager", "x11", "wayland"]
author = "Youcef Bouaissi"
+++

What Is the Difference Between Display Server, Display Manager, and Window Manager?


In a typical Linux desktop environment (and sometimes in Unix-like systems), **Display Server**, **Display Manager**, and **Window Manager** are three separate components that work together to provide a graphical user interface (GUI). Here's a breakdown of each and how they differ:

---

###  1. **Display Server (Compositor)**

**Role**: Handles communication between the hardware (graphics card/input devices) and graphical applications.

####  Responsibilities:

* Receives input from mouse/keyboard/touchscreen.
* Sends output to the display (draws windows, images, text).
* Manages screen resolution, multiple monitors, etc.

####  Examples:

* **X11 (X.Org Server)** – the traditional display server.
* **Wayland** – modern alternative to X11.
* **Mir** – Canonical’s alternative (used briefly in Ubuntu).

>  Think of the display server as the "engine" that draws stuff and handles input/output with hardware.

---

###  2. **Display Manager (Login Manager)**

**Role**: Provides the **graphical login screen** and starts your session.

####  Responsibilities:

* Allows you to choose a user and enter a password.
* Lets you pick a desktop environment (GNOME, KDE, XFCE, etc.).
* Launches your session (starts the window manager or desktop environment).

####  Examples:

* **GDM** (GNOME Display Manager)
* **SDDM** (used with KDE)
* **LightDM**
* **LXDM**

>  Think of the display manager as the **greeter or doorman** that logs you in and starts the graphical session.

---

###  3. **Window Manager**

**Role**: Controls the placement, appearance, and behavior of windows on your screen.

####  Responsibilities:

* Handles window borders, resizing, maximizing, minimizing, and moving.
* Controls focus (which window is active).
* May provide keyboard shortcuts and virtual desktops.

####  Types:

* **Stacking WMs**: Windows overlap like papers on a desk (e.g., Openbox, Metacity).
* **Tiling WMs**: Windows are automatically arranged in a grid (e.g., i3, bspwm).
* **Compositing WMs**: Also manage transparency, shadows, and animations (e.g., Mutter, KWin).

####  Examples:

* **i3**, **bspwm**, **XMonad** (tiling)
* **Openbox**, **Fluxbox** (stacking)
* **Mutter** (used by GNOME), **KWin** (used by KDE)

>  Think of the window manager as the **interior decorator** – arranging your windows and handling how they behave.

---

###  Summary Table

| Component           | Role                             | Examples                  |
| ------------------- | -------------------------------- | ------------------------- |
| **Display Server**  | Talks to hardware, draws the GUI | X11, Wayland              |
| **Display Manager** | Login screen and session starter | GDM, LightDM, SDDM        |
| **Window Manager**  | Manages windows on the screen    | i3, KWin, Openbox, Mutter |

---

###  Real-World Analogy

| Part            | Analogy                                                |
| --------------- | ------------------------------------------------------ |
| Display Server  | Engine of a car (runs everything)                      |
| Display Manager | Key/ignition (lets you start driving)                  |
| Window Manager  | Steering wheel & pedals (controls behavior of windows) |

---


