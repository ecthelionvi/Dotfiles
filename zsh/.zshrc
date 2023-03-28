# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"

export HISTFILE=$HOME/.cache/zsh/zsh_history
export VISUAL=$HOME/.local/bin/lvim
export EDITOR=$HOME/.local/bin/lvim
export PATH=$HOME/.local/bin:$PATH

eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(pyenv init --path)"
eval "$(starship init zsh)"

alias rn='py /Users/rob/Documents/scripts/rename.py'
alias ch='py /Users/rob/Documents/scripts/clean.py'
alias lv='silent_running lvim'
alias ls='exa --icons -1'
alias hm='cd $HOME'
alias py='python3'
alias rm='rm -rf'
alias cc='clear'

OP_BIOMETRIC_UNLOCK_ENABLED=true
RANGER_LOAD_DEFAULT_RC=false

function silent_running {
  set +e
  "$@" 2>/dev/null
}

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"