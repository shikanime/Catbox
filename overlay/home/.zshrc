# Windows
export WINDOWS_HOME="/mnt/c/Users/$USER"
export DISPLAY=localhost:0.0
umask 022

# Java
export JAVA_HOME="/usr/lib/jvm/default-java"

# Vagrant
export VAGRANT_WSL_ENABLE_WINDOWS_ACCESS="1"

# Erlang
export ERL_AFLAGS="-kernel shell_history enabled"

# EmSDK
export PATH="$HOME/.emsdk:$PATH"

# oh-my-zsh.
export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh
autoload -U +X bashcompinit && bashcompinit
autoload -U +X compinit && compinit

# Start ssh agent
eval $(ssh-agent) &>/dev/null

# Starship shell
eval $(starship init zsh)

# ASDF
source $HOME/.asdf/asdf.sh
source $HOME/.asdf/completions/asdf.bash

# Emscripten
source $HOME/.emsdk/emsdk_env.sh

# OPAM configuration
source /home/devas/.opam/opam-init/init.zsh

# Kubernetes autocomplete
source <(kubectl completion zsh)
