+++
title = "Linux System Information Commands - Complete Reference"
date = "2026-03-18T16:06:37+01:00"
draft = false
description = "Comprehensive list of Linux commands to get system information. Covers CPU, RAM, disk, GPU, network, and hardware info tools."
summary = "Complete reference for Linux system information commands. Learn to use lscpu, free, df, lsblk, lspci, ip, and other tools for monitoring."
slug = "linux-system-info-commands"
categories = ["Linux", "Reference", "Commands"]
tags = ["linux", "system-info", "commands", "monitoring", "hardware"]
keywords = ["linux system commands", "check cpu linux", "check ram linux", "system monitoring", "linux hardware info"]
+++


Here's a comprehensive list of **command-line tools** to gather system information like **RAM, CPU, storage, devices**, etc., on a **Linux machine**:

---

### 🧠 **CPU Information**

| Command             | Description                                                     |
| ------------------- | --------------------------------------------------------------- |
| `lscpu`             | Displays CPU architecture details (cores, threads, model, etc.) |
| `cat /proc/cpuinfo` | Raw CPU information (model, vendor, MHz, etc.)                  |
| `nproc`             | Shows number of processing units (cores) available              |
| `top` or `htop`     | Real-time CPU usage (use `htop` for a better UI)                |

---

### 💾 **RAM Information**

| Command             | Description                                         |
| ------------------- | --------------------------------------------------- |
| `free -h`           | Shows free, used, and total memory (human-readable) |
| `cat /proc/meminfo` | Detailed memory information                         |
| `vmstat`            | Memory, swap, I/O, and CPU usage                    |
| `top` or `htop`     | Real-time RAM usage                                 |

---

### 💽 **Disk and Partition Info**

| Command        | Description                              |
| -------------- | ---------------------------------------- |
| `df -h`        | Shows disk space usage per mount point   |
| `lsblk`        | Lists block devices (drives, partitions) |
| `fdisk -l`     | Lists disk partitions (requires sudo)    |
| `du -sh /path` | Shows disk usage of a folder             |
| `mount`        | Lists all mounted file systems           |

---

### 🖥️ **GPU Information**

| Command      | Description                               |                                                     |
| ------------ | ----------------------------------------- | --------------------------------------------------- |
| \`lspci      | grep -i vga\`                             | Lists GPU info (vendor, model)                      |
| \`glxinfo    | grep "OpenGL"\`                           | OpenGL version and renderer (requires `mesa-utils`) |
| `nvidia-smi` | For NVIDIA GPUs (requires NVIDIA drivers) |                                                     |

---

### 📡 **Network Information**

| Command                                 | Description                                          |
| --------------------------------------- | ---------------------------------------------------- |
| `ip a`                                  | Shows IP addresses and network interfaces            |
| `ip link`                               | Network interfaces and status                        |
| `ifconfig`                              | (Old) Shows interfaces and IPs (install `net-tools`) |
| `ss -tuln`                              | Listening ports and connections                      |
| `nmcli`                                 | NetworkManager CLI tool                              |
| `ping`, `traceroute`, `dig`, `nslookup` | Networking tools                                     |

---

### 🔧 **System & Hardware Information**

| Command                     | Description                                    |
| --------------------------- | ---------------------------------------------- |
| `uname -a`                  | Kernel version, architecture                   |
| `hostnamectl`               | Shows hostname, OS, kernel                     |
| `uptime`                    | Shows system uptime                            |
| `dmesg`                     | Kernel ring buffer (hardware-related logs)     |
| `lsb_release -a`            | Distro info (may need `lsb-release` package)   |
| `neofetch` or `screenfetch` | Stylish summary of system info                 |
| `inxi -Fx`                  | Very detailed system info (install `inxi`)     |
| `lshw`                      | Lists detailed hardware info (run with `sudo`) |
| `lsusb`                     | Lists USB devices                              |
| `lspci`                     | Lists PCI devices                              |

---

### 🧰 **Combined Tools**

| Command              | Description                                             |
| -------------------- | ------------------------------------------------------- |
| `htop`               | Interactive system monitor (CPU, RAM, processes)        |
| `glances`            | Real-time, multi-resource monitor (CPU, RAM, disk, net) |
| `bpytop` / `bashtop` | Pretty top-like system monitor                          |

---

### ✅ **Recommended Combo for Daily Use**

```bash
lscpu && free -h && lsblk && df -h && ip a && uname -a
```

---


