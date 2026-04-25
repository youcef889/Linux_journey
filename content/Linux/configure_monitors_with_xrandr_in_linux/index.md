+++
title = "Configure Monitors with xrandr on Linux"
date = "2026-03-18T16:06:36+01:00"
draft = false
description = "Learn how to configure multiple monitors on Linux using xrandr. Auto-detect HDMI connections and set up display positions."
summary = "Guide to configuring monitors with xrandr on Linux. Create scripts to detect HDMI connections and automatically set display resolution and position."
slug = "configure-monitors-xrandr-linux"
categories = ["Linux", "Desktop", "Display"]
tags = ["xrandr", "multi-monitor", "display", "linux-desktop", "hdmi"]
keywords = ["xrandr multi monitor", "configure monitor linux", "hdmi display setup", "linux display config"]
+++


You can use a simple shell script in your `.xinitrc` file (or a standalone script) to check if the HDMI monitor is connected using `xrandr` and then execute the appropriate commands based on the presence of the HDMI monitor. Here's how you can do that:

### 1. **Create the Display Configuration Script**

You can write a small script to detect the connected displays and apply the correct settings. Here's an example script:

```bash
#!/bin/sh

# Check if HDMI-1 is connected
if xrandr | grep "HDMI-1 connected"; then
    # If HDMI-1 is connected, set it to 1920x1080 and position it to the right of eDP-1
    xrandr --output HDMI-1 --mode 1920x1080 --right-of eDP-1 --primary
else
    # If HDMI-1 is not connected, set eDP-1 to 1366x768
    xrandr --output eDP-1 --mode 1366x768 --rate 60.00 --primary
fi
```

### 2. **Using the Script in `.xinitrc`**

You can place this script directly into your `.xinitrc` file before launching DWM. Here's how the `.xinitrc` file would look:

```bash
#!/bin/sh

# Check display and configure
if xrandr | grep "HDMI-1 connected"; then
    xrandr --output HDMI-1 --mode 1920x1080 --right-of eDP-1 --primary
else
    xrandr --output eDP-1 --mode 1366x768 --rate 60.00 --primary
fi

# Start background programs (optional)
# For example, start nm-applet or picom:
# nm-applet &
# picom --config ~/.config/picom.conf &

# Start DWM
exec dwm
```

### 3. **Making `.xinitrc` Executable**

Once the script is set up in `.xinitrc`, make sure the `.xinitrc` file is executable:

```bash
chmod +x ~/.xinitrc
```

### 4. **Explanation:**

* **Checking HDMI-1**: The command `xrandr | grep "HDMI-1 connected"` checks whether `HDMI-1` is connected to the system.
* **Setting resolutions**: If `HDMI-1` is connected, it will set it to 1920x1080 and position it to the right of `eDP-1` (your laptop screen). If HDMI-1 is not connected, it will set the laptop screen `eDP-1` to 1366x768.
* **`exec dwm`**: This launches DWM after configuring the displays.

### 5. **Optional: Putting the Display Script in a Separate File**

If you prefer to keep the logic in a separate script (instead of directly in `.xinitrc`), you can create a script, for example, `~/.display.sh`:

1. Create the script:

   ```bash
   nano ~/.display.sh
   ```

2. Paste the display setup script inside it:

   ```bash
   #!/bin/sh

   # Check if HDMI-1 is connected
   if xrandr | grep "HDMI-1 connected"; then
       xrandr --output HDMI-1 --mode 1920x1080 --right-of eDP-1 --primary
   else
       xrandr --output eDP-1 --mode 1366x768 --rate 60.00 --primary
   fi
   ```

3. Make the script executable:

   ```bash
   chmod +x ~/.display.sh
   ```

4. Modify your `.xinitrc` to call this script before launching DWM:

   ```bash
   #!/bin/sh

   # Run the display setup script
   ~/.display.sh

   # Start DWM
   exec dwm
   ```

### 6. **Testing the Setup**

After making these changes, you can test the configuration by logging out and running:

```bash
startx
```


