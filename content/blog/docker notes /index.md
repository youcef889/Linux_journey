+++
title = "Docker Commands and Notes - Quick Reference"
date = "2025-10-14T15:04:40+01:00"
draft = true
description = "Docker commands quick reference guide. Covers common Docker commands for images, containers, networking, and troubleshooting."
summary = "Quick reference for Docker commands. Covers image management, container operations, networking, and common Docker troubleshooting commands."
slug = "docker-commands-reference"
categories = ["Docker", "DevOps", "Reference"]
tags = ["docker", "containers", "devops", "dockerfiles"]
keywords = ["docker commands", "docker cheat sheet", "docker reference"]
+++
```
$ docker images --filter dangling=true

REPOSITORY    TAG       IMAGE ID       CREATED       SIZE
<none>        <none>    4fd34165afe0   7 days ago    14.5MB

```
A dangling image is an image that is no longer tagged and appears in
listings as <none>:<none>. A common way they occur is when
building a new image with a tag that already exists. When this
happens, Docker will build the new image, notice that an existing
image already has the same tag, remove the tag from the existing
image and give it to the new image.

Use the following command to return all images, but only display
repo, tag and size.
```
docker images --format "{{.Repository}}: {{.Tag}}: {{.Size}}"
```

