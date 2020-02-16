#!/usr/bin/env bash

set -o errexit
set -o nounset

echo "--> Install essential mix dependencies"

npm install -g yarn bs-platform typescript tslint eslint prettier

echo "--> Reshim ASDF"

asdf reshim nodejs