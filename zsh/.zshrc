# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"

export ZSH_COMPDUMP=$ZSH/cache/.zcompdump-$HOST
export PATH=$HOME/bin:/usr/local/bin:$PATH
eval "$(starship init zsh)"

alias lv='/Users/rob/.local/bin/lvim'
alias ch='/Users/rob/clean.sh'
alias cc='clear'
alias ls='exa --icons -1'

OP_BIOMETRIC_UNLOCK_ENABLED=true

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"