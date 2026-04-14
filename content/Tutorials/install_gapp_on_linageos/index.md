+++
date = '2026-03-18T16:06:40+01:00'
draft = false
title = 'Install Gapp On Linageos'
categories = ["Mobile", "Android"]
tags = ["android", "adb", "mobile"]
+++


After installing **LineageOS**, Google Apps (GApps) are **not included by default**, so you must flash them separately from recovery.

Here’s the **safe and correct way** to install GApps 👇

---

## ✅ What You Need First

Before installing:

1. ✔ LineageOS already flashed
2. ✔ Custom recovery installed (TWRP or Lineage Recovery)
3. ✔ Correct GApps package:

   * **Android version must match** your LineageOS build
     (e.g., LineageOS 20 → Android 13 → GApps for Android 13)
   * **Architecture must match** your phone:

     * `arm`
     * `arm64`
     * `x86 / x86_64` (rare, tablets/emulators)

Popular GApps providers:

* **MindTheGapps** (recommended for LineageOS)
* NikGApps
* OpenGApps (older Android versions)

---

## 📲 Installation Steps

### 🔹 1. Boot into Recovery

Power off → then press the hardware key combo for your phone
(usually **Volume Up + Power**)

---

### 🔹 2. (Optional) Wipe Cache

In recovery:

* Wipe → **Dalvik / ART Cache**
* Wipe → **Cache**

⚠ Do NOT wipe System or Data unless starting fresh.

---

### 🔹 3. Flash GApps ZIP

In recovery:

**TWRP:**

```
Install → select GApps.zip → Swipe to flash
```

**Lineage Recovery:**

```
Apply update → Apply from storage → select GApps.zip
```

---

### 🔹 4. Reboot System

After flashing finishes:

```
Reboot → System
```

First boot may take several minutes ⏳—this is normal.

---

## ⚠ Important Notes

### 🔴 Install GApps BEFORE first boot (best practice)

If possible:

* Flash LineageOS
* Flash GApps
* THEN reboot

Booting LineageOS first without GApps can sometimes cause setup problems.

---

## 🛠 If You Already Booted Without GApps

Usually still fine:

1. Reboot to recovery
2. Flash the GApps ZIP
3. Wipe Dalvik/Cache
4. Reboot

---

## ❓Common Problems

### ❌ Bootloop after GApps

→ Wrong Android version or wrong architecture
→ Reflash ROM + correct GApps

### ❌ “Insufficient system partition size”

→ Use **smaller GApps package** (pico / core)

### ❌ Google Setup crashes

→ Clear data of:

* Google Play Services
* Google App
* Play Store
  (from Settings → Apps)

---

If you want, tell me:

• Your phone model 📱
• LineageOS version
• Android version

and I can give **exact GApps package recommendations** for your device 👍


If  you have  allreade  install LineageOS on you system  you need  only  to enable developer Opetions   and  
enable Usb debugging   than install  adbtools on your  system  after  that  connect to you pc  with usb-data calbe  and  run :
```
adb devivces  

``` 
then you will get  
```
> adb devices
List of devices attached
32011f68b70c46db        device

```
after that run 
```
adb reboot bootloader 
``` 
### Download  
Lineage Recovery For Samsung Galaxy M20

Place it on your PC  

lineage-19.1-20220504-recovery-m20lte.img

### Boot Into Recovery
Power off → Volume Up + Power to boot into TWRP or Lineage Recovery.

go Advanced → ADB Sideload → Swipe to start 
```
adb sideload  GApps.zip
```