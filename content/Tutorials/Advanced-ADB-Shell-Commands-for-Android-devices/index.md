+++
title = "Advanced ADB Shell Commands for Android Devices"
date = "2026-03-18T16:06:39+01:00"
draft = false
description = "Comprehensive collection of advanced ADB shell commands for Android. Covers debugging, performance tuning, package management, and networking."
summary = "Advanced ADB shell commands for Android devices - both rooted and unrooted. Covers debugging, performance tuning, package control, logs, networking, and system inspection."
slug = "adb-shell-commands-android"
categories = ["Android", "Development", "ADB"]
tags = ["adb", "android", "shell", "debugging", "root"]
keywords = ["adb shell commands", "android adb", "adb debugging", "android shell", "root adb"]
+++


**practical collection of advanced ADB shell commands** you can use on Android devices—**both unrooted and rooted**—including debugging, performance tuning, package control, logs, networking, and system inspection.

I’ll separate them clearly:

---

### **1. Installing ADB**

1. **Download Platform-Tools**:

   * Official link: [Android SDK Platform-Tools](https://developer.android.com/studio/releases/platform-tools)
2. **Extract the ZIP file** to a folder on your computer.
3. **Add ADB to your system PATH** (optional but convenient):

   * On Windows: add the folder path to Environment Variables → Path.
   * On Linux/Mac: add `export PATH=$PATH:/path/to/platform-tools` to your `.bashrc` or `.zshrc`.

---

### **2. Enabling Developer Options on Android**

1. Go to **Settings → About Phone → Build Number**.
2. Tap **Build Number** 7 times until it says "You are now a developer!"
3. Go back to **Settings → System → Developer Options**.
4. Enable **USB Debugging**.

---

### **3. Basic ADB Commands**

After connecting your device via USB:

* **Check device connection**

  ```bash
  adb devices
  ```

  This lists all connected devices. You may need to **allow USB debugging** on your phone when prompted.

* **Install an APK**

  ```bash
  adb install appname.apk
  ```

* **Uninstall an app**

  ```bash
  adb uninstall com.example.app
  ```

* **Copy files to/from device**

  ```bash
  adb push localfile /sdcard/remote_file
  adb pull /sdcard/remote_file localfile
  ```

* **Open a shell on the device**

  ```bash
  adb shell
  ```

* **Reboot the device**

  ```bash
  adb reboot
  ```

---

### **4. Advanced Usage**

* **Logcat (view system logs)**

  ```bash
  adb logcat
  ```
* **Screen recording**

  ```bash
  adb shell screenrecord /sdcard/demo.mp4
  ```
* **Backup & restore**

  ```bash
  adb backup -apk -all -f backup.ab
  adb restore backup.ab
  ```

---

### **5. Wireless ADB**

1. Connect device via USB.
2. Enable TCP/IP mode:

   ```bash
   adb tcpip 5555
   ```
3. Find your device IP:

   ```bash
   adb shell ip route
   ```
4. Connect wirelessly:

   ```bash
   adb connect DEVICE_IP:5555
   ```

---

# 🔹 Basics (Works on All Devices)

Enter shell:

```bash
adb shell
```

Check device info:

```bash
getprop ro.product.model
getprop ro.build.version.release
uname -a
```

Battery status:

```bash
dumpsys battery
```

Screen resolution & DPI:

```bash
wm size
wm density
```

Change temporarily:

```bash
wm size 1080x1920
wm density 420
```

Reset:

```bash
wm size reset
wm density reset
```

---

# 🔹 App & Package Management (Unrooted)

List installed packages:

```bash
pm list packages
```

With paths:

```bash
pm list packages -f
```

Find a package:

```bash
pm list packages | grep youtube
```

Disable system app for current user:

```bash
pm disable-user --user 0 com.package.name
```

Re-enable:

```bash
pm enable com.package.name
```

Uninstall for current user (safe debloat):

```bash
pm uninstall --user 0 com.facebook.katana
```

Clear app data:

```bash
pm clear com.package.name
```

Grant permission:

```bash
pm grant com.package.name android.permission.READ_LOGS
```

---

# 🔹 Activity & Intent Control

Launch app:

```bash
monkey -p com.package.name -c android.intent.category.LAUNCHER 1
```

Start activity:

```bash
am start -n com.pkg/.MainActivity
```

Send broadcast:

```bash
am broadcast -a android.intent.action.BOOT_COMPLETED
```

Force-stop:

```bash
am force-stop com.pkg
```

---

# 🔹 Logs & Debugging

Live logs:

```bash
logcat
```

Filter:

```bash
logcat ActivityManager:I *:S
```

Save to file:

```bash
logcat -d > /sdcard/log.txt
```

Kernel messages:

```bash
dmesg
```

System services:

```bash
dumpsys activity
dumpsys meminfo
dumpsys cpuinfo
```

---

# 🔹 Performance / Monitoring

Top processes:

```bash
top
```

CPU governor:

```bash
cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
```

RAM info:

```bash
cat /proc/meminfo
```

Thermal:

```bash
dumpsys thermalservice
```

FPS overlay:

```bash
dumpsys SurfaceFlinger --latency
```

---

# 🔹 Networking

IP address:

```bash
ip addr show wlan0
```

Ping:

```bash
ping google.com
```

Ports:

```bash
netstat -tulpn
```

DNS:

```bash
getprop net.dns1
```

---

# 🔹 File System Access (Limited Unrooted)

Browse:

```bash
ls /sdcard
```

Copy files:

```bash
cp /sdcard/file.txt /sdcard/Download/
```

Find files:

```bash
find /sdcard -name "*.mp4"
```

---

---

# 🔥 ROOT-ONLY ADB SHELL COMMANDS

Enter root shell:

```bash
adb shell
su
```

---

## 🛠️ System Mounting

Remount system writable:

```bash
mount -o rw,remount /
```

(Older):

```bash
mount -o rw,remount /system
```

Check mounts:

```bash
mount | grep system
```

---

## 🧹 Remove System App (dangerous)

```bash
rm -rf /system/app/AppName
rm -rf /system/priv-app/AppName
```

Better:

```bash
pm uninstall com.package
```

---

## ⚡ CPU Tweaks

Set governor:

```bash
echo performance > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
```

Disable core:

```bash
echo 0 > /sys/devices/system/cpu/cpu5/online
```

---

## 🔋 Battery Calibration (legacy)

```bash
rm /data/system/batterystats.bin
reboot
```

---

## 🕵️ Process Injection / Debug

List SELinux mode:

```bash
getenforce
```

Switch (temporary):

```bash
setenforce 0
```

---

## 🧬 System Properties

Change property:

```bash
setprop debug.hwui.renderer skiagl
```

View all:

```bash
getprop
```

---

# 🔹 Wireless Debugging Tricks

ADB over Wi-Fi:

```bash
adb tcpip 5555
adb connect 192.168.1.5
```

Stop:

```bash
adb usb
```

---

# 🔹 Screenshot / Screenrecord

Screenshot:

```bash
adb exec-out screencap -p > screen.png
```

Video:

```bash
adb shell screenrecord /sdcard/demo.mp4
```

---

# ⚠️ Important Warnings

Root commands can:

* Soft-brick devices
* Break OTA updates
* Trigger bootloops

Always backup before modifying `/system` or `/vendor`.

---

