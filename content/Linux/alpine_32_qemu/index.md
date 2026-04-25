+++
title = "Run Alpine Linux 32-bit on QEMU - Complete Guide"
date = "2026-03-18T16:06:37+01:00"
draft = false
description = "Learn how to run Alpine Linux 32-bit on QEMU virtual machine. Step-by-step installation, networking, and SSH access guide."
summary = "Complete guide to running Alpine Linux 32-bit on QEMU. Covers disk image creation, ISO boot, installation, and SSH configuration."
slug = "alpine-linux-32-bit-qemu"
categories = ["Virtualization", "QEMU", "Alpine Linux"]
tags = ["alpine-linux", "qemu", "32-bit", "virtualization", "vm"]
keywords = ["alpine linux qemu", "alpine 32 bit qemu", "qemu alpine", "run alpine in vm"]
+++


Running Alpine Linux (32-bit) on QEMU is a straightforward process. Below are the steps to set up and run Alpine Linux in a QEMU virtual machine.

### Prerequisites

1. **QEMU Installed**: Ensure you have QEMU installed on your host machine. You can install it using your package manager. For example, on Ubuntu, you can run:
   ```bash
   sudo apt install qemu
   ```

2. **Alpine Linux ISO**: Download the latest 32-bit Alpine Linux ISO from the [Alpine Linux downloads page](https://alpinelinux.org/downloads/).

### Step 1: Create a Disk Image

You need to create a virtual disk image where Alpine Linux will be installed. You can create a disk image using the following command:

```bash
qemu-img create -f qcow2 alpine.img 2G
```

This command creates a 2GB disk image named `alpine.img`. You can adjust the size as needed.

### Step 2: Boot Alpine Linux in QEMU

Now, you can boot the Alpine Linux ISO using QEMU and the disk image you just created. Use the following command:

```bash
qemu-system-i386 -boot d -cdrom alpine-<version>-x86.iso -hda alpine.img -m 512 -net nic -net user
```

Replace `<version>` with the actual version number of the Alpine ISO you downloaded. This command does the following:

- `-boot d`: Boots from the CD-ROM (ISO).
- `-cdrom alpine-<version>-x86.iso`: Specifies the Alpine Linux ISO file.
- `-hda alpine.img`: Specifies the virtual hard disk image.
- `-m 512`: Allocates 512 MB of RAM to the virtual machine.
- `-net nic -net user`: Sets up user-mode networking.

### Step 3: Install Alpine Linux

1. **Boot from the ISO**: When you run the QEMU command, it will boot from the Alpine Linux ISO.
2. **Follow the Installation Instructions**: Once the Alpine Linux boot menu appears, select the option to install Alpine Linux. Follow the prompts to set up your system:
   - Choose the keyboard layout.
   - Set up the network (you can use DHCP).
   - Partition the disk (you can use the default options).
   - Format the partitions and install the system.
   - Set the root password and configure any additional settings as prompted.

### Step 4: Reboot into the Installed System

After the installation is complete, you will be prompted to reboot. Before rebooting, make sure to remove the ISO from the boot sequence. You can do this by running the following command:

```bash
qemu-system-i386 -boot c -hda alpine.img -m 512 -net nic -net user
```
or 
```
qemu-system-x86_64 \
  -hda alpine.img \
  -m 1024 \
  -net nic \
  -net user,hostfwd=tcp::2222-:22

```
To  run the vm with no display and  open the ssh  on port 2222 and  the port 8000 to run flask app  if is needed 

```
qemu-system-i386 -hda alpine.img -m 2048 -smp 2 -display none -serial stdio -net nic -net user,hostfwd=tcp::2222-:22,hostfwd=tcp::8080-:80

```
This command will boot from the hard disk instead of the CD-ROM.

### Step 5: Log In

Once the system boots, you can log in with the root user and the password you set during installation.

Or 

You can  ssh to the VM using  this command 

```
ssh -p 2222 user@localhost
```
