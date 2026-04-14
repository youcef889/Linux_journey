+++
date = '2026-03-18T16:06:39+01:00'
draft = false
title = 'Advanced Adb Shell Commands For Android Devices'
categories = ["Notes", "Reference"]
tags = ["notes"]
+++


Here’s a **practical collection of advanced ADB shell commands** you can use on Android devices—**both unrooted and rooted**—including debugging, performance tuning, package control, logs, networking, and system inspection.

I’ll separate them clearly:

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

If you want, I can also provide:

✅ **ADB debloating lists**
✅ **Magisk + ADB combo tricks**
✅ **Performance tuning scripts**
✅ **ADB security / forensics commands**
✅ **Phonelab / mobile forensics-style investigation commands**

Just tell me which direction you want 😎

