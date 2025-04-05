#!/bin/bash

set -e

export ZDOTDIR=/workspace

# Check if the current system is Ubuntu
if ! grep -q "Ubuntu" /etc/os-release; then
  echo "This script can only run on Ubuntu systems."
  exit 1
fi

# Change default shell to zsh
echo "Changing default shell to zsh..."
sudo chsh -s $(which zsh) $(whoami)
if [ $? -ne 0 ]; then
  echo "Failed to change default shell to zsh."
  exit 1
fi

# Link Oh My Zsh configuration
echo "Linking Oh My Zsh configuration..."
ln -sf /workspace/.zshrc $HOME/.zshrc
echo "export ZDOTDIR=/workspace" >> $HOME/.zshenv

# Configure Go environment
echo "Configuring Go environment..."
GOPATH=/workspace/.go
echo "export GOPATH=$GOPATH" >> $HOME/.zshenv
echo "export PATH=\$PATH:\$GOPATH/bin:/opt/miniforge3/envs/default/bin:/opt/miniforge3/bin" >> $HOME/.zshenv

# Clean old zcompdump files (keep the latest one)
echo "Cleaning old zcompdump files..."
rm $ZDOTDIR/.zcompdump-*
