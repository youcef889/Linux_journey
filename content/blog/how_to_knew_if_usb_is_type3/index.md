+++
title = "Check USB Version Type on Linux - Type-C Guide"
date = "2026-03-18T16:06:41+01:00"
draft = true
description = "Learn how to check USB type and version on Linux. Identify USB 3.0, 3.1, and Type-C connections."
summary = "Guide to checking USB version and type on Linux. Use lsusb with bcdUSB to identify real USB speed and connection type."
slug = "check-usb-version-linux"
categories = ["Linux", "Hardware"]
tags = ["usb", "usb-type-c", "hardware", "linux"]
keywords = ["usb type", "usb version", "check usb linux", "usb 3.0", "usb type-c"]
+++


### To know type 
```
sudo lsusb -s Busnumber:diversnumber -v | grep -i "bcdUSB"
```

### To know the real speed  of the connection
```
udevadm info -a -n /dev/video1 | grep 'idProduct\|idVendor\|speed'
```
#### For example  

Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 001 Device 002: ID 8087:0a2b Intel Corp. Bluetooth wireless interface
Bus 001 Device 003: ID 0a5c:5832 Broadcom Corp. 5880
Bus 001 Device 004: ID 1bcf:2b96 Sunplus Innovation Technology Inc. Integrated_Webcam_HD
Bus 001 Device 010: ID abcd:1234 LogiLink UDisk flash drive
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub

```
sudo lsusb -s 001:010 -v | grep -i "bcdUSB"
````
