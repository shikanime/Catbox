#!/usr/bin/env bash

set -o errexit
set -o nounset

echo "--> Install Ansible"

pip3 install ansible

echo "--> Install Pipenv"

pip3 install pipenv

echo "--> Reshim ASDF"

asdf reshim python