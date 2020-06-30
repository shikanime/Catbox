# Windows
export DISPLAY=localhost:0.0
export LIBGL_ALWAYS_INDIRECT=1
umask 022

# Shortcuts
alias c=code-insiders
alias g=git
alias m=mix
alias y=yarn

# Docker
export DOCKER_BUILDKIT=1

# Erlang
export ERL_AFLAGS="-kernel shell_history enabled"

# EmSDK
export PATH="$HOME/.emsdk:$PATH"

# Emscripten
source $HOME/.emsdk/emsdk_env.sh &>/dev/null

# OPAM configuration
source $HOME/.opam/opam-init/init.zsh

# Java Home
source $HOME/.asdf/plugins/java/set-java-home.zsh

# oh-my-zsh.
export ZSH="$HOME/.oh-my-zsh"
plugins=(
  golang
  cargo
  vscode
  docker
  ubuntu
  git
  dotenv
  mix
  kubectl
  gcloud
  yarn
  npm
  ssh-agent
  asdf
)
source $ZSH/oh-my-zsh.sh

# Starship shell
eval $(starship init zsh)
