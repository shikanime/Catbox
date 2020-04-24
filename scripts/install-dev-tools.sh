#!/usr/bin/env bash

set -o errexit
set -o nounset

echo "==> Install essential SSL library"

sudo apt-get install -y libssh-dev

echo "==> Install Haskell toolchains"

sudo apt-get install -y haskell-platform
curl -fsSL https://get.haskellstack.org/ | sh
stack install

echo "==> Install C/C++ toolchains"

sudo apt-get -y update
sudo apt-get install -y \
  build-essential \
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
  llvm \
  ninja-build \
  xorg-dev \
  mesa-utils \
  libglu1-mesa-dev

echo "==> Install OCaml toolchains"

sudo apt-get install -y opam
opam init -n
opam switch create 4.06.1
opam install -y ocamlformat menhir

echo "==> Install Java OpenJDK"

sudo apt-get install -y default-jdk

echo "==> Install Rust toolchains"

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

echo "==> Install Golang toolchains"

sudo apt install -y golang

echo "==> Install Erlang compilation depedencies"

sudo apt-get install -y \
  m4 \
  libreadline-dev \
  libncurses-dev \
  libssh-dev \
  libyaml-dev \
  libxslt1-dev \
  libffi-dev \
  libtool \
  unixodbc-dev \
  libwxgtk3.0-gtk3-dev \
  libgl1-mesa-dev \
  libglu1-mesa-dev \
  libpng-dev \
  libssl-dev \
  automake \
  autoconf \
  libxml2-utils \
  xsltproc \
  fop

echo "==> Add ASDF plugins"

asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git
asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang.git
asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git
asdf plugin-add cmake https://github.com/srivathsanmurali/asdf-cmake.git
bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring
asdf install

echo "==> Install Elixir utilities"

mix do \
  local.hex --force, \
  local.rebar --force, \
  archive.install hex phx_new 1.5.1 --force

echo "==> Configure NodeJS"

curl --compressed -o- -L https://yarnpkg.com/install.sh | bash
yarn global add \
  bs-platform \
  typescript \
  tslint \
  ts-node \
  eslint \
  prettier

echo "==> Install Emscripten compiler"

emsdk install latest
emsdk activate latest
