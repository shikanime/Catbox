#!/usr/bin/env bash

set -o errexit
set -o nounset

echo "--> Update source list"

sudo apt-get -y update

echo "--> Install essentials utility tools"

sudo apt-get -y install \
  curl \
  wget \
  git \
  gnupg2 \
  unzip \
  jq

echo "--> Install Zsh"

sudo apt-get -y install \
  zsh \
  powerline \
  fonts-powerline

echo "--> Install Oh my Zsh"

curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | bash -s -- -y
sudo chsh -s $(which zsh) vagrant

echo "--> Install Starship"

curl -fsSL https://starship.rs/install.sh | bash -s -- -y

echo "--> Install ASDF"

git clone https://github.com/asdf-vm/asdf.git $HOME/.asdf --branch v0.7.6

echo "--> Migrate shell"

zsh
