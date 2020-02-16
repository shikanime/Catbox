#!/usr/bin/env bash

set -o errexit
set -o nounset

echo "--> Install cabal"

stack install cabal-install

echo "--> Reshim ASDF"

asdf reshim haskell