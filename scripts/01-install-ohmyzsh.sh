#!/bin/bash

set -e

# Check if the current system is Ubuntu
if ! grep -q "Ubuntu" /etc/os-release; then
  echo "This script can only run on Ubuntu systems."
  exit 1
fi

# Check if the script is running as root
if [ "$(id -u)" -eq 0 ]; then
  echo "This script should not be run as root."
  exit 1
fi

# Install Oh My Zsh
echo "Installing Oh My Zsh..."
export ZDOTDIR=/workspace
export ZSH=$ZDOTDIR/.oh-my-zsh
export CHSH=no
export RUNZSH=no
export KEEP_ZSHRC=yes
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Install custom plugins
echo "Installing custom plugins..."
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-completions.git $ZSH/custom/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-history-substring-search.git $ZSH/custom/plugins/zsh-history-substring-search
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH/custom/plugins/zsh-syntax-highlighting

# Configure custom plugins
echo "Configuring custom plugins..."
sed -i 's/^plugins=(.*)/plugins=(git zsh-autosuggestions zsh-completions zsh-history-substring-search zsh-syntax-highlighting)/' $ZDOTDIR/.zshrc

# Configure zsh theme
echo "Configuring zsh theme..."
sed -i 's/^ZSH_THEME=".*"/ZSH_THEME="fletcherm"/' $ZDOTDIR/.zshrc
