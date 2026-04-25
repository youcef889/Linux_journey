+++
title = "Install LineageOS 20 on Samsung Galaxy M20 - TWRP Guide"
date = "2026-03-18T16:06:36+01:00"
draft = false
description = "Learn how to install LineageOS 20 on Samsung Galaxy M20 (SM-M20). Step-by-step TWRP recovery and ROM installation."
summary = "Complete guide to installing LineageOS 20 on Samsung Galaxy M20. Covers TWRP flash, ROM transfer, and LineageOS installation with steps to avoid soft-brick."
slug = "install-lineageos-samsung-galaxy-m20"
categories = ["Mobile", "Android", "LineageOS"]
tags = ["lineageos", "samsung", "twrp", "android", "custom-rom"]
keywords = ["lineageos galaxy m20", "install lineageos m20", "twrp samsung m20"]
+++


Got it 👍 You want to install **TWRP recovery** on your Samsung Galaxy M20 (SM-M205F) using Linux. I’ll break it down step by step.

⚠️ **Warning:** Installing TWRP will trip Knox (no going back), may void warranty, and if done incorrectly can soft-brick your phone. Backup your data first.

---

## 🔹 Requirements

1. **Unlocked Bootloader**

   * Enable **Developer Options** → enable **OEM Unlock**.
   * Boot into **Download Mode** (Volume Up + Volume Down while plugging USB) → confirm bootloader unlock.
   * This will wipe your data.

2. **Tools on Linux**

   ```bash
   sudo apt install adb fastboot heimdall-flash
   ```

   * `adb` = Android Debug Bridge
   * `heimdall` = Open-source alternative to Odin for Linux

3. **TWRP Image**

   * Download the latest `.img` or `.tar` for **Samsung Galaxy M20 (m20lte / SM-M205F)** from [TWRP official](https://twrp.me/Devices/) or [XDA](https://forum.xda-developers.com).
   * Example: `twrp-3.x.x-m20lte.img` or `twrp-3.x.x-m20lte.tar`.

---

## 🔹 Steps to Install TWRP

### 1. Reboot to Download Mode

```bash
adb reboot bootloader
```

Or, power off → hold **Volume Down + Volume Up** and connect USB cable.

---

### 2. Flash TWRP using Heimdall

If you have a `.tar` file (for Odin/Heimdall):

```bash
heimdall flash --RECOVERY twrp-3.x.x-m20lte.img --no-reboot
```

⚠️ Use the `.img` inside the `.tar`. If you only have `.img`, use it directly:

```bash
heimdall flash --RECOVERY twrp-3.x.x-m20lte.img --no-reboot
```

---

### 3. Boot into TWRP Immediately

* After flashing, **do not let the phone boot normally** (it will overwrite TWRP).
* Instead, hold **Power + Volume Up** until TWRP boots.

---

### 4. Disable Stock Recovery Replace

* In TWRP → if prompted, allow modifications.
* To prevent Samsung from replacing TWRP, flash **Disable DM-Verity / Force Encryption** zip (e.g., `vbmeta.img` patch or `no-verity-opt-encrypt.zip`) and optionally **Magisk** for root.

---

✅ Done! You now have TWRP installed on your Galaxy M20.

---

If you are not in recovery, reboot into recovery:

    With the device powered off, hold Volume Up + Power.

Now tap Factory Reset, then Format data / factory reset and continue with the formatting process. This will remove encryption and delete all files stored in the internal storage, as well as format your cache partition (if you have one).
Return to the main menu.
Sideload the LineageOS .zip package but do not reboot to system before you read/followed the rest of the instructions!

    On the device, select “Apply Update”, then “Apply from ADB” to begin sideload.




Installing LineageOS from recovery

    Build a LineageOS installation package.
    If you are not in recovery, reboot into recovery:
        With the device powered off, hold Volume Up + Power.
    Now tap Factory Reset, then Format data / factory reset and continue with the formatting process. This will remove encryption and delete all files stored in the internal storage, as well as format your cache partition (if you have one).
    Return to the main menu.
    Sideload the LineageOS .zip package but do not reboot to system before you read/followed the rest of the instructions!
        On the device, select “Apply Update”, then “Apply from ADB” to begin sideload.
        On the host machine, sideload the package using:

         adb -d sideload /path/to/zip

        check
        Tip: Normally, adb reports Total xfer: 1.00x, but in some cases, even if the process succeeds, the output may stop at 47% and show adb: failed to read command: Success. In other instances, it might display adb: failed to read command: No error or adb: failed to read command: Undefined error: 0 which is also fine.


```
    adb devices
    adb reboot bootloader
    heimdall flash --RECOVERY  lineage-19.1-20220504-recovery-m20lte.img --no-reboot
    heimdall print-pit
    
    sudo heimdall detect
    sudo heimdall detect
    heimdall flash --RECOVERY  lineage-19.1-20220504-recovery-m20lte.img --no-reboot
    sudo heimdall detect
    adb sideload  MindTheGapps-13.0.0-arm64-20231025_200931.zip
    adb devices
    adb devices
    adb sideload  MindTheGapps-13.0.0-arm64-20231025_200931.zip
    clear
    adb reboot bootloader
    sudo heimdall detect
    sudo heimdall detect
    heimdall flash --RECOVERY  lineage-19.1-20220504-recovery-m20lte.img --no-reboot
    adb sideload Magisk-v30.6.apk
```
