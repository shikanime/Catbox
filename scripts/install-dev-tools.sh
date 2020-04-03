#!/usr/bin/env bash

set -o errexit
set -o nounset

echo "==> Install essential SSL library"

sudo apt-get install -y libssh-dev

echo "==> Install Haskell toolchains"

sudo apt-get install -y haskell-platform
curl -fsSL https://get.haskellstack.org/ | sh

echo "==> Install Erlang/Elixir toolchains"

sudo add-apt-repository \
  "deb http://binaries.erlang-solutions.com/ubuntu $(lsb_release -cs) contrib"
sudo apt-get update -y

sudo apt-get install -y \
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

echo "==> Install C/C++ toolchains"

sudo apt-get -y update
sudo apt-get install -y \
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

echo "==> Install OCaml toolchains"

sudo apt-get install -y opam
opam init --disable-shell-hook
opam switch create 4.06.1
opam install -y ocamlformat menhir

echo "==> Install Java OpenJDK"

sudo apt-get install -y default-jdk

echo "==> Install Rust toolchains"

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

echo "==> Install Golang toolchains"

sudo add-apt-repository ppa:longsleep/golang-backports
sudo apt-get update
sudo apt-get install -y golang-go

echo "==> Add ASDF plugins"

asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git
asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring
asdf install

echo "==> Configure NodeJS"

asdf install nodejs
curl --compressed -o- -L https://yarnpkg.com/install.sh | bash
yarn add -g \
  bs-platform \
  typescript \
  tslint \
  ts-node \
  eslint \
  prettier
