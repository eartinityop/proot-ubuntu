#!/usr/bin/env bash

# Install proot 
apt download proot
mkdir proot
mkdir ~/bin
dpkg -x proot*.deb ~/proot
cd proot/usr/bin
mv proot ~/bin
export PATH="$HOME/bin:$PATH"

# Detect the machine architecture
ARCH=$(uname -m)

if [ "$ARCH" = "x86_64" ]; then
  ARCH_ALT=x86_64
elif [ "$ARCH" = "aarch64" ]; then
  ARCH_ALT=x86_64
else
  printf "Unsupported CPU architecture: ${ARCH}"
  exit 1
fi

# Fetch Ubuntu rootfs image as per the machine architecture and install Ubuntu 
cd 
mkdir ubuntu
wget https://github.com/termux/proot-distro/releases/download/v4.8.0/ubuntu-focal-$ARCH_ALT-pd-v4.8.0.tar.xz
tar -xf ubuntu*.xz -C ubuntu
proot -r ubuntu/ubuntu* -0 /bin/bash
