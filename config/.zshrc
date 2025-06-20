# CodeWhisperer pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.pre.zsh"

# Starship
eval "$(starship init zsh)"

# Load custom functions
source $HOME/lib.sh

export EDITOR="nvim"

# Load .env file in secrets
if [[ -f $HOME/.secrets/.env ]]; then
  exsource $HOME/.secrets/.env
fi

# To fix a gpg issue: https://github.com/keybase/keybase-issues/issues/2798
export GPG_TTY=$(tty)

# custom ai lib
export PATH="$HOME/code/ai/bin:$PATH"

# k8s
autoload -U +X compinit && compinit
if [[ -d $HOME/.kube/configs ]]; then
  export KUBECONFIG="${KUBECONFIG}$(find $HOME/.kube/configs -type f -exec echo -n :{} \;)"
  export KUBECONFIG="${KUBECONFIG}:$HOME/.kube/config"
fi
alias k=kubectl
source <(kubectl completion zsh)

# Docker 
source <(docker completion zsh)

# Atuin
if command -v atuin &> /dev/null; then 
  eval "$(atuin init zsh)"
fi

# Lib postgres (to remove if installing the full postgres)
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# GO
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOPATH/bin

# Android
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

# Nix
export NIXPKGS_ALLOW_UNFREE=1

function nrun() {
    nix run nixpkgs#$1 "${@:2}"
}

function nsearch() {
  nix search nixpkgs#$1
}

function nshell() {
  nix shell nixpkgs#$1 "${@:2}"
}

# Helper functions
function mkcd() {
  mkdir -p $@ && cd ${@:$#}
}

# cursor c command, opens cursor in the current directory if no argument is given else opens cursor in the given directory
function c() {
  nohup cursor "${1:-.}" >/dev/null 2>&1 &
  disown
}

function v() {
  # If no argument is passed, open Neovim in the current directory
  if [ $# -eq 0 ]; then
    nvim .
  # If the argument is a directory, cd into it and open Neovim there
  elif [ -d "$1" ]; then
    cd "$1" && nvim .
  # If the argument is a file, open the file in Neovim
  elif [ -f "$1" ]; then
    nvim "$1"
  else
    # If the argument is neither a file nor a directory, open it as a new file in Neovim
    nvim "$1"
  fi
}

# just alias to j
alias j=just

# opam configuration
[[ ! -r /Users/nohehf/.opam/opam-init/init.zsh ]] || source /Users/nohehf/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"


[[ -f "$HOME/fig-export/dotfiles/dotfile.zsh" ]] && builtin source "$HOME/fig-export/dotfiles/dotfile.zsh"

# CodeWhisperer post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.post.zsh"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
