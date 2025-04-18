#!/bin/bash

set -e

# Check if the current system is Ubuntu
if ! grep -q "Ubuntu" /etc/os-release; then
  echo "This script can only run on Ubuntu systems."
  exit 1
fi

# Check if the current user is root
if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root."
  exit 1
fi

# Update package index
echo "Updating package index..."
apt-get update -yq
if [ $? -ne 0 ]; then
  echo "Failed to update package index."
  exit 1
fi

# Install packages
echo "Installing required packages..."
apt-get install --no-install-recommends -y \
  git \
  zsh \
  wget \
  aria2 \
  pkg-config \
  build-essential \
  language-pack-zh-hans \
  fonts-noto \
  fonts-noto-extra \
  fonts-noto-cjk \
  fonts-noto-cjk-extra \
  fonts-noto-ui-core \
  fonts-noto-ui-extra \
  fonts-noto-unhinted
if [ $? -ne 0 ]; then
  echo "Failed to install packages."
  exit 1
fi

# Clean up
echo "Cleaning up..."
apt-get clean
rm -rf /var/lib/apt/lists/*

echo "All packages installed successfully."
