#!/usr/bin/env bash

set -o errexit
set -o nounset

echo "--> Install essential mix dependencies"

gem install bundler
gem install pry
gem install gem-ctags