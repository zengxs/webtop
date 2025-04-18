#!/bin/bash

MINIFORGE_VER=24.11.3-2
MINIFORGE_URL="https://github.com/conda-forge/miniforge/releases/download/${MINIFORGE_VER}/Miniforge3-${MINIFORGE_VER}-Linux-$(uname -m).sh"
TARGET_PATH="/tmp/miniforge.sh"

set -e

# Check if the current system is linux
if [[ "$OSTYPE" != "linux-gnu"* ]]; then
  echo "This script is only for Linux systems."
  exit 1
fi

# Check if the current user is root
if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root."
  exit 1
fi

# Download the Miniforge installer
echo "Downloading Miniforge from ${MINIFORGE_URL}"
wget -q --show-progress --progress=bar:force:noscroll "$MINIFORGE_URL" -O "$TARGET_PATH"
if [ $? -ne 0 ]; then
  echo "Failed to download Miniforge installer."
  exit 1
fi

# Make the installer executable
chmod +x "$TARGET_PATH"

# Install Miniforge silently
echo "Installing Miniforge..."
bash "$TARGET_PATH" -b -p "/opt/miniforge3"
if [ $? -ne 0 ]; then
  echo "Failed to install Miniforge."
  exit 1
fi

# Create default environment
echo "Creating default conda environment..."
/opt/miniforge3/bin/mamba create -n default -y python=3.10
if [ $? -ne 0 ]; then
  echo "Failed to create default conda environment."
  exit 1
fi

# Install packages in the default environment
echo "Installing packages in the default conda environment..."
/opt/miniforge3/bin/mamba install -n default -y \
  beautifulsoup4 \
  cryptography \
  fastapi \
  grpcio \
  grpcio-tools \
  httpx \
  ipython \
  lxml \
  mysqlclient \
  pillow \
  pydantic \
  protobuf \
  playwright \
  pyarrow \
  python-dotenv \
  pyinstaller \
  pymongo \
  tokenizers \
  tenacity \
  openpyxl \
  openai \
  orjson \
  requests \
  sqlalchemy \
  termcolor \
  go \
  just \
  go-task

if [ $? -ne 0 ]; then
  echo "Failed to install packages in the default conda environment."
  exit 1
fi

# Clean up
echo "Cleaning up..."
rm -f "$TARGET_PATH"
