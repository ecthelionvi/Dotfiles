# CodeWhisperer pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.pre.zsh"

### Environment Configuration ###
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

# Python
eval "$(pyenv init --path)"

# Starship
eval "$(starship init zsh)"

### Aliases ###
alias fd="fd --hidden --exclude node_modules/ --exclude .git/ --exclude .fig/ --exclude Library/ --exclude __pycache__/ --exclude .cache/"
alias rg="rg --hidden --glob=!node_modules/ --glob=!.git/ --glob=!.fig/ --glob=!Library/ --glob=!__pycache__/ --glob=!.cache/"
alias cds='py /Users/rob/Documents/Scripts/clean_DS.py'
alias touch='py /Users/rob/Documents/Scripts/touch.py'
alias ch='py /Users/rob/Documents/Scripts/clean.py'

# Utility Aliases
alias lv='silent_running lvim'
alias lv.='lv_dot'
alias python=/usr/bin/python3
alias ls='exa --icons -1'
alias ran='ranger_clear'
alias mkdir='mkdir -p'
alias hm='cd $HOME'
alias py='python3'
alias rm='rm -rf'
alias cc='clear'
alias cat='bat'

### Function Definitions ###
function lv_dot {
    silent_running lvim -c 'set hidden | Explore'
}

function silent_running {
  set +e
  "$@" 2>/dev/null
  clear
}

function ranger_clear {
  /Users/rob/.pyenv/shims/ranger
  clear
}

### Key Bindings ###
export FUNCNEST=500

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^O' edit-command-line

# Environment Flags
OP_BIOMETRIC_UNLOCK_ENABLED=true
RANGER_LOAD_DEFAULT_RC=false

# CodeWhisperer post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.post.zsh"
