+++
date = '2026-03-18T16:06:36+01:00'
draft = false
title = 'How To Record With Ffmpeg'
categories = ["Notes", "Reference"]
tags = ["notes"]
+++


Let me break down each part of this FFmpeg command:

## **Command Breakdown:**

```
ffmpeg
```

### **1. Video Input (Screen Capture)**
```bash
-f x11grab                  # Input format: X11 screen grabbing
-s 1366x768                 # Screen resolution: 1366 pixels wide × 768 pixels tall
-i :0.0                     # Input source: Display 0, Screen 0 (main screen)
```

### **2. Audio Input (Microphone)**
```bash
-f pulse                    # Input format: PulseAudio (Linux sound server)
-i "alsa_input.usb-Jieli_Technology_UACDemoV1.0_F584CD1399EC5853-00.mono-fallback"
                            # PulseAudio device name for your USB microphone
                            # "mono-fallback" means it's a mono (single channel) device
```

### **3. Video Encoding Settings**
```bash
-c:v libx264                # Video codec: H.264 (x264 encoder)
-preset veryfast            # Encoding speed/quality tradeoff:
                            #   ultrafast → superfast → veryfast → faster → fast
                            #   → medium → slow → slower → veryslow
                            # "veryfast" = faster encoding, larger file size
-crf 23                     # Constant Rate Factor (quality):
                            #   0 = lossless (huge files)
                            #   18-28 = typical range
                            #   23 = good quality (default)
                            #   Lower = better quality, larger files
```

### **4. Audio Encoding Settings**
```bash
-c:a aac                    # Audio codec: AAC (Advanced Audio Coding)
-ac 1                       # Audio channels: 1 (mono) - matches your microphone
-ar 44100                   # Audio sample rate: 44.1kHz (CD quality)
# Note: No bitrate specified, so FFmpeg uses AAC default (~128kbps for stereo)
```

### **5. Output**
```bash
out.mkv                     # Output filename with .mkv container (Matroska)
                            # MKV supports multiple audio tracks, subtitles, etc.
```

## **What This Command Does:**
1. **Captures** your entire screen (1366×768 resolution)
2. **Records audio** from your USB microphone
3. **Encodes video** as H.264 with "veryfast" preset (good balance)
4. **Encodes audio** as AAC mono at 44.1kHz
5. **Saves** everything to `out.mkv` file

## **Equivalent/Alternative Options:**

**Add framerate (optional but recommended):**
```bash
-framerate 30              # Adds: Capture at 30 frames per second
```

**Specify audio bitrate explicitly:**
```bash
-b:a 128k                  # Sets audio bitrate to 128 kbps
```

**Use shorter names:**
```bash
-vcodec libx264            # Same as -c:v libx264
-acodec aac                # Same as -c:a aac
```

**Add timestamp (for debugging):**
```bash
-show_pts 1               # Shows timestamps in console (debugging)
```

## **Common Issues & Fixes:**

**If audio/video get out of sync:**
```bash
-async 1                  # Audio sync method
```

**If you want to limit file size:**
```bash
-b:v 2000k                # Video bitrate: 2000 kbps
-maxrate 2500k            # Maximum bitrate
-bufsize 5000k            # Buffer size
```

**To show progress during encoding:**
```bash
-progress pipe:1          # Shows encoding progress
```

## **Example with All Common Options:**
```bash
ffmpeg \
  -f x11grab -s 1366x768 -framerate 30 -i :0.0 \
  -f pulse -i "alsa_input.usb-Jieli_Technology_UACDemoV1.0_F584CD1399EC5853-00.mono-fallback" \
  -c:v libx264 -preset veryfast -crf 23 \
  -c:a aac -ac 1 -ar 44100 -b:a 128k \
  -async 1 \
  -y \
  out.mkv
```

**Where `-y` = overwrite output without asking**

## **To Play Back the Recording:**
```bash
ffplay out.mkv
# or
mpv out.mkv
# or
vlc out.mkv
```

This command gives you a good balance of quality, file size, and encoding speed for screen recording with microphone audio.


To record only  the audoi 
```
ffmpeg -f pulse -i "alsa_input.usb-Jieli_Technology_UACDemoV1.0_F584CD1399EC5853-00.mono-fallback"        -c:a aac -ac 1 -ar 44100 -b:a 128k        -y output.m4a

ffmpeg -f pulse -i "alsa_input.usb-Jieli_Technology_UACDemoV1.0_F584CD1399EC5853-00.mono-fallback"        -c:a aac -b:a 256k -ac 2 -ar 48000        output.m4a


```
