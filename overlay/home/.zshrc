# Go
export GOPATH="$WINHOME/Code"
export PATH="$WINHOME/Code/bin:$PATH"

# Erlang history
export ERL_AFLAGS="-kernel shell_history enabled"

# oh-my-zsh.
export ZSH="$HOME/.oh-my-zsh"
. $ZSH/oh-my-zsh.sh

# Starship shell
eval $(starship init zsh)

# ASDF
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

# Kubernetes autocomplete
. <(kubectl completion zsh)

# Contigure Java Home
. ~/.asdf/plugins/java/set-java-home.sh
