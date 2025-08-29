---
title: "Install an XMPP server on a 32-bit Debian system "
date: "2025-08-15"
draft: true
---

To install an XMPP server on a **32-bit Debian** system, you can use **Prosody**, a lightweight and efficient XMPP server that works well on low-resource systems, including 32-bit architectures.

---

### ✅ Step-by-Step: Install Prosody XMPP Server on 32-bit Debian

#### 1. **Update your system**

```bash
sudo apt update && sudo apt upgrade -y
```

#### 2. **Install Prosody**

Prosody is available in Debian's official repositories:

```bash
sudo apt install prosody -y
```

---

### 🛠️ Optional: Install additional modules

If you want more features like [mod\_http\_upload](https://modules.prosody.im/mod_http_upload.html), you'll need the `prosody-modules`:

```bash
sudo apt install prosody-modules -y
```

> Note: This package may not contain all the latest community modules. You can also clone the module repo manually if needed.

---

### 🔧 Configure Prosody

Edit the main config file:

```bash
sudo nano /etc/prosody/prosody.cfg.lua
```

Change or add the following (example):

```lua
admins = { "admin@example.com" }

VirtualHost "example.com"
    enabled = true
    ssl = {
        key = "/etc/prosody/certs/example.com.key";
        certificate = "/etc/prosody/certs/example.com.crt";
    }
```

You can also enable modules like:

```lua
modules_enabled = {
    "roster"; -- Allow users to have a roster (aka friends list)
    "saslauth"; -- Authentication for clients and servers
    "tls"; -- Add support for secure TLS on c2s/s2s connections
    "dialback"; -- s2s dialback support
    "disco"; -- Service discovery
    "carbons"; -- XEP-0280: Message Carbons
    "mam"; -- XEP-0313: Message Archive Management
    "offline"; -- Store offline messages
    "vcard"; -- Allow users to set vCards
    "private"; -- Private storage (for room bookmarks, etc.)
    "blocklist"; -- Allow users to block communications
    "http"; -- Needed for some web-based modules
    "bosh"; -- HTTP long-polling (for web clients)
}
```

---

### 👤 Add a User

```bash
sudo prosodyctl adduser user@example.com
```

You'll be prompted to set a password.

---

### 🔄 Restart Prosody

```bash
sudo systemctl restart prosody
```

---

### ✅ Confirm It's Running

```bash
sudo systemctl status prosody
```

You should see "active (running)".

---

### 🌐 Open Firewall (if needed)

If you're running a firewall (like `ufw`):

```bash
sudo ufw allow 5222/tcp   # XMPP client connections
sudo ufw allow 5269/tcp   # XMPP server-to-server connections
```

---

### 🧪 Test with a Client

You can now connect using an XMPP client like:

* **Gajim** (Linux, Windows)
* **Dino** (GTK client)
* **Conversations** (Android)

Use:

* Server: `example.com`
* Username: `user@example.com`
* Password: (what you set)

---

If you'd like to use **ejabberd** or **Openfire** instead, I can guide you with that too.

