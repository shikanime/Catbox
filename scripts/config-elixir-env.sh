#!/usr/bin/env bash

set -o errexit
set -o nounset

echo "--> Install essential mix dependencies"

mix do local.hex --force, local.rebar --force

echo "--> Reshim ASDF"

asdf reshim elixir