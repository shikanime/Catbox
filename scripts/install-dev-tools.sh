#!/usr/bin/env bash

set -o errexit
set -o nounset

echo "--> Install Haskell toolchains"

sudo apt-get install haskell-platform
curl -fsSL https://get.haskellstack.org/ | sh

echo "--> Install Erlang/Elixir toolchains"

sudo add-apt-repository \
  "deb http://binaries.erlang-solutions.com/ubuntu $(lsb_release -cs) contrib"
sudo apt-get update -y

sudo apt-get -y install \
  m4 \
  libreadline-dev \
  libncurses-dev \
  libssh-dev \
  libyaml-dev \
  libxslt-dev \
  libffi-dev \
  libtool \
  unixodbc-dev \
  libwxgtk3.0-dev \
  libgl1-mesa-dev \
  libglu1-mesa-dev \
  libpng-dev \
  libssl-dev \
  automake \
  autoconf \
  libxml2-utils \
  xsltproc \
  fop \
  esl-erlang \
  elixir

mix do local.hex --force, local.rebar --force

echo "--> Install C/C++ toolchains"

sudo apt-get -y update
sudo apt-get install \
  build-essential \
  cmake \
  clang-format \
  clang-tidy \
  clang-tools \
  clang \
  libc++-dev \
  libc++1 \
  libc++abi-dev \
  libc++abi1 \
  libclang-dev \
  libclang1 \
  libomp-dev \
  libomp5 \
  lld \
  lldb \
  llvm-dev \
  llvm-runtime \
  llvm

echo "--> Install Java OpenJDK"

sudo apt-get install default-jdk

echo "--> Install Rust toolchains"

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

echo "--> Install Golang toolchains"

sudo add-apt-repository ppa:longsleep/golang-backports
sudo apt update
sudo apt install golang-go

echo "--> Install essential SSL library"

sudo apt-get -y install libssh-dev

echo "--> Add ASDF Bazel"

asdf plugin-add bazel https://github.com/rajatvig/asdf-bazel.git

echo "--> Add ASDF Julia"

asdf plugin-add julia https://github.com/rkyleg/asdf-julia.git

echo "--> Add ASDF NodeJS"

asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring

echo "--> Add ASDF Ocaml"

asdf plugin-add ocaml https://github.com/asdf-community/asdf-ocaml.git

echo "--> Add ASDF Ruby"

asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git

echo "--> Add ASDF Install"

asdf install
