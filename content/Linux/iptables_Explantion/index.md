+++
title = "Linux iptables Firewall Guide - Complete Tutorial"
date = "2026-03-18T16:06:37+01:00"
draft = false
description = "Master Linux iptables firewall with this comprehensive guide. Learn filter, NAT, and mangle tables, chains, rules, and practical examples for securing Linux systems."
summary = "Complete guide to Linux iptables firewall. Covers tables (filter, nat, mangle), chains (INPUT, OUTPUT, FORWARD), targets (ACCEPT, DROP, REJECT), and practical firewall rules."
slug = "linux-iptables-firewall"
categories = ["Linux", "Security", "Networking"]
tags = ["iptables", "firewall", "linux-security", "nat", "netfilter", "networking"]
keywords = ["iptables tutorial", "linux firewall", "iptables rules", "nat iptables", "secure linux"]
+++


# Iptables Explanation

## What is iptables?
Iptables is a user-space utility program that allows system administrators to configure the IP packet filter rules of the Linux kernel firewall. It serves as the front-end to the netfilter framework, which provides packet filtering, network address translation (NAT), and other packet mangling functions.

## Key Concepts

### Tables
Iptables uses different tables to organize rules based on their purpose:
1. **filter table** - Default table for packet filtering (INPUT, OUTPUT, FORWARD chains)
2. **nat table** - Used for network address translation (PREROUTING, POSTROUTING, OUTPUT chains)
3. **mangle table** - For specialized packet alteration (all chains)
4. **raw table** - For connection tracking exceptions (PREROUTING, OUTPUT chains)
5. **security table** - For mandatory access control (MAC) rules (all chains)

### Chains
Each table contains chains which are points where rules are applied:
- **INPUT** - Incoming traffic to the local system
- **OUTPUT** - Outgoing traffic from the local system
- **FORWARD** - Traffic routed through the system
- **PREROUTING** - Packets as they arrive (before routing decision)
- **POSTROUTING** - Packets before they leave (after routing decision)

### Rules
Rules define what to do with packets matching certain criteria. Each rule consists of:
- Matching criteria (source/destination IP, port, protocol, etc.)
- Target (what to do with matching packets)

### Targets
Common targets (actions) include:
- **ACCEPT** - Allow the packet
- **DROP** - Silently discard the packet
- **REJECT** - Discard and send error response
- **LOG** - Log the packet and continue processing
- **SNAT/DNAT** - Source/Destination NAT
- **MASQUERADE** - Special case of SNAT for dynamic IPs

## Common Commands

### Basic Operations
```bash
# List all rules
iptables -L -n -v

# List rules for specific table
iptables -t nat -L -n -v

# Flush all rules (delete all)
iptables -F

# Set default policy (DROP/ACCEPT)
iptables -P INPUT DROP
```

### Rule Management
```bash
# Append rule to chain
iptables -A INPUT -p tcp --dport 22 -j ACCEPT

# Insert rule at specific position
iptables -I INPUT 3 -p tcp --dport 80 -j ACCEPT

# Delete rule by number
iptables -D INPUT 2

# Delete all rules in chain
iptables -F INPUT
```

### Saving and Restoring
```bash
# Save rules (varies by distro)
iptables-save > /etc/iptables.rules

# Restore rules
iptables-restore < /etc/iptables.rules
```

## Example Rules

### Basic Firewall
```bash
# Set default policies
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

# Allow loopback
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

# Allow established connections
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# Allow SSH
iptables -A INPUT -p tcp --dport 22 -j ACCEPT

# Allow HTTP/HTTPS
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT

# Allow ping
iptables -A INPUT -p icmp --icmp-type echo-request -j ACCEPT
```

### NAT Example
```bash
# Enable IP forwarding
echo 1 > /proc/sys/net/ipv4/ip_forward

# NAT for internal network (eth1) to internet (eth0)
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
iptables -A FORWARD -i eth1 -o eth0 -j ACCEPT
iptables -A FORWARD -i eth0 -o eth1 -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
```

## Notes
- Iptables rules are processed in order from first to last
- The first matching rule determines the fate of the packet
- If no rules match, the chain's default policy is applied
- Iptables doesn't persist rules by default - they must be saved
- Modern Linux systems are moving to nftables as iptables' successor

