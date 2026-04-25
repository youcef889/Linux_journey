+++
title = "SSH to QEMU VM - Fix Host Key Verification Error"
date = "2026-03-18T16:06:37+01:00"
draft = false
description = "Learn how to resolve SSH host key verification errors when connecting to QEMU virtual machines. Fix known_hosts issues quickly."
summary = "Simple guide to fix SSH host key verification errors when connecting to QEMU VMs. Uses ssh-keygen to remove old keys and reconnect safely."
slug = "ssh-qemu-vm-fix"
categories = ["Virtualization", "QEMU", "How-To"]
tags = ["ssh", "qemu", "virtualization", "vm", "ssh-keys", "known-hosts"]
keywords = ["ssh qemu", "qemu ssh connection", "host key changed", "known_hosts", "qemu vm ssh"]
+++


This warning means the SSH host key for `localhost:2222` has changed since the last time you connected — very likely because:

* You **recreated or reinstalled the VM**, or
* You're using a **different VM on the same forwarded port** (2222).

This is a **normal safety feature** to prevent man-in-the-middle attacks, but since you're testing locally and **you control both host and guest**, it's safe to fix.

---

### ✅ To resolve the issue:

Edit the `known_hosts` file to remove the offending entry:

```bash
ssh-keygen -R [localhost]:2222
```

This will remove the old key from `~/.ssh/known_hosts`.

Then retry:

```bash
ssh -p 2222 user@localhost
```

The new key will be added, and the warning will go away.

---


