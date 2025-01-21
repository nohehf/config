# CodeWhisperer pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.pre.zsh"

# Starship
eval "$(starship init zsh)"

# Load custom functions
source $HOME/lib.sh

# Load .env file in secrets
exsource $HOME/.secrets/.env

# To fix a gpg issue: https://github.com/keybase/keybase-issues/issues/2798
export GPG_TTY=$(tty)

# custom ai lib
export PATH="$HOME/code/ai/bin:$PATH"

# k8s
autoload -U +X compinit && compinit
export KUBECONFIG="${KUBECONFIG}$(find $HOME/.kube/configs -type f -exec echo -n :{} \;)"
export KUBECONFIG="${KUBECONFIG}:$HOME/.kube/config"
alias k=kubectl
source <(kubectl completion zsh)

# Docker 
source <(docker completion zsh)

# Atuin
eval "$(atuin init zsh)"

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

# Helper functions
function mkcd() {
  mkdir -p $@ && cd ${@:$#}
}

# Vscode c command, opens vscode in the current directory if no argument is given else opens vscode in the given directory
function c() {
  code ${1:-.}
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
