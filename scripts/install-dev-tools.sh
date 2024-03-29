#!/usr/bin/env bash

set -o errexit
set -o nounset

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

echo "==> Install Erlang compilation depedencies"

sudo apt-get install -y \
  m4 \
  libreadline-dev \
  libncurses-dev \
  libssh-dev \
  libyaml-dev \
  libxslt1-dev \
  libffi-dev \
  libncurses5-dev \
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

echo "==> Install Python dependencies"

sudo apt-get install -y \
  libbz2-dev \
  libsqlite3-dev

echo "==> Install Latex"

sudo apt-get install -y texlive-full

echo "==> Install Opam"

sudo apt-get install -y opam

echo "==> Install golang"

sudo apt-get install -y golang

echo "==> Install Rust"

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

echo "==> Install Haskell"

curl -sSL https://get.haskellstack.org/ | sh

echo "==> Add ASDF plugins"

asdf plugin add nodejs
asdf plugin add erlang
asdf plugin add rebar
asdf plugin add elixir
asdf plugin add cmake
asdf plugin add ruby
asdf plugin add java
bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring
asdf install

echo "==> Configure Elixir utilities"

mix do \
  local.hex --force, \
  local.rebar --force, \
  archive.install hex phx_new 1.5.3 --force

echo "==> Configure NodeJS environment"

curl -sSL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
sudo add-apt-repository "deb https://dl.yarnpkg.com/debian/ stable main"
sudo apt-get update -y
sudo apt-get install -y yarn
yarn global add \
  bs-platform \
  typescript \
  tslint \
  ts-node \
  eslint \
  prettier \
  reason-cli

echo "==> Configure Rust toolchain"

rustup toolchain install stable

echo "==> Configure  Haskell toolchains"

stack install

echo "==> Configure OCaml toolchains"

opam init -n
opam switch create 4.06.1
opam install -y ocamlformat menhir
opam pin add ocaml-lsp-server https://github.com/ocaml/ocaml-lsp.git

echo "==> Install Emscripten compiler"

emsdk install latest
emsdk activate latest
