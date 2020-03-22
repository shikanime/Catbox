# Windows
export WINDOWS_HOME="/mnt/c/Users/$USER"
umask 022

# Java
export JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64"

# Vagrant
export VAGRANT_WSL_ENABLE_WINDOWS_ACCESS="1"
export VAGRANT_DEFAULT_PROVIDER="hyperv"

# Go
export GOPATH="$WINDOWS_HOME/Code"
export PATH="$WINDOWS_HOME/Code/bin:$PATH"

# Erlang history
export ERL_AFLAGS="-kernel shell_history enabled"

# oh-my-zsh.
export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

autoload -U +X bashcompinit && bashcompinit
autoload -U +X compinit && compinit

# Starship shell
eval $(starship init zsh)

# ASDF
source $HOME/.asdf/asdf.sh
source $HOME/.asdf/completions/asdf.bash

# Kubernetes autocomplete
source <(kubectl completion zsh)
