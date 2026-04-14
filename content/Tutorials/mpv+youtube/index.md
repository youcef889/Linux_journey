+++
date = '2026-03-18T16:06:37+01:00'
draft = false
title = 'Mpv+youtube'
categories = ["Notes", "Reference"]
tags = ["notes"]
+++


Using **mpv with YouTube** is a popular way to watch videos from the terminal with fewer ads, keyboard control, and high performance. mpv relies on **yt-dlp** (or sometimes youtube-dl) to fetch the stream.

Here’s the full setup and usage.

---

## ✅ 1) Install mpv and yt-dlp

On Linux:

### Debian / Ubuntu

```bash
sudo apt install mpv yt-dlp
```

### Arch

```bash
sudo pacman -S mpv yt-dlp
```

### Void Linux

```bash
sudo xbps-install -S mpv yt-dlp
```

### Alpine

```bash
sudo apk add mpv yt-dlp
```

---

## ▶️ 2) Play a YouTube Video

Just pass the URL:

```bash
mpv https://www.youtube.com/watch?v=VIDEO_ID
```

mpv automatically calls yt-dlp and starts streaming.

---

## 📺 3) Play in Best Quality / Limit Resolution

### Force max 1080p:

```bash
mpv --ytdl-format="bestvideo[height<=1080]+bestaudio/best" URL
```

### 720p:

```bash
mpv --ytdl-format="best[height<=720]" URL
```

---

## 🔊 4) Audio Only (Music / Podcasts)

```bash
mpv --no-video URL
```

Or:

```bash
mpv --ytdl-format=bestaudio URL
```

---

## 📃 5) Play a Playlist

mpv handles playlists automatically:

```bash
mpv https://www.youtube.com/playlist?list=XXXXX
```

Limit number of videos:

```bash
mpv --playlist-start=1 --playlist-end=10 URL
```

---

## ⏯️ Useful mpv Keys

While playing:

| Key   | Action     |
| ----- | ---------- |
| Space | Pause      |
| ← / → | Seek 5s    |
| ↑ / ↓ | Seek 1 min |
| 9 / 0 | Volume     |
| f     | Fullscreen |
| q     | Quit       |
| s     | Screenshot |

---

## ⚙️ 6) Recommended Config

Create:

```bash
mkdir -p ~/.config/mpv
nano ~/.config/mpv/mpv.conf
```

Example:

```
hwdec=auto
ytdl-format=bestvideo+bestaudio/best
cache=yes
cache-secs=30
```

---

## ❗ If YouTube Stops Working

Usually YouTube changes something—update yt-dlp:

```bash
yt-dlp -U
```

or via package manager:

```bash
sudo xbps-install -Su yt-dlp
```

---

## 🧠 Extra Tips

### Use cookies (for age-restricted/private videos):

Export cookies from your browser, then:

```bash
mpv --cookies --cookies-file cookies.txt URL
```

---

### Download instead of stream:

```bash
yt-dlp URL
```

---

If you want, tell me:

* Which Linux distro you’re on?
* Are you trying to **stream**, **download**, fix an **error**, or get **1080p/4K** working?

I can tailor it for your setup 👍

