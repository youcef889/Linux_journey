+++
date = '2026-05-28T11:27:08+01:00'
draft = false
title = 'How to Install Docker on Void Linux Step by Step'
description = 'Learn how to install Docker on Void Linux step by step, enable the Docker service, and run Docker commands as a non-root user.'
summary='How to Install Docker on Void Linux' 
slug = 'install-docker-on-void-linux'
tags = ['docker', 'void-linux', 'linux', 'containers', 'devops']
categories = ['Linux', 'Docker']
robots = "index, follow" 
keywords=["docker","void-linux"]
+++

# How to Install Docker on Void Linux Step by Step

Docker makes it easy to build, deploy, and manage containerized applications. In this guide, you will learn how to install Docker on Void Linux, enable the Docker service, and configure Docker for non-root users.

## Prerequisites

Before installing Docker, make sure you:

* Have a working Void Linux system
* Have sudo privileges
* Have an internet connection

## Update Your System

First, update your package database and upgrade installed packages.

```bash
sudo xbps-install -Su
```

If updates are available, confirm the installation and wait for the process to finish.

## Install Docker on Void Linux

Install Docker using the XBPS package manager.

```bash
sudo xbps-install -S docker
```

This command installs the Docker Engine and required dependencies.

## Enable the Docker Service

Void Linux uses `runit` instead of `systemd`. To enable the Docker service, create a symbolic link to the service directory.

```bash
sudo ln -s /etc/sv/docker /var/service/
```

## Start and Check Docker Status

Verify that the Docker service is running.

```bash
sudo sv status docker
```

You should see output similar to:

```text
run: docker: (pid 1234) 10s
```

## Run Docker Without sudo

By default, Docker commands require root privileges. Add your user to the `docker` group to run Docker commands without `sudo`.

```bash
sudo usermod -aG docker $USER
```

Apply the new group membership without rebooting.

```bash
newgrp docker
```

## Verify Docker Installation

Run the following command to verify Docker is working correctly.

```bash
docker run hello-world
```

If Docker is installed correctly, you will see a confirmation message from the Docker container.

## Why Use Docker on Void Linux?

Docker allows you to:

* Run isolated applications
* Simplify development environments
* Deploy applications consistently
* Manage containers efficiently

Void Linux is lightweight and fast, making it a good choice for containerized workloads.

## Troubleshooting

### Docker Command Not Found

Log out and log back in after adding your user to the Docker group.

### Docker Service Not Running

Check whether the service link exists.

```bash
ls -l /var/service/docker
```

Restart the service if needed.

```bash
sudo sv restart docker
```

## Conclusion

You have successfully installed Docker on Void Linux and configured it for everyday use. You can now start running containers and building containerized applications on your system.

For more advanced configuration and usage, visit the official Docker documentation.

* [Docker Documentation](https://docs.docker.com/)

