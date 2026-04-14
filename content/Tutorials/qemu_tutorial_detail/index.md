+++
date = '2026-03-18T16:06:37+01:00'
draft = false
title = 'Qemu Tutorial Detail'
categories = ["Virtualization"]
tags = ["virtualization", "qemu", "vm"]
+++


# 🧠 What Is QEMU?

**QEMU** (Quick EMUlator) is a **generic and open-source emulator and virtualizer**.

### 🧰 QEMU Has Two Main Modes:

1. **Emulation Mode**:

   * Emulates one hardware architecture on another (e.g., ARM on x86).
   * No hardware acceleration — slower but portable.

2. **Virtualization Mode (with KVM)**:

   * Runs guest OSes using your CPU's virtualization features (Intel VT-x, AMD-V).
   * Requires `KVM` and a Linux host.
   * Much faster, near-native performance.

---

## 🖥️ Real-World Use Cases

| Use Case              | Description                                                        |
| --------------------- | ------------------------------------------------------------------ |
| OS Development        | Test kernels or bootloaders without rebooting your PC.             |
| Embedded Development  | Emulate ARM, RISC-V, MIPS boards on x86.                           |
| CI Testing            | Run headless QEMU in GitHub Actions, Jenkins, etc.                 |
| Server Virtualization | Lightweight VMs for dev/staging.                                   |
| Try New OS            | Test Linux/BSD distros or even Windows without touching your host. |

---

# ✅ Installing QEMU in Detail

## 🐧 On Ubuntu/Debian:

```bash
sudo apt update
sudo apt install qemu qemu-kvm libvirt-daemon-system virtinst bridge-utils virt-manager
```

* `qemu`: Core QEMU binaries
* `qemu-kvm`: KVM support for acceleration
* `libvirt-*`: Tools for managing VMs
* `virt-manager`: GUI tool to manage virtual machines

## 🔍 Verify Installation:

```bash
qemu-system-x86_64 --version
```

---

# 🏗️ Step-by-Step VM Creation (x86 Example)

## 🔹 Step 1: Create a virtual disk

```bash
qemu-img create -f qcow2 myvm.qcow2 20G
```

* `qcow2`: QEMU's optimized disk format (supports snapshots, compression)
* `20G`: Disk size

## 🔹 Step 2: Download an ISO (e.g., Ubuntu, Debian, TinyCore, etc.)

Example:

```bash
wget https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-*.iso
```

## 🔹 Step 3: Start VM with ISO

```bash
qemu-system-x86_64 \
  -hda myvm.qcow2 \
  -cdrom debian.iso \
  -boot d \
  -m 2048 \
  -smp 2 \
  -enable-kvm \
  -cpu host
```

| Option        | Meaning                                 |
| ------------- | --------------------------------------- |
| `-boot d`     | Boot from CD-ROM                        |
| `-m 2048`     | 2GB RAM                                 |
| `-smp 2`      | 2 CPU cores                             |
| `-enable-kvm` | Enables hardware acceleration           |
| `-cpu host`   | Uses your host's CPU features in the VM |

---

# 💡 Running QEMU Without GUI (Headless)

## 📦 `-nographic`

```bash
qemu-system-x86_64 -hda myvm.qcow2 -m 1024 -nographic
```

* Redirects serial output to your terminal.
* Useful for server OS installs.

### Combine with serial monitor:

```bash
-serial mon:stdio
```

Example:

```bash
qemu-system-x86_64 -hda myvm.qcow2 -m 1024 -nographic -serial mon:stdio
```

---

# 🌐 Networking Setup

## 🧾 Basic NAT Networking

```bash
-net nic -net user
```

Adds a virtual NIC and uses user-mode NAT networking.

## 🔌 Port Forwarding (e.g., SSH into VM):

```bash
-net nic -net user,hostfwd=tcp::2222-:22
```

Then SSH into guest:

```bash
ssh -p 2222 user@localhost
```

---

# 🔄 Snapshot Support

```bash
qemu-system-x86_64 -hda myvm.qcow2 -snapshot
```

* All changes are temporary.
* Use for testing risky software/configs.

---

# 🔗 Sharing Files Between Host and Guest

## Using 9p VirtIO (Linux guest):

### On host:

```bash
qemu-system-x86_64 \
  -hda myvm.qcow2 \
  -net nic -net user \
  -virtfs local,path=/home/user/shared,security_model=passthrough,mount_tag=hostshare
```

### Inside guest:

```bash
sudo mount -t 9p -o trans=virtio hostshare /mnt
```

---

# ⚙️ Emulating Other Architectures

## 🧬 ARM Example:

```bash
qemu-system-arm -M versatilepb -m 256 \
-kernel kernel-qemu -hda raspbian.img \
-append "root=/dev/sda2 rootfstype=ext4 rw" \
-serial stdio -display none
```

* `-M versatilepb`: Emulated ARM board
* `-kernel`: Bootloader kernel image
* `-append`: Boot parameters

## 🐏 RISC-V Example:

```bash
qemu-system-riscv64 \
-machine virt \
-nographic \
-m 1G \
-kernel bbl \
-drive file=rootfs.ext2,format=raw,id=hd0 \
-device virtio-blk-device,drive=hd0
```

---

# 📊 Disk Image Management

### Convert a raw disk to qcow2:

```bash
qemu-img convert -f raw -O qcow2 disk.img disk.qcow2
```

### Resize a disk:

```bash
qemu-img resize myvm.qcow2 +10G
```

---

# 🔒 Secure and Isolated Testing

You can run potentially dangerous software inside a QEMU VM with `-snapshot` and no network:

```bash
qemu-system-x86_64 -hda malware.qcow2 -snapshot -net none
```

---

# 🧪 Bonus: Run QEMU in Daemon Mode

Run VM in the background:

```bash
qemu-system-x86_64 -hda myvm.qcow2 -m 1024 -daemonize
```

Control VM via QEMU monitor socket or SSH.

---

# 🛑 Stop and Kill QEMU VMs

List QEMU instances:

```bash
ps aux | grep qemu
```

Kill them:

```bash
kill <pid>
```

---

# 📁 QEMU vs VirtualBox vs KVM

| Feature              | QEMU                   | VirtualBox | KVM                   |
| -------------------- | ---------------------- | ---------- | --------------------- |
| GUI                  | ❌ (CLI)                | ✅          | ❌ (with virt-manager) |
| Headless             | ✅                      | ✅          | ✅                     |
| Cross-Arch Emulation | ✅                      | ❌          | ❌                     |
| Speed                | Medium (fast with KVM) | Good       | Very fast             |
| Snapshot Support     | ✅                      | ✅          | ✅                     |

---

# 🧭 Summary: What You Can Do with QEMU

✅ Run Linux or BSD headlessly
✅ Emulate ARM/RISC-V boards
✅ Build custom test environments
✅ Automate CI pipelines
✅ Use with Docker for full-stack testing
✅ Perfect for OS/driver/kernel development

---

Great! Let's now dive into **advanced QEMU usage**, focusing on topics like:

* Custom CPU models
* BIOS/UEFI boot
* TPM passthrough
* Multiple networks/interfaces
* Advanced QMP (QEMU Machine Protocol) and monitor control
* Running QEMU as a systemd service
* Creating templates for reproducible virtual labs
* Automation with cloud-init and preseed
* QEMU performance tuning

---

# 🧠 1. **Custom CPU Models and Feature Masking**

### Use a specific CPU model:

```bash
qemu-system-x86_64 -cpu Skylake-Client
```

### Use your host CPU and enable all features:

```bash
-cpu host,+vmx,+aes,+sse4.2
```

### See available CPU models:

```bash
qemu-system-x86_64 -cpu help
```

This is helpful when the guest OS depends on specific features like virtualization, AES instructions, or AVX.

---

# 🧰 2. **BIOS vs UEFI Boot**

## BIOS Boot (Default):

QEMU uses **SeaBIOS** by default:

```bash
qemu-system-x86_64 -hda disk.qcow2
```

## UEFI Boot:

Use OVMF firmware:

### 📦 Install OVMF (on Ubuntu):

```bash
sudo apt install ovmf
```

### ✅ Boot with UEFI:

```bash
qemu-system-x86_64 \
  -drive if=pflash,format=raw,readonly=on,file=/usr/share/OVMF/OVMF_CODE.fd \
  -drive if=pflash,format=raw,file=OVMF_VARS.fd \
  -hda disk.qcow2
```

---

# 🔐 3. **TPM Passthrough (for Secure Boot / Windows 11)**

### Step 1: Install swtpm

```bash
sudo apt install swtpm
```

### Step 2: Create a TPM socket and launch QEMU:

```bash
swtpm socket --tpm2 --ctrl type=unixio,path=/tmp/swtpm-sock &

qemu-system-x86_64 \
  -chardev socket,id=chrtpm,path=/tmp/swtpm-sock \
  -tpmdev emulator,id=tpm0,chardev=chrtpm \
  -device tpm-tis,tpmdev=tpm0 \
  -hda win11.qcow2
```

This makes Windows 11 or secure-boot Linux guests work.

---

# 🌐 4. **Advanced Networking**

### ✅ Multiple Interfaces:

```bash
-netdev user,id=net0 -device e1000,netdev=net0 \
-netdev user,id=net1 -device rtl8139,netdev=net1
```

### 🛠 Tap + Bridge Networking (host integration):

1. Create a tap interface:

```bash
sudo ip tuntap add dev tap0 mode tap
sudo ip link set tap0 up
```

2. Attach to QEMU:

```bash
-netdev tap,id=net0,ifname=tap0,script=no,downscript=no -device virtio-net,netdev=net0
```

For persistent setup, use **bridge-utils** or **systemd-networkd**.

---

# 🧪 5. **Monitor, QMP, and Live Control**

### ⌨️ Human-readable Monitor:

```bash
-monitor stdio
```

### 🧠 QMP JSON API:

Enable the machine protocol interface:

```bash
-qmp unix:/tmp/qmp-sock,server,nowait
```

### Send QMP commands:

Use `socat`:

```bash
socat - UNIX-CONNECT:/tmp/qmp-sock
```

Then send:

```json
{ "execute": "query-status" }
```

QMP lets you:

* Hot-plug CPUs, memory, disks
* Query VM info in JSON
* Integrate with libvirt, Ansible

---

# 🧰 6. **Running QEMU as a Systemd Service**

Create a service file:

```ini
[Unit]
Description=QEMU VM
After=network.target

[Service]
ExecStart=/usr/bin/qemu-system-x86_64 -hda /var/lib/vms/ubuntu.qcow2 -m 2048 -enable-kvm -nographic
Restart=always

[Install]
WantedBy=multi-user.target
```

Save as `/etc/systemd/system/qemu-vm.service`, then:

```bash
sudo systemctl enable --now qemu-vm
```

Perfect for headless servers.

---

# 📦 7. **Use Cloud-Init for VM Provisioning**

1. Download cloud image:

```bash
wget https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img
```

2. Create cloud-init ISO:

```bash
cloud-localds user-data.img user-data
```

3. Boot with cloud-init:

```bash
qemu-system-x86_64 \
  -drive file=jammy-server-cloudimg-amd64.img,format=qcow2 \
  -drive file=user-data.img,format=raw \
  -net nic -net user,hostfwd=tcp::2222-:22 \
  -enable-kvm -m 2048
```

Cloud-init automates:

* User creation
* SSH key injection
* Package install
* Custom scripts

---

# ⚡ 8. **Performance Tuning**

### Use `virtio` devices:

```bash
-device virtio-blk-pci,drive=hd -drive file=vm.qcow2,if=none,id=hd
```

### Use cache=none for best disk performance:

```bash
-drive file=vm.qcow2,if=virtio,cache=none
```

### Use hugepages:

```bash
-m 4096 -mem-path /dev/hugepages -mem-prealloc
```

Enable hugepages on host:

```bash
echo 256 > /proc/sys/vm/nr_hugepages
```

---

# 📁 9. **Templates for Lab Automation**

### Create a reusable VM template:

1. Install Linux into a qcow2 image.
2. Don't autologin or add user config.
3. Use `cloud-init` or `kickstart/preseed` to auto-configure cloned VMs.
4. Clone with:

```bash
qemu-img create -f qcow2 -b base.qcow2 newlab.qcow2
```

Linked clones make dev labs fast and space-efficient.

---

# 🧠 10. **Other Tips**

* Combine with **virt-manager** or **libvirt** for hybrid GUI/CLI use.
* Use **SPICE** instead of VNC for better graphics:

  ```bash
  -spice port=5930,disable-ticketing
  ```
* Add USB devices:

  ```bash
  -usb -device usb-host,hostbus=1,hostaddr=2
  ```



