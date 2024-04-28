### Environment Configuration ###
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
export PATH="/opt/homebrew/opt/node@20/bin:$PATH"
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
alias fd="fd --hidden --exclude node_modules/ --exclude .git/ --exclude Library/ --exclude __pycache__/ --exclude .cache/"
alias rg="rg --hidden --glob=!node_modules/ --glob=!.git/ --glob=!Library/ --glob=!__pycache__/ --glob=!.cache/"
alias tt='noglob python3 $HOME/Documents/Dotfiles/scripts/touch.py'
alias st='python3 $HOME/Documents/Dotfiles/scripts/start.py'
alias cds='py $HOME/Documents/Dotfiles/scripts/clean_DS.py'
alias trash='py $HOME/Documents/Dotfiles/scripts/trash.py'
alias pj='py $HOME/Documents/Dotfiles/scripts/project.py'
alias rn='py $HOME/Documents/Dotfiles/scripts/rename.py'
alias ch='py $HOME/Documents/Dotfiles/scripts/clean.py'
alias zip='py $HOME/Documents/Dotfiles/scripts/zip.py'
alias clip='pbcopy <'
alias clear="clear && printf '\e[3J'"
alias php='php -S localhost:8000'
alias python='/usr/bin/python3'
alias ran='run_clear ranger'
alias ls='eza --icons -1'
alias lv='run_clear lvim'
alias mkdir='mkdir -p'
alias path='realpath'
alias dd='noglob dd'
alias hm='cd $HOME'
alias py='python3'
alias rm='rm -rf'
alias cc='clear'
alias lv.='lv .'
alias gls='gls'
alias cat='bat'

### Function Definitions ###
function gls {
  if git rev-parse --git-dir > /dev/null 2>&1; then
    local entries=$(git ls-tree --name-only HEAD | sed 's:/$::' | xargs -I {} sh -c 'if [ -d "{}" ]; then echo "{}/"; else echo "{}"; fi')

    echo "$entries" | grep '/$' | sed 's:/$::' | xargs -I {} eza --icons -1 -d {} 2>/dev/null

    echo "$entries" | grep -v '/$' | xargs eza --icons -1 2>/dev/null
  else
    eza --icons -1
  fi
}

git() {
  if [[ $1 == "revert" ]]; then
    shift  # Remove 'revert' from the arguments list
    python $HOME/Documents/Dotfiles/scripts/revert.py "$@"
  elif [[ $1 == "fetch" ]]; then
    command git fetch --prune
  elif [[ $1 == "undo" ]]; then
    shift  # Remove 'undo' from the arguments list
    python $HOME/Documents/Dotfiles/scripts/undo.py "$@"
  elif [[ $1 == "redo" ]]; then
    shift  # Remove 'redo' from the arguments list
    python $HOME/Documents/Dotfiles/scripts/redo.py "$@"
  else
    command git "$@"
  fi
}

function dd {
    if [[ "$1" == "." ]]; then
        cd - > /dev/null || return
        return
    fi

    local cleaned_path=$(echo "$1" | sed 's/\[\[.*\]\]//g')
    local dots="${cleaned_path//[^.]}"
    local up_levels=$((${#dots} - 1))
    
    if [[ $up_levels -gt 0 ]]; then
        local new_path="${1#$dots}"
        new_path="${new_path#/}"
        local i=0
        local up_dir=""
        while [[ $i -lt $up_levels ]]; do
            up_dir="../$up_dir"
            i=$((i+1))
        done
        cd "$up_dir$new_path" || return
    else
        cd "$1" || return
    fi
}

function run_clear() {
    $@
    clear
}

function silent() {
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
