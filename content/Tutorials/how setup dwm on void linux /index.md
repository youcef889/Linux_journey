+++
date = '2025-08-16T12:43:06+01:00'
draft = false
title = 'How Setup Dwm and st on Void Linux '
summary=  'how to install dwm'
categories =["tutorial","linux"]
tags= ['void linux','suckless tools ']

+++
## How to install and configer Dwm on void linux 
### Why Dwm 
dwm (Dynamic Window Manager) is a minimalistic, lightweight window manager for X11. It has very few dependencies since it's designed to be simple and efficient.

### Dependencies 
first you should have  all this **Dependencies**:

```
git 
wget 
Xlib,libX11-devel
libXinerama-devel
freetype-devel
make 
gcc
libXft-devel
libXrandr-devel

```
### Installtion 
After installing dependencies, you can clone, configure, and build dwm ,st and dmenu:

#### Install Dwm 
```
mkdir programs
cd programs
# INSTALL dWM 
git clone https://git.suckless.org/dwm
cd dwm
sudo make clean install
```
#### Install ST  
```
git clone https://git.suckless.org/st
cd st 
sudo make clean install
cd ..
```
#### Install dmenu 
```
#INSTALL dmenu (like a program launcher) 
git clone https://git.suckless.org/dmenu
cd dmenu 
sudo make clean install
```


