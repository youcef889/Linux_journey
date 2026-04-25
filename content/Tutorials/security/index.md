+++
title = "Common Linux Security Mistakes and How to Fix Them"
date = "2026-03-18T16:06:37+01:00"
draft = false
description = "Learn about common Linux security mistakes that users and administrators make. Covers root usage, password security, firewall, updates, and more."
summary = "Guide to common Linux security mistakes and their fixes. Covers running as root, weak passwords, missing firewalls, unpatched systems, and proper security practices."
slug = "common-linux-security-mistakes"
categories = ["Linux", "Security", "Best Practices"]
tags = ["linux-security", "security-mistakes", "hardening", "sysadmin", "firewall"]
keywords = ["linux security", "linux security mistakes", "secure linux", "system hardening", "security best practices"]
+++


common Linux security mistakes that users and administrators often make:

### **1. Running as Root Unnecessarily**  
   - Using the root account for daily tasks increases the risk of accidental system damage and exposure to malware.  
   - **Solution:** Use `sudo` instead of logging in as root.

### **2. Weak or Default Passwords**  
   - Using weak passwords or keeping default ones makes brute-force attacks easy.  
   - **Solution:** Use strong passwords and enable **multi-factor authentication (MFA)** where possible.

### **3. Ignoring System Updates**  
   - Not updating your system leaves it vulnerable to known exploits.  
   - **Solution:** Regularly update using `apt update && apt upgrade` (Debian-based) or `dnf upgrade` (RHEL-based).

### **4. Exposing SSH to the Internet Without Protection**  
   - Default SSH settings (port 22, password authentication) are an easy target for attackers.  
   - **Solution:**  
     - Change the default SSH port (`/etc/ssh/sshd_config`).  
     - Disable password authentication and use SSH keys.  
     - Use **Fail2Ban** to block brute-force attempts.  
     - Restrict access with `AllowUsers` or `AllowGroups`.

### **5. Running Unnecessary Services**  
   - Extra services increase the attack surface.  
   - **Solution:** Use `systemctl disable <service>` to disable unneeded services.

### **6. Misconfigured Firewall**  
   - Running a system without firewall rules leaves it exposed.  
   - **Solution:**  
     - Use **UFW** (`ufw enable` for Ubuntu) or **firewalld** (RHEL-based).  
     - Only allow required ports (`ufw allow 22/tcp` for SSH).  

### **7. Lack of File and Directory Permissions**  
   - Granting excessive permissions (`chmod 777`) to files and folders is a serious risk.  
   - **Solution:** Use the **principle of least privilege** (`chmod 750` for directories, `chmod 640` for files).  

### **8. Not Monitoring Logs**  
   - Ignoring logs means missing early signs of attacks.  
   - **Solution:**  
     - Regularly check `/var/log/auth.log`, `/var/log/syslog`, and `/var/log/secure`.  
     - Use **Logwatch** or **journalctl** for monitoring.

### **9. Using Outdated Software and Repositories**  
   - Older software may have security flaws.  
   - **Solution:** Use `apt update`, `dnf upgrade`, and avoid **untrusted** PPAs.

### **10. No Backups or Poor Backup Security**  
   - Not having backups makes recovery impossible after a breach.  
   - **Solution:**  
     - Automate backups with `rsync`, `BorgBackup`, or `Restic`.  
     - Store backups offsite and **encrypt** them.

