#!/usr/bin/env bash

set -o errexit
set -o nounset

echo "--> Install prerequisites"

sudo apt-get -y update
sudo apt-get -y install build-essential

echo "--> Needed for Erlang HiPE (native code) support"

sudo apt-get -y install m4

echo "--> Needed for Erlang terminal handling"

sudo apt-get -y install libncurses5-dev

echo "--> For building Erlang with wxWidgets"

sudo apt-get -y install \
  libwxgtk3.0-dev \
  libgl1-mesa-dev \
  libglu1-mesa-dev \
  libpng-dev \
  libncurses5-dev \
  libssl-dev \
  automake \
  autoconf

echo "--> Install essential SSL library"

sudo apt-get -y install libssh-dev

echo "--> For building Erlang documentation"

sudo apt-get -y install libxml2-utils xsltproc fop

echo "--> Add ASDF Bazel"

asdf plugin-add bazel https://github.com/rajatvig/asdf-bazel.git

echo "--> Add ASDF Haskell"

asdf plugin-add haskell https://github.com/vic/asdf-haskell.git

echo "--> Add ASDF Julia"

asdf plugin-add julia https://github.com/rkyleg/asdf-julia.git

echo "--> Add ASDF Python"

asdf plugin-add python

echo "--> Add ASDF NodeJS"

asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring

echo "--> Add ASDF Elixir"

asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git

echo "--> Add ASDF Erlang"

asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang.git

echo "--> Add ASDF Ocaml"

asdf plugin-add ocaml https://github.com/asdf-community/asdf-ocaml.git

echo "--> Add ASDF Rust"

asdf plugin-add rust https://github.com/code-lever/asdf-rust.git

echo "--> Add ASDF Ruby"

asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git

echo "--> Add ASDF Java"

sudo apt-get -y install jq
asdf plugin-add java https://github.com/halcyon/asdf-java.git

echo "--> Add ASDF Go"

asdf plugin-add golang https://github.com/kennyp/asdf-golang.git

echo "--> Add ASDF Install"

asdf install
