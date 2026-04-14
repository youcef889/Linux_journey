+++
date = '2026-03-18T16:06:40+01:00'
draft = false
title = 'Splits An Mp3 File Into 5 Minute Chunks Without Re Encoding'
categories = ["Notes", "Reference"]
tags = ["notes"]
+++


That `ffmpeg` command **splits an MP3 file into 5-minute chunks without re-encoding**. Here’s a clear breakdown:

### What each part does

* `-i input.mp3`
  Uses `input.mp3` as the source file.

* `-f segment`
  Tells ffmpeg to use the *segment* muxer (for splitting files).

* `-segment_time 300`
  Sets each segment to **300 seconds (5 minutes)**.

* `-c copy`
  Copies the audio stream as-is (fast, no quality loss).

* `output_%03d.mp3`
  Output filenames like:

  ```
  output_000.mp3
  output_001.mp3
  output_002.mp3
  ```

---

### Important things to know

* ⏱️ **Cut points depend on MP3 frame boundaries**
  Segments may not be *exactly* 300 seconds.

* ⚡ **Very fast** because it doesn’t re-encode.

---

### Common variations

**Start numbering at 1**

```bash
ffmpeg -i input.mp3 -f segment -segment_time 300 -segment_start_number 1 -c copy output_%03d.mp3
```

**Force exact 5-minute segments (re-encodes audio)**

```bash
ffmpeg -i input.mp3 -f segment -segment_time 300 -c:a libmp3lame output_%03d.mp3
```

**Split into 10-minute chunks**

```bash
ffmpeg -i input.mp3 -f segment -segment_time 600 -c copy output_%03d.mp3
```

**Split by timestamps listed in a file**

```bash
ffmpeg -i input.mp3 -f segment -segment_times 300,600,900 -c copy output_%03d.mp3
```

---

If you want:

* **exact cuts**
* **a different format**
* **preserve metadata**
* **split by silence instead of time**

tell me what you’re aiming for and I’ll tailor the command 👍

