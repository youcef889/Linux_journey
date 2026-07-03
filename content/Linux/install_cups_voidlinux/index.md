+++
title = "Install CUPS on Void Linux - Printer Setup Guide"
date = "2026-03-18T16:06:37+01:00"
draft = false
description = "Learn how to install and configure CUPS printer server on Void Linux. Web interface, service setup, and troubleshooting."
summary = "Complete guide to installing CUPS on Void Linux. Covers installation via XBPS, runit service configuration, web interface access, and printer management."
slug = "install-cups-void-linux"
categories = ["Linux", "Void Linux", "Hardware"]
tags = ["cups", "void-linux", "printer", "printing", "linux"]
keywords = ["cups void linux", "install printer void linux", "linux printing", "cups server"]
+++


On **Void Linux**, you can install and set up **CUPS** as follows:

---

### 🛠️ **Step 1: Install CUPS**

```bash
sudo xbps-install -S cups
```

If you need a GUI printer management tool (like for XFCE, GNOME, etc.), you can also install:

```bash
# Optional: CUPS GUI tools
sudo xbps-install -S system-config-printer
```

---

### 🔧 **Step 2: Enable and Start the CUPS service**

Before installing the printer templates, verify that your service supervisor is active. For a deeper breakdown on managing system links, see our tutorial on [Void Linux Runit Configuration](/linux/runit-service-management-void-linux/).

Void Linux uses **runit**, not systemd.

```bash
sudo ln -s /etc/sv/cupsd /var/service
```

To verify it's running:

```bash
sv status cupsd
```

---

### 🌐 **Step 3: Access the CUPS Web Interface**

Open your browser and go to:

```
http://localhost:631
```

---

### 👤 **Step 4: Add your user to the `lpadmin` group**

```bash
sudo usermod -aG lpadmin $USER
```

Then **log out and back in** for the changes to take effect.

---

