# ### Environment Configuration ###
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"

# History
export HISTFILE=$HOME/.cache/zsh/zsh_history

# Editor
export VISUAL=$HOME/.local/bin/lvim
export EDITOR=$HOME/.local/bin/lvim

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Zsh Auto Suggestions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_STRATEGY=(completion history)

# Python
eval "$(pyenv init --path)"

# Starship
eval "$(starship init zsh)"

### Aliases ###
alias fd="fd --hidden --exclude node_modules/ --exclude .git/ --exclude .fig/ --exclude Library/ --exclude __pycache__/ --exclude .cache/"
alias rg="rg --hidden --glob=!node_modules/ --glob=!.git/ --glob=!.fig/ --glob=!Library/ --glob=!__pycache__/ --glob=!.cache/"
alias tt='noglob python3 $HOME/Documents/Dotfiles/scripts/touch.py'
alias cds='py $HOME/Documents/Dotfiles/scripts/clean_DS.py'
alias ch='py $HOME/Documents/Dotfiles/scripts/clean.py'
alias zip='py $HOME/Documents/Dotfiles/scripts/zip.py'

# Utility Aliases
alias lv='silent_running lvim'
alias python=/usr/bin/python3
alias ls='eza --icons -1'
alias ran='ranger_clear'
alias mkdir='mkdir -p'
alias hm='cd $HOME'
alias py='python3'
alias lv.='lv_dot'
alias rn='rename'
alias rm='rm -rf'
alias cc='clear'
alias cat='bat'

### Function Definitions ###
function lv_dot {
    silent_running lvim -c 'set hidden | Explore'
}

function ranger_clear {
  /Users/rob/.pyenv/shims/ranger
  clear
}

function silent_running {
  set +e
  "$@" 2>/dev/null
  clear
}

## Key Bindings ###
export FUNCNEST=500

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^O' edit-command-line

# Environment Flags
OP_BIOMETRIC_UNLOCK_ENABLED=true
RANGER_LOAD_DEFAULT_RC=false
export PATH="/opt/homebrew/opt/node@20/bin:$PATH"
