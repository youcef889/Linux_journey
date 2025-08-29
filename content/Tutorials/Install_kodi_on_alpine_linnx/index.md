---
title: "Install kodi on  alpine linux "
date: "2025-08-16"
tags: ["alpine liunx "] 
---


Running **Kodi** on **Alpine Linux** is possible, but it requires some extra steps because Alpine is a minimal distribution using **musl libc** and **busybox**, which can lead to compatibility issues with software designed for glibc-based distros like Ubuntu or Arch.

Here’s a guide to help you install Kodi on Alpine Linux:

---

### ✅ **Option 1: Install Kodi via `apk` (if available in community repo)**

First, enable the **community** repository:

1. Edit `/etc/apk/repositories` and uncomment or add the community repo line:

   ```sh
   http://dl-cdn.alpinelinux.org/alpine/v3.19/community
   ```

2. Update your system:

   ```sh
   sudo apk update
   ```

3. Try to install Kodi:

   ```sh
   sudo apk add kodi
   ```

⚠️ **Note:** As of writing, Kodi **may not be available** directly via APK in the default repos depending on the Alpine version. If the above doesn’t work:

---

### ✅ **Option 2: Build Kodi from Source (Advanced)**

Kodi can be compiled from source, but it has many dependencies. Here’s a simplified process:

#### 1. Install build dependencies:

```sh
sudo apk add alpine-sdk cmake git mesa-dev \
    libtool autoconf automake eudev-dev \
    libxrandr-dev libxinerama-dev libxkbcommon-dev \
    libx11-dev libxext-dev libinput-dev \
    libressl-dev python3-dev pulseaudio-dev \
    bluez-dev alsa-lib-dev ffmpeg-dev \
    libpng-dev lzo-dev curl-dev \
    dbus-dev libnfs-dev taglib-dev \
    libass-dev freetype-dev fribidi-dev
```

#### 2. Clone Kodi source:

```sh
git clone https://github.com/xbmc/xbmc.git
cd xbmc
```

#### 3. Run cmake and build:

```sh
mkdir build
cd build
cmake ..
make -j$(nproc)
sudo make install
```

#### 4. Run Kodi:

```sh
kodi
```

---

### ✅ **Option 3: Run Kodi in Docker on Alpine**

Alpine works well with containers. You can run Kodi in a Docker container with X11 support:

1. Install Docker:

   ```sh
   sudo apk add docker
   sudo service docker start
   ```

2. Run Kodi container:

   ```sh
   docker run -it --rm \
     --device /dev/dri \
     -e DISPLAY=$DISPLAY \
     -v /tmp/.X11-unix:/tmp/.X11-unix \
     ghcr.io/linuxserver/kodi
   ```

⚠️ This requires X11 to be running on the host. If you’re using Alpine in headless or server mode, use **Kodi's Web UI** or **MySQL backend** remotely.

---

### 🛠 Optional: Use Kodi without full DE (like with `xinit`)

If you want to run Kodi on Alpine with minimal resources:

1. Install Xorg:

   ```sh
   sudo apk add xorg-server xf86-video-vesa xf86-input-libinput
   ```

2. Set up `.xinitrc`:

   ```sh
   echo "exec kodi" > ~/.xinitrc
   startx
   ```

---

### 📦 Minimal Alpine Kodi Setup Summary:

| Task                  | Command                                   |
| --------------------- | ----------------------------------------- |
| Enable community repo | `vi /etc/apk/repositories`                |
| Update APK            | `apk update`                              |
| Try to install Kodi   | `apk add kodi` (may fail)                 |
| Build from source     | `git clone` + `cmake` + `make`            |
| Run via Docker        | `docker run -it ghcr.io/linuxserver/kodi` |
| Launch Kodi directly  | `startx` with `.xinitrc`                  |

---

Would you like me to help you **build a Kodi-based Alpine image** for Raspberry Pi or embedded use (e.g., e-reader/media center setup)?

