---
title: "Booting to a program in linux "
date: "2025-08-15"
draft: "true"
---
# Booting Linux Directly to a Program

![Booting to linux ](https://files.codingninjas.in/article_images/booting-process-in-linux-0-1690939075.webp)
There are several ways to configure a Linux system to boot directly into a specific program rather than a full desktop environment. Here are the main methods:



## Method 1: Modify the Default Runlevel/Target

1. **For systemd systems (most modern distributions):**
   ```bash
   sudo systemctl set-default multi-user.target  # Sets text mode boot
   ```

2. **Edit your shell initialization file** (`.bash_profile`, `.bashrc`, or `.profile` in your home directory) to launch your program at login.

## Method 2: Use .xinitrc (For Graphical Programs)

1. If using a display manager (login screen), you'll need to bypass it:
   ```bash
   sudo systemctl disable gdm  # or lightdm, sddm, etc.
   ```

2. Create/edit `~/.xinitrc`:
   ```bash
   #!/bin/sh
   exec /path/to/your/program
   ```

3. Make it executable:
   ```bash
   chmod +x ~/.xinitrc
   ```

4. Configure to start X at login by adding to your shell initialization:
   ```bash
   if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
     exec startx
   fi
   ```

## Method 3: Modify getty Service (For Text-based Programs)

1. Create a custom service or modify getty:
   ```bash
   sudo systemctl edit getty@tty1
   ```

2. Add/modify to:
   ```
   [Service]
   ExecStart=
   ExecStart=-/sbin/agetty --autologin username --noclear %I $TERM
   ```

3. Then add your program to the user's shell initialization file.

## Method 4: Create a Custom Systemd Service

1. Create a service file (e.g., `/etc/systemd/system/myapp.service`):
   ```
   [Unit]
   Description=My Custom Application
   After=graphical.target

   [Service]
   ExecStart=/path/to/your/program
   User=username
   Group=username
   Restart=always

   [Install]
   WantedBy=multi-user.target
   ```

2. Enable the service:
   ```bash
   sudo systemctl enable myapp.service
   ```

## Important Considerations:

1. **Keyboard shortcuts**: You may want to disable Ctrl+Alt+Del:
   ```bash
   sudo systemctl mask ctrl-alt-del.target
   ```

2. **Autologin**: Configure your display manager for autologin if using graphical programs.

3. **Exit handling**: Ensure your program can't be accidentally exited, or configure a way to regain control.

4. **Testing**: Test changes in a virtual terminal (Ctrl+Alt+F2) before applying to tty1.

