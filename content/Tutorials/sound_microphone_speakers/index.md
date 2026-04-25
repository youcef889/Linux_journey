+++
title = "Fix Sound Switching to USB Microphone on Linux"
date = "2026-03-18T16:06:36+01:00"
draft = false
description = "Learn how to fix audio switching to USB microphone on Linux. Keep sound output on speakers when plugging in USB audio devices."
summary = "Guide to fixing audio device switching on Linux. Prevent system from switching to USB microphone as default output. Uses PulseAudio and ALSA configuration."
slug = "fix-sound-usb-microphone-linux"
categories = ["Linux", "Audio", "Troubleshooting"]
tags = ["linux-audio", "pulseaudio", "usb-microphone", "sound-fix", "alsamixer"]
keywords = ["linux sound switch", "usb microphone default", "pulseaudio default output", "sound fix linux"]
+++


It looks like you're having an issue where when you plug in your USB microphone (UACDemoV10), your system switches to it as the default output device, causing no sound from your speakers. Here's how to fix this:

## Solution 1: Set Correct Default Device (PulseAudio)

```bash
# List PulseAudio sources and sinks
pacmd list-sinks
pacmd list-sources

# Set your internal sound card as default output
pacmd set-default-sink alsa_output.pci-0000_00_1f.3.analog-stereo

# Set USB microphone as default input only
pacmd set-default-source alsa_input.usb-0c76_UACDemoV1.0-00.analog-stereo
```

## Solution 2: Create PulseAudio Configuration File

Create or edit `~/.config/pulse/default.pa`:
```bash
# Set internal sound card as default
set-default-sink alsa_output.pci-0000_00_1f.3.analog-stereo
set-default-source alsa_input.usb-0c76_UACDemoV1.0-00.analog-stereo
```

## Solution 3: Use ALSA Configuration (More Permanent)

Edit `/etc/asound.conf` or `~/.asoundrc`:
```bash
# Add these lines
defaults.pcm.card 0
defaults.pcm.device 0
defaults.ctl.card 0

pcm.!default {
    type plug
    slave {
        pcm "hw:0,0"
    }
}

ctl.!default {
    type hw
    card 0
}
```

## Solution 4: Quick Fix via `pavucontrol` (GUI)

```bash
# Install if not already installed
sudo apt install pavucontrol  # Ubuntu/Debian
sudo pacman -S pavucontrol    # Arch
sudo dnf install pavucontrol  # Fedora

# Then run:
pavucontrol
```

In pavucontrol:
1. Go to "Configuration" tab
2. Set internal sound card to "Analog Stereo Duplex"
3. Set USB microphone to "Analog Mono Input" (or similar)
4. Go to "Output Devices" tab and select your internal sound card

## Solution 5: Temporary Workaround

When you need to use the USB microphone:
```bash
# For recording with USB mic
arecord -D plughw:1,0 -f cd test.wav

# For playback through internal sound card
aplay -D plughw:0,0 test.wav
```

## To permanently prevent the USB device from becoming default output:

Create a udev rule:
```bash
sudo nano /etc/udev/rules.d/85-usb-audio.rules
```

Add:
```
ACTION=="add", SUBSYSTEM=="sound", ATTRS{idVendor}=="0c76", ATTRS{idProduct}=="161e", ENV{PULSE_PROFILE_SET}="off"
```

Then reload:
```bash
sudo udevadm control --reload-rules
```

Would you like me to help you identify the exact PulseAudio device names for your system, or would you prefer one of these specific solutions?


If you use those exact commands, you might run into issues because:
1. Those device names are likely different on your system
2. The USB device might not support stereo output (it's a microphone)

Let's first check your actual PulseAudio device names:

```bash
# List all sinks (output devices)
pactl list short sinks

# List all sources (input devices)
pactl list short sources

# Alternatively, get more detailed info
pacmd list-sinks | grep -E "name:|device.description"
pacmd list-sources | grep -E "name:|device.description"
```

Run these commands and share the output. You should see something like:

For sinks (outputs):
```
alsa_output.pci-0000_00_1f.3.analog-stereo
alsa_output.usb-0c76_UACDemoV1.0-00.analog-stereo
```

For sources (inputs):
```
alsa_input.pci-0000_00_1f.3.analog-stereo
alsa_input.usb-0c76_UACDemoV1.0-00.analog-mono
```

## Based on your setup, here's what you should do:

**Step 1: Create the config file:**
```bash
mkdir -p ~/.config/pulse
nano ~/.config/pulse/default.pa
```

**Step 2: Add these lines (after checking your actual device names):**
```pulseaudio
### Automatically restore the volume of streams and devices
load-module module-stream-restore
load-module module-device-restore

### Make sure internal sound card is default for OUTPUT
set-default-sink alsa_output.pci-0000_00_1f.3.analog-stereo

### Make sure USB mic is default for INPUT
set-default-source alsa_input.usb-0c76_UACDemoV1.0-00.analog-mono

### Optional: Prevent PulseAudio from switching defaults when USB is plugged in
load-module module-switch-on-connect blacklist="regex:^.*UACDemo.*sink.*$"
```

**Step 3: If the exact names don't work, you can use index numbers:**
```bash
# Get the index numbers
pactl list short sinks
# Output might look like:
# 0	alsa_output.pci-0000_00_1f.3.analog-stereo
# 1	alsa_output.usb-0c76_UACDemoV1.0-00.analog-stereo

pactl list short sources
# Output might look like:
# 0	alsa_input.pci-0000_00_1f.3.analog-stereo
# 1	alsa_input.usb-0c76_UACDemoV1.0-00.analog-mono
```

Then in your `default.pa`:
```pulseaudio
# Set by index (0 = first sink, usually internal sound card)
set-default-sink 0
set-default-source 1
```

**Step 4: Restart PulseAudio:**
```bash
pulseaudio -k
# Wait a moment, it will auto-restart
# Or force restart:
pulseaudio --start
```

## Important Notes:
1. **USB microphones often don't have output capability** - PulseAudio might incorrectly think they do. The `module-switch-on-connect` line helps prevent this.

2. **Check if the USB device appears as both sink and source:**
   ```bash
   pactl list short sinks | grep UACDemo
   pactl list short sources | grep UACDemo
   ```

3. **If the USB device shows as a sink, you might want to disable it as an output:**
   ```bash
   # Find the sink index for USB
   pactl list short sinks | grep UACDemo
   # Output: 1	alsa_output.usb-0c76_UACDemoV1.0-00.analog-stereo

   # Disable it
   pactl set-sink-port 1 off
   ```

