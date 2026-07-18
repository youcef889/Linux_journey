+++
title = "Install Pi-hole on Alpine Linux - Complete Guide"
date = "2026-03-18T16:06:37+01:00"
draft = false
description = "Learn how to install Pi-hole network-wide ad blocker on Alpine Linux. Configuration, router setup, and maintenance."
summary = "Guide to installing Pi-hole on Alpine Linux. Covers dependencies, installation, router DNS configuration, and admin interface access."
slug = "pihole-alpine-linux"
categories = ["Alpine Linux"]
tags = ["network"]
keywords = ["pi-hole alpine linux", "network ad blocker", "dns pi-hole", "alpine linux pihole"]
+++


Running Pi-hole on Alpine Linux is a bit different from other distributions, as Alpine is designed to be lightweight and uses `apk` for package management. Here’s how to set up Pi-hole on a 32-bit PC running Alpine Linux:

### Prerequisites

1. **Hardware**: A 32-bit PC.
2. **Operating System**: Alpine Linux installed.
3. **Network Connection**: Ensure your PC is connected to your network.

### Step 1: Install Alpine Linux

1. **Download Alpine Linux**: Get the latest 32-bit version from the [Alpine Linux website](https://alpinelinux.org/downloads/).
2. **Create a Bootable USB**: Use tools like Rufus or Etcher to create a bootable USB drive with the downloaded ISO.
3. **Install Alpine Linux**: Boot from the USB and follow the installation instructions to set up Alpine Linux.

### Step 2: Update Your System

Once Alpine Linux is installed, log in and update the package index:

```sh
sudo apk update
```

### Step 3: Install Required Packages

You will need to install some dependencies for Pi-hole. Run the following command:

```sh
sudo apk add git curl bash
```

### Step 4: Install Pi-hole

1. **Clone the Pi-hole Repository**: Use Git to clone the Pi-hole repository:

   ```sh
   git clone --depth 1 https://github.com/pi-hole/pi-hole.git /opt/pihole
   ```

2. **Navigate to the Pi-hole Directory**:

   ```sh
   cd /opt/pihole
   ```

3. **Run the Installer**: Start the installation script:

   ```sh
   sudo bash install.sh
   ```

4. **Follow the Installation Prompts**: The installer will guide you through the setup process. You will need to configure:
   - Static IP address for your Pi-hole.
   - DNS provider (you can choose from the list provided).
   - Privacy settings.
   - Any additional features you want to enable.

### Step 5: Configure Your Router

To ensure that all devices on your network use Pi-hole for DNS resolution, you need to configure your router:

1. **Access Router Settings**: Log in to your router's web interface (usually at `192.168.1.1` or `192.168.0.1`).
2. **Change DNS Settings**: Look for the DNS settings and set the primary DNS to the static IP address of your Pi-hole.
3. **Save Changes**: Save the settings and restart your router if necessary.

### Step 6: Access the Pi-hole Admin Interface

1. **Open a Web Browser**: On any device connected to your network, open a web browser.
2. **Go to Pi-hole Admin Page**: Enter `http://<your-pi-hole-ip>/admin` (replace `<your-pi-hole-ip>` with the static IP you assigned to your Pi-hole).
3. **Log In**: Use the password provided during installation to log in.

### Step 7: Monitor and Maintain

- Regularly check the Pi-hole admin interface for statistics and logs.
- Update Pi-hole and your system periodically to ensure security and performance.

### Troubleshooting

If you encounter issues:

- Check your network settings and ensure the static IP is correctly configured.
- Verify that your router is pointing to the correct DNS.
- Consult the Pi-hole documentation and community forums for additional support.

### Note

Keep in mind that Pi-hole is primarily designed to run on Debian-based systems, and while it can be installed on Alpine, you may encounter some compatibility issues or require additional configuration. Always refer to the official Pi-hole documentation for the most accurate and detailed instructions.
