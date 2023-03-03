# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"
export HISTFILE=$HOME/.cache/zsh/zsh_history
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
eval "$(starship init zsh)"

RANGER_LOAD_DEFAULT_RC=false

alias lv='/Users/rob/.local/bin/lvim'
alias py='python3'
alias ch='/Users/rob/Scripts/clean.sh'
alias cc='clear'
alias ls='exa --icons -1'

OP_BIOMETRIC_UNLOCK_ENABLED=true

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
