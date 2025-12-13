+++
date = '2025-11-06T16:48:19+01:00'
draft = false
title = 'Setup wireless adapter on alpine linux with wpa supplicant'
summary=  'how  to setup wireless adapter on alpine linux wpa supplicant'
categories =["tutorial","Network","Guide","linux"]
tags=['alpine linux','linux','Network']
+++

To get a **MediaTek 802.11n WLAN adapter** working on **Alpine Linux**, you'll typically need to install firmware and drivers for the wireless chipset, and bring up the network interface using tools like `iw` and `wpa_supplicant`.

![My wifi adapter](my_adapter_wifi.webp "wifi adapter")

### Step-by-Step Guide

#### 1. **Identify Your Chipset**

Run the following to identify your MediaTek Wi-Fi chipset:

```sh
lspci | grep -i network
# or for USB dongles:
lsusb
```

Look for lines like:

```
MediaTek MT7601U 802.11 n WLAN Adapter
```

#### 2. **Enable Community Repository**

Make sure the community repo is enabled in `/etc/apk/repositories`:

```sh
vi /etc/apk/repositories
```

Uncomment or add this line:

```
http://dl-cdn.alpinelinux.org/alpine/latest-stable/community
```

Then update:

```sh
apk update
```

#### 3. **Install Required Packages**

Install drivers, firmware, and Wi-Fi tools:

```sh
apk add linux-firmware wireless-tools iw wpa_supplicant
```

#### 4. **Check if the Driver is Loaded**

Run:

```sh
dmesg | grep mt
lsmod | grep mt
```

You may need one of these kernel modules:

* `mt7601u`
* `mt76x0u`
* `mt76`

To load a module manually:

```sh
modprobe mt7601u
```

Check if the interface appears:

```sh
ip link
```

You should see something like `wlan0`.

---

### Connect to Wi-Fi (wpa\_supplicant method)

Create `/etc/wpa_supplicant/wpa_supplicant.conf`:

```conf
ctrl_interface=/var/run/wpa_supplicant
network={
    ssid="YourNetworkName"
    psk="YourPassword"
}
```

Then start `wpa_supplicant`:

```sh
wpa_supplicant -B -i wlan0 -c /etc/wpa_supplicant/wpa_supplicant.conf
```

Get an IP:

```sh
udhcpc -i wlan0
```

---

### Tips

* For headless systems, use `wpa_cli` or configure `wpa_supplicant.conf` manually.
* For GUI systems (with X or Wayland), you can use `networkmanager` or `connman`.
* Check logs via:

```sh
dmesg | tail
```

---

### For Persistent Setup

To ensure Wi-Fi connects at boot:

1. Add `wpa_supplicant` and `udhcpc` to OpenRC:

```sh
rc-update add wpa_supplicant
rc-update add networking
```

2. Ensure `wpa_supplicant.conf` is correctly placed and permissions are set.

---

### Not Working?

If it's not working :

* Check `dmesg` for errors. 
  `sudo dmesg`
* Your chipset might need an out-of-tree driver (rare on Alpine). 
