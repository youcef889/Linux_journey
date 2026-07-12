+++
title = "FFmpeg Screen Recording Script - Linux Guide"
date = "2026-03-18T16:06:36+01:00"
draft = true
description = "Learn how to use FFmpeg script for screen recording on Linux. Capture desktop with audio, microphone, and system sounds."
summary = "Guide to FFmpeg screen recording on Linux. Script breakdown for capturing desktop, microphone, and audio with real-time monitoring."
slug = "ffmpeg-screen-recording-script"
categories = ["Linux", "Media", "Recording"]
tags = ["ffmpeg", "screen-recording", "linux", "audio", "script"]
keywords = ["ffmpeg screen record", "linux screen capture", "record desktop ffmpeg"]
+++


This is a nice bash script for screen recording! It has some clever features. Let me explain and suggest improvements:

## **Current Script Analysis:**

### **What it does:**
1. **Toggles microphone mute** on/off when starting/stopping
2. **Records screen** to video file (lossless H.264)
3. **Records audio separately** to WAV file (with noise reduction)
4. **Shows status indicator** in dwmblocks
5. **Sends desktop notifications**
6. **Saves PIDs** to kill processes later

### **Current Issues:**
1. **Audio/video are separate files** - need to combine them later
2. **Uses ALSA `default`** - might not capture from USB mic when plugged in
3. **No audio in video file** - screen recording has no sound
4. **Lossless video** (`-qp 0`) creates huge files

## **Improved Version with USB Mic Support:**

```bash
#!/usr/bin/env bash

# Configuration - Set your USB mic device here
USB_MIC="alsa_input.usb-Jieli_Technology_UACDemoV1.0_F584CD1399EC5853-00.mono-fallback"
INTERNAL_MIC="alsa_input.pci-0000_00_1f.3.analog-stereo"

record() {
  # Toggle on mic
  amixer set Capture toggle

  # Get screen dimensions
  SCREEN_DIM=$(xdpyinfo | awk '/dimensions/{print $2}')
  
  # Check if USB mic is available, fallback to internal mic
  if pactl list short sources | grep -q "$USB_MIC"; then
    AUDIO_SOURCE="$USB_MIC"
    AUDIO_CHANNELS=1  # Mono
    echo "Using USB microphone"
  else
    AUDIO_SOURCE="$INTERNAL_MIC"
    AUDIO_CHANNELS=2  # Stereo
    echo "USB mic not found, using internal microphone"
  fi

  # Single file with both video and audio
  # Lossy compression (reasonable file size) with audio
  ffmpeg \
    -f x11grab -s "$SCREEN_DIM" -r 30 -i :0.0 \
    -f pulse -i "$AUDIO_SOURCE" \
    -c:v libx264 -preset veryfast -crf 23 \
    -c:a aac -ac "$AUDIO_CHANNELS" -ar 44100 -b:a 128k \
    -movflags +faststart \
    "$HOME/video_$(date '+%a__%b%d__%H_%M_%S').mkv" &
  
  echo $! > /tmp/recpid

  # Optional: Separate cleaned audio file (if you want it)
  ffmpeg \
    -f pulse -i "$AUDIO_SOURCE" \
    -af "afftdn=nf=-75" \
    "$HOME/audio_cleaned_$(date '+%a__%b%d__%H_%M_%S').wav" &
  
  echo $! > /tmp/audpid

  echo "Rec •" > /tmp/recordingicon && pkill -RTMIN+3 dwmblocks
  notify-send -t 500 -h string:bgcolor:#a3be8c "Recording started & mic toggled"
}

end() {
  kill -15 "$(cat /tmp/recpid)" 2>/dev/null
  kill -15 "$(cat /tmp/audpid)" 2>/dev/null
  rm -f /tmp/recpid /tmp/audpid

  amixer set Capture toggle

  echo "" > /tmp/recordingicon && pkill -RTMIN+3 dwmblocks

  # Optional: Combine files if you kept the separate recording approach
  # combine_audio_video
  
  notify-send -t 500 -h string:bgcolor:#bf616a "Recording ended & mic toggled"
}

# Optional function to combine separate audio/video files
combine_audio_video() {
  # Find the latest video and audio files
  LATEST_VIDEO=$(ls -t "$HOME"/video_*.mkv 2>/dev/null | head -1)
  LATEST_AUDIO=$(ls -t "$HOME"/audio_*.wav 2>/dev/null | head -1)
  
  if [[ -f "$LATEST_VIDEO" && -f "$LATEST_AUDIO" ]]; then
    OUTPUT="${LATEST_VIDEO%.mkv}_combined.mkv"
    ffmpeg -i "$LATEST_VIDEO" -i "$LATEST_AUDIO" -c copy "$OUTPUT"
    echo "Combined file created: $OUTPUT"
  fi
}

# If the recording pid exists, end recording. If not, start recording
([[ -f /tmp/recpid ]] && end && exit 0) || record
```

## **Key Improvements:**

1. **Single file output** - Video and audio in one MKV file
2. **Automatic USB mic detection** - Uses USB if available, falls back to internal
3. **Proper audio channels** - Mono for USB mic, stereo for internal
4. **Reasonable file size** - Uses CRF 23 instead of lossless
5. **Faststart for web** - `-movflags +faststart` makes videos streamable

## **Alternative: Keep Separate Files But Sync Them:**

If you prefer separate files for editing flexibility:

```bash
# In record() function:
# Record screen with reference audio track (low quality)
ffmpeg \
  -f x11grab -s "$SCREEN_DIM" -r 30 -i :0.0 \
  -f pulse -i "$AUDIO_SOURCE" \
  -c:v libx264 -preset veryfast -crf 23 \
  -c:a aac -ac "$AUDIO_CHANNELS" -ar 44100 -b:a 32k \
  "$HOME/video_$(date '+%a__%b%d__%H_%M_%S').mkv" &

# High quality cleaned audio separately
ffmpeg \
  -f pulse -i "$AUDIO_SOURCE" \
  -af "afftdn=nf=-75" \
  -c:a pcm_s16le \
  "$HOME/audio_$(date '+%a__%b%d__%H_%M_%S').wav" &
```

## **Additional Features You Could Add:**

```bash
# Add to record() function for region recording:
region_record() {
  # Use slurp to select region
  REGION=$(slurp)
  ffmpeg -f x11grab -video_size "$REGION" -i ":0.0+${REGION%%+*}" ...
}

# Add recording timer:
show_timer() {
  while [[ -f /tmp/recpid ]]; do
    DURATION=$((SECONDS - START_TIME))
    printf "Rec %02d:%02d •" $((DURATION/60)) $((DURATION%60)) > /tmp/recordingicon
    pkill -RTMIN+3 dwmblocks
    sleep 1
  done
}
# Call show_timer & after starting ffmpeg
```

## **To Use the Improved Script:**
1. Save it as `~/bin/record-screen.sh`
2. Make executable: `chmod +x ~/bin/record-screen.sh`
3. Bind to a hotkey in your window manager

The script will now properly use your USB microphone when it's plugged in!
