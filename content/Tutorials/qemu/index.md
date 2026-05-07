+++
title = "Setup KVM + QEMU + libvirt on Void Linux"
date = "2026-03-18T16:06:39+01:00"
draft = false
description = "Learn how to set up KVM, QEMU, and libvirt for virtualization on Void Linux. Complete guide for lightweight hypervisor."
summary = "Complete guide to setting up KVM + QEMU + libvirt on Void Linux. Covers hardware virtualization check, package installation, libvirt configuration, and VM management."
slug = "kvm-qemu-libvirt-void-linux"
categories = ["Linux", "Virtualization", "Void Linux"]
tags = ["kvm", "qemu", "libvirt", "virtualization", "void-linux"]
keywords = ["kvm void linux", "qemu virtualization", "libvirt setup", "vm void linux"]
+++


Setting up **virtualization in Void Linux** using **KVM + QEMU + libvirt** is totally doable and provides a solid lightweight hypervisor environment. 

---

## 1. **PrerDresden**
###  Check for hardware virtualization support
```bash
egrep -c '(vmx|svm)' /proc/cpuinfo
```
- Output should be `1` or more. If `0`, your CPU doesn’t support virtualization (or it's disabled in BIOS).

###  Enable virtualization in BIOS/UEFI
- Look for settings like **Intel VT-x** or **AMD-V** and enable them.

---

## 2. **Install Packages**

Void Linux uses `xbps`, so:

```bash
sudo xbps-install -S qemu libvirt virt-manager
sudo xbps-install -S  bridge-utils ebtables dnsmasq
```

You can also install optional UIs:

- `virt-manager` — GUI for managing VMs
- `virt-viewer` — lightweight viewer
- `qemu-ui-gtk` or `qemu-ui-sdl` if you're planning to use QEMU's graphical window directly.

---

## 3. **Enable and Start libvirtd**

Void uses `runit`, so enable the service:

```bash
sudo ln -s /etc/sv/libvirtd /var/service/
```

Check if it's running:

```bash
sudo sv status libvirtd
```

---

## 4. **Add Yourself to Groups**

To avoid needing `sudo` every time:

```bash
sudo usermod -aG libvirt,input,kvm $(whoami)
```

Then log out and back in (or `newgrp libvirt`).

---

##  5. **Networking Setup**

Libvirt usually creates a NAT bridge called `virbr0`. Check:

```bash
ip a | grep virbr0
```

If not present, restart the service and check again:

```bash
sudo sv restart libvirtd
```

---

##  6. **Create and Run a VM**

###  Option 1: Using `virt-manager` (GUI)
```bash
virt-manager
```
- Choose **"New VM"**, follow the wizard to select an ISO, allocate memory/disk, etc.

###  Option 2: Using `virt-install` (CLI)
Example:
```bash
virt-install \
  --name test-vm \
  --memory 2048 \
  --vcpus 2 \
  --disk size=10 \
  --cdrom /path/to/iso \
  --os-type linux \
  --os-variant ubuntu20.04 \
  --network network=default \
  --graphics spice
```

---

##  7. **Optional: Autostart VMs**
To make a VM auto-start on boot:
```bash
virsh autostart test-vm
```

---

##  Test KVM Acceleration

You can verify KVM is used:
```bash
virsh capabilities | grep -i kvm
```

Or for QEMU:
```bash
qemu-system-x86_64 -accel help
```

---

## Common Tips

- If you get errors about `/dev/kvm` permissions, check:
  ```bash
  ls -l /dev/kvm
  ```
  Ensure it's accessible by `kvm` group.

- To list VMs:
  ```bash
  virsh list --all
  ```

---

### Example: `qemu.sh`
```bash
#!/bin/bash

# Configuration
ISO_PATH="$1"                      # ISO passed as first argument
DISK_IMAGE="disk.qcow2"            # Disk image file
DISK_SIZE="10G"                    # Disk size if created
RAM="2048"                         # Memory in MB
CPUS="2"                           # Number of CPU cores
VM_NAME="qemu-vm"                  # VM name
UEFI_FIRMWARE="/usr/share/edk2/x64/OVMF_CODE.fd"  # Optional: for UEFI

# Check for ISO argument
if [ -z "$ISO_PATH" ]; then
    echo "Usage: $0 path_to_iso.iso"
    exit 1
fi

# Create disk if not exists
if [ ! -f "$DISK_IMAGE" ]; then
    echo "Creating disk image..."
    qemu-img create -f qcow2 "$DISK_IMAGE" "$DISK_SIZE"
fi

# Run VM
qemu-system-x86_64 \
    -enable-kvm \
    -m "$RAM" \
    -smp cpus="$CPUS" \
    -cpu host \
    -name "$VM_NAME" \
    -drive file="$DISK_IMAGE",format=qcow2 \
    -cdrom "$ISO_PATH" \
    -boot d \
    -vga virtio \
    -display gtk \
    -soundhw hda \
    -net nic -net user \
    -machine type=q35,accel=kvm \
    -rtc clock=host \
    -usb -device usb-tablet
```

---

###  Instructions

1. Save this script as `qemu.sh`
2. Make it executable:
   ```bash
   chmod +x qemu.sh
   ```
3. Run it with an ISO:
   ```bash
   ./qemu.sh ~/Downloads/debian.iso
   ```

---

