+++
title = "Runit Service Management on Void Linux"
date = "2026-03-18T16:06:36+01:00"
draft = false
description = "Learn how to manage services with Runit on Void Linux. Commands for start, stop, restart, enable, and disable services."
summary = "Complete guide to Runit service management on Void Linux. Covers sv up, down, restart, status, and service enabling/disabling."
slug = "runit-service-management-void-linux"
categories = ["Linux", "Void Linux", "Runit"]
tags = ["runit", "void-linux", "service-management", "sv"]
keywords = ["runit void linux", "service management void", "sv command", "void linux services"]
+++


## Basic Usage 
### To start service
```
sv up  <services>
```
### To stop service
```
sv down   <services>

```
### To restart service
```
sv restart   <services>

```
### To get status of a service 
```
sv status  <services>
 
```


### To get status  about all serverces 

```
sv status /var/service/*
```
### Enabling  a sevices 
```
ln -s /etc/sv/<service> /var/service/
```
### To start a service  on  boot  
```
ln -s /etc/sv/<service> /etc/runit/runsvdir/default/
```
### To Disable A Service  
Remove  the symlink from the running runsvdir
```
rm /var/service/<service>
``` 
###  If the service is in default 
```
rm /etc/runit/runsvdir/default/<service>
```


