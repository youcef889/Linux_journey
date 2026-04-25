+++
title = "Transfer Files Over SSH - scp, rsync, sshfs Guide"
date = "2026-03-18T16:06:36+01:00"
draft = false
description = "Learn how to transfer files between systems over SSH. Covers scp, rsync, sshfs, and FileZilla SFTP methods."
summary = "Complete guide to file transfer over SSH. Covers scp, rsync, sshfs mounting, and FileZilla SFTP client for secure file sharing."
slug = "ssh-file-transfer-methods"
categories = ["Linux", "Networking", "SSH"]
tags = ["ssh", "scp", "rsync", "sshfs", "sftp", "file-transfer"]
keywords = ["ssh file transfer", "scp command", "rsync ssh", "sshfs mount", "sftp file transfer"]
+++


Thanks for sharing the detailed content from *Linux Handbook*! Here's a concise summary of the key methods discussed for uploading and downloading files over SSH:

---

### ✅ **Summary: Upload Files to Remote System Over SSH**

#### **1. `scp` (Secure Copy) — Easy but Deprecated**

* **Upload**:

  ```bash
  scp filename username@ip:/home/username/
  ```
* **Download**:

  ```bash
  scp username@ip:/home/username/filename .
  ```
* **Copy directories** (add `-r`):

  ```bash
  scp -r dir username@ip:/home/username/
  ```

#### **2. `rsync` — Reliable and Powerful**

* **Upload**:

  ```bash
  rsync filename username@ip:/home/username/
  ```
* **Download**:

  ```bash
  rsync username@ip:/home/username/filename .
  ```
* **Directories** (add `-r`):

  ```bash
  rsync -r dir username@ip:/home/username/
  ```

#### **3. `sshfs` — Mount Remote Filesystem**

* **Install**:

  ```bash
  sudo apt install sshfs
  ```
* **Mount**:

  ```bash
  mkdir mount_dir
  sshfs username@ip:/remote/path mount_dir
  ```
* **Unmount**:

  ```bash
  umount mount_dir
  ```

#### **4. GUI: FileZilla (SFTP Client)**

* Easy drag-and-drop interface.
* Configure via *File > Site Manager*.
* Enter SSH/SFTP details (IP, port, username, password).
* Remote on right, local on left — transfer with drag-and-drop.

---


