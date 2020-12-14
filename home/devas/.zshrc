# Krew
export PATH="${KREW_ROOT:-${HOME}/.krew}/bin:${PATH}"

# Go
export PATH="${HOME}/go/bin:${PATH}"

# Docker
export DOCKER_BUILDKIT=1

# Erlang
export ERL_AFLAGS="-kernel shell_history enabled"

# Local
export PATH="${HOME}/.local/bin:${PATH}"

# oh-my-zsh
export ZSH="${HOME}/.oh-my-zsh"
plugins=(
  golang
  cargo
  vscode
  docker
  ubuntu
  git
  python
  rustup
  stack
  dotenv
  mix
  kubectl
  gcloud
  minikube
  yarn
  terraform
  npm
  asdf
)
. ${ZSH}/oh-my-zsh.sh

# ZSH
DISABLE_AUTO_UPDATE=true
DISABLE_UPDATE_PROMPT=true

# Starship shell
eval $(starship init zsh)
