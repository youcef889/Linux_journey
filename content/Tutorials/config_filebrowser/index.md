+++
title = "Filebrowser Configuration Guide - Complete Reference"
date = "2026-03-18T16:06:36+01:00"
draft = false
description = "Comprehensive guide to filebrowser configuration. Covers CLI flags, config file options, environment variables, and customization."
summary = "Complete reference for filebrowser configuration. Covers all CLI flags, configuration file options, and environment variables for self-hosted file browser."
slug = "filebrowser-configuration"
categories = ["Linux", "Self-Hosted", "File Management"]
tags = ["filebrowser", "configuration", "self-hosted", "file-manager"]
keywords = ["filebrowser config", "filebrowser setup", "self-hosted file manager"]
+++


`filebrowser` has many configurable options that you can use via command-line flags, environment variables, or a config file. Below is a comprehensive list of **commonly used CLI flags and configuration options**.

---

## ✅ Basic `filebrowser` Configuration Flags

These are the most important flags when running the `filebrowser` binary:

| Flag               | Description                                           |
| ------------------ | ----------------------------------------------------- |
| `-a`, `--address`  | The IP address to bind to (default: `0.0.0.0`)        |
| `-p`, `--port`     | The port to run the web server on (default: `8080`)   |
| `-d`, `--database` | Path to the `.db` file                                |
| `--root`           | Root directory for files (default: current directory) |
| `--config`         | Path to a JSON config file                            |
| `--log`            | Enable logging to file or stdout                      |
| `--cert`           | Path to TLS certificate file (for HTTPS)              |
| `--key`            | Path to TLS key file (for HTTPS)                      |
| `--locale`         | Language/locale (e.g., `en`, `fr`)                    |

---

## ✅ User Management Commands

You can manage users from CLI:

```bash
filebrowser users add <username> <password> [flags]
filebrowser users update <username> [flags]
filebrowser users rm <username>
filebrowser users list
```

User-related flags:

| Flag              | Description              |
| ----------------- | ------------------------ |
| `--scope`         | User's file access scope |
| `--locale`        | Default language         |
| `--perm.admin`    | Give admin privileges    |
| `--perm.create`   | Allow file creation      |
| `--perm.rename`   | Allow renaming           |
| `--perm.delete`   | Allow deletion           |
| `--perm.download` | Allow downloads          |
| `--perm.share`    | Allow sharing            |
| `--perm.execute`  | Allow command execution  |
| `--perm.modify`   | Allow modifying files    |
| `--perm.view`     | Allow viewing files      |
| `--perm.preview`  | Allow file preview       |

---

## ✅ Available Permissions (for `--perm.*`)

| Permission | Description                       |
| ---------- | --------------------------------- |
| `admin`    | Full access to settings and users |
| `create`   | Create new files/folders          |
| `rename`   | Rename files/folders              |
| `delete`   | Delete files/folders              |
| `download` | Download files                    |
| `share`    | Share files with a link           |
| `execute`  | Run shell commands                |
| `modify`   | Modify files                      |
| `view`     | View files in UI                  |
| `preview`  | Preview files in browser          |

---

## ✅ TLS (HTTPS) Support

To run with HTTPS:

```bash
filebrowser --cert /path/to/cert.pem --key /path/to/key.pem
```

You can generate a self-signed cert with:

```bash
openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days 365 -nodes
```

---

## ✅ Config File (Alternative to CLI)

You can create a JSON config file and load it with `--config`.

Example: `config.json`

```json
{
  "address": "192.168.1.3",
  "port": 8080,
  "log": "stdout",
  "database": "/srv/filebrowser/filebrowser.db",
  "root": "/srv/data"
}
```

Run it like this:

```bash
filebrowser --config /srv/filebrowser/config.json
```

---

## ✅ Environment Variables

You can also set settings via environment variables:

| Environment Variable | Equivalent CLI Flag |
| -------------------- | ------------------- |
| `FB_ADDRESS`         | `--address`         |
| `FB_PORT`            | `--port`            |
| `FB_DATABASE`        | `--database`        |
| `FB_ROOT`            | `--root`            |
| `FB_CERT`            | `--cert`            |
| `FB_KEY`             | `--key`             |

---

## ✅ Help Command

To get a full up-to-date list of flags and commands:

```bash
filebrowser --help
```

Or for subcommands:

```bash
filebrowser users --help
```

---

Would you like me to generate a default config file for you or help turn this into a systemd service?



Ah 👍 you already have the **default FileBrowser `settings.json`** (auto-generated).
That’s why you see only:

```json
{
  "port": 80,
  "baseURL": "",
  "address": "",
  "log": "stdout",
  "database": "/database/filebrowser.db",
  "root": "/srv"
}
```

This is the **basic config** (port, db path, root folder).
If you want **user registration (`signup`)**, you need to expand this file to include extra keys (like I showed before).

---

Here’s a **merged example** (keeping your current values + adding signup support):

```json
{
  "port": 80,
  "baseURL": "",
  "address": "",
  "log": "stdout",
  "database": "/database/filebrowser.db",
  "root": "/srv",
  "signup": true,
  "createUserDir": true,
  "branding": {
    "name": "My FileBrowser",
    "disableExternal": false
  },
  "defaults": {
    "scope": "/srv",
    "locale": "en",
    "viewMode": "list",
    "singleClick": false,
    "sorting": {
      "by": "name",
      "asc": true
    },
    "perm": {
      "admin": false,
      "execute": true,
      "create": true,
      "rename": true,
      "modify": true,
      "delete": true,
      "share": true,
      "download": true
    }
  }
}
```

---

### 🔹 Steps

1. Edit your `config/settings.json` and replace contents with the above.
2. Ensure permissions are correct:

   ```bash
   sudo chown 1000:1000 /home/youcef/docker_app/filebrowser/config/settings.json
   ```
3. Restart container:

   ```bash
   docker-compose down
   docker-compose up -d
   ```

Now when you go to `http://192.168.1.6:8080`, you should see a **Sign Up** button.

---

Security note: this makes registration open for **anyone on your LAN**.

