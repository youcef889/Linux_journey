+++
title = "Linux Kernel Insights - What I Learned"
date = "2024-08-15"
draft = false
description = "Learnings about the Linux kernel. Covers kernel version checking, system calls, and kernel fundamentals."
summary = "Collection of insights about the Linux kernel. Covers checking kernel version, system calls, kernel modules, and core Linux kernel concepts."
slug = "linux-kernel-insights"
categories = ["Linux", "Kernel"]
tags = ["linux-kernel", "void-linux", "kernel", "linux-basics"]
keywords = ["linux kernel", "kernel version", "linux basics", "kernel concepts"]
author = "Youcef Bouaissi"
+++

# The Kernel  
### 1. **How to check the kernel version of a Linux system?**  

uname commend  print  system  infomation  

Run:
```sh
uname  -a  # print  all information  
uname  -r  # print  the kernel release 
uname  -v  # print the kernel version 

```
### 2. **List installed kernels**  

Run:

```sh
xbps-query -l | grep linux
```
or 
```
ls  /boot

```
### 3. **Remove older kernels**  
```sh
sudo xbps-remove -R linux6.6-6.6.21_1 linux6.6-6.6.77_1 linux6.12-6.12.13_1
```
or 

```
sudo rm  config-6.12.23_1  initramfs-6.12.23_1.img  vmlinuz-6.12.23_1
```

### 4. **Update GRUB** (if using GRUB)  
After removing old kernels, update GRUB so it doesn't list them:
```sh
sudo xbps-reconfigure -f grub
```
or

if you are using `grub-mkconfig`:

```sh

sudo grub-mkconfig -o /boot/grub/grub.cfg
```

