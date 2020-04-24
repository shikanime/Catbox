# Windows
export WINDOWS_HOME="/mnt/c/Users/$USER"
export DISPLAY=localhost:0.0
export LIBGL_ALWAYS_INDIRECT=1
umask 022

# Yarn
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# Java
export JAVA_HOME="/usr/lib/jvm/default-java"

# Erlang
export ERL_AFLAGS="-kernel shell_history enabled"

# EmSDK
export PATH="$HOME/.emsdk:$PATH"

# oh-my-zsh.
export ZSH="$HOME/.oh-my-zsh"
plugins=(
  git
  mix
  kubectl
  gcloud
  yarn
  npm
  ssh-agent
  stack
  asdf
)
source $ZSH/oh-my-zsh.sh

# Starship shell
eval $(starship init zsh)

# Emscripten
source $HOME/.emsdk/emsdk_env.sh &>/dev/null

# OPAM configuration
source /home/devas/.opam/opam-init/init.zsh
