#!/usr/bin/env bash

set -o errexit
set -o nounset

echo "==> Install essentials utility tools"

sudo apt-get install -y \
  curl \
  wget \
  git \
  gnupg2 \
  unzip \
  jq \
  inotify-tools \
  software-properties-common \
  neovim

echo "==> Install Zsh"

sudo apt-get install -y \
  zsh \
  powerline \
  fonts-powerline

echo "==> Install Oh my Zsh"

curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | bash -s -- -y
sudo chsh -s $(which zsh) $USER

echo "==> Install Starship"

curl -fsSL https://starship.rs/install.sh | bash -s -- -y

echo "==> Install ASDF"

git clone https://github.com/asdf-vm/asdf.git $HOME/.asdf --branch v0.7.6

echo "==> Install Emscripten"

git clone https://github.com/emscripten-core/emsdk.git $HOME/.emsdk

echo "==> Migrate shell"

zsh
