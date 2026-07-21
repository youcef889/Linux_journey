+++
title = "Sound Setup on Void Linux "
date = "2026-03-18T16:06:37+01:00"
draft = false
description = "Complete guide to setting up sound on Void Linux. Covers ALSA, PulseAudio, and PipeWire installation and configuration."
summary = "Guide to configuring audio on Void Linux. Covers ALSA, PulseAudio, PipeWire setup, alsamixer, and troubleshooting sound issues."
slug = "sound-setup-void-linux"
categories = ["Linux", "Void Linux", "Audio"]
tags = ["void-linux", "sound", "alsa", "pulseaudio", "pipewire", "audio"]
keywords = ["void linux sound", "alsa void linux", "pulseaudio void linux", "pipewire_void_linux", "audio linux"]
+++


To set up sound on **Void Linux**, you usually need to install and configure **ALSA**, **PulseAudio**, or **PipeWire**, depending on your preferences. Here’s a full step-by-step guide to get basic and advanced audio working:

---

###  1. Check Your Audio Hardware

```bash
lspci | grep -i audio
```

Or, for USB devices:

```bash
lsusb
```

---

###  2. Install Audio Packages

Void Linux uses **runit**, so we'll avoid systemd-specific commands.

#### 🔹 For ALSA (basic sound):

```bash
sudo xbps-install -S alsa-utils alsa-lib
```

You can test ALSA:

```bash
aplay /usr/share/sounds/alsa/Front_Center.wav
```

#### 🔹 For PulseAudio (easier desktop audio control):

```bash
sudo xbps-install -S pulseaudio pulsemixer pavucontrol
```

Enable PulseAudio at login by adding this to `~/.xinitrc` or your desktop session autostart:

```bash
pulseaudio --start
```

#### 🔹 For PipeWire (modern alternative to PulseAudio):

```bash
sudo xbps-install -S pipewire wireplumber pipewire-pulse pavucontrol
```

Also, add to your autostart:

```bash
pipewire &
wireplumber &
```

Check PipeWire status:

```bash
pw-cli ls Node
```

---

###  3. Add Your User to the `audio` Group

```bash
sudo usermod -aG audio $USER
```

Log out and log back in.

---

###  4. Unmute and Set Volumes with `alsamixer`

Run:

```bash
alsamixer
```

* Press F6 to select the sound card
* Use arrow keys to raise volumes
* Press `M` to unmute anything muted

To save the settings:

```bash
sudo alsactl store
```

---

###  5. Test Audio Output

Play a test sound:

```bash
speaker-test -c2 -t wav
```

Or use:

```bash
aplay somefile.wav
mpv somefile.mp3
```

---

###  6. Check Permissions and Devices

Make sure your user can access `/dev/snd/*`:

```bash
ls -l /dev/snd
```

You should see `audio` as the group.

---

###  7. Troubleshooting Tips

* Use `pavucontrol` to switch output devices.
* Check if HDMI or headphone output is selected.
* If Firefox or another app has no sound, try:

  ```bash
  pulseaudio -k
  pulseaudio --start
  ```

---

###  Optional: Autostart in runit

Create runit services for PipeWire or PulseAudio if you want them system-wide:

```bash
sudo ln -s /etc/sv/pipewire /var/service/
```

---


## Accessing the Sound Settings Via GUI 
```
pavucontrol

```

