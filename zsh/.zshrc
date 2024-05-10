### Environment Configuration ###
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
export SCRIPTS="$HOME/Documents/Dotfiles/scripts"
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
alias cc="clear && printf '\e[3J'"
alias php='php -S localhost:8000'
alias python='/usr/bin/python3'
alias ran='run_clear ranger'
alias zsh="lv $HOME/.zshrc"
alias ls='eza --icons -1'
alias lv='run_clear lvim'
alias mkdir='mkdir -p'
alias path='realpath'
alias dd='noglob dd'
alias hm='cd $HOME'
alias py='python3'
alias lv.='lv .'
alias gls='gls'
alias cat='bat'

### Scripts ###
alias rm='py $SCRIPTS/remove.py --no-backup'
alias tt='noglob python3 $SCRIPTS/touch.py'
alias cds='py $SCRIPTS/clean_DS.py'
alias trash='py $SCRIPTS/trash.py'
alias unzip='py $SCRIPTS/unzip.py'
alias pj='py $SCRIPTS/project.py'
alias clip='py $SCRIPTS/clip.py'
alias rzed='py $SCRIPTS/rzed.py'
alias rn='py $SCRIPTS/rename.py'
alias st='py $SCRIPTS/start.py'
alias ch='py $SCRIPTS/clean.py'
alias png='py $SCRIPTS/png.py'
alias zed='py $SCRIPTS/zed.py'
alias zip='py $SCRIPTS/zip.py'

### Function Definitions ###
function silent() {
  set +e
  "$@" 2>/dev/null
  clear
}

function run_clear() {
    "$@"
    clear
}

function jobs() {
  if [[ $1 == "-e" ]]; then
    command crontab -e
  elif [[ $1 == "-l" ]]; then
    command crontab -l
  elif [[ $1 == "-r" ]]; then
    command crontab -r
  fi
}

function realpath() {
  command python3 $SCRIPTS/pwd.py "$1"
}

function git() {
  if [[ $1 == "revert" ]]; then
    shift
    python3 $HOME/Documents/Dotfiles/scripts/revert.py "$@"
  elif [[ $1 == "fetch" ]]; then
    command git fetch --prune
  elif [[ $1 == "undo" ]]; then
    shift
    python3 $HOME/Documents/Dotfiles/scripts/undo.py "$@"
  elif [[ $1 == "redo" ]]; then
    shift
    python3 $HOME/Documents/Dotfiles/scripts/redo.py "$@"
  else
    command git "$@"
  fi
}

function dd() {
  if [[ "$1" == "." ]]; then
    cd - > /dev/null || return
    return
  fi

  local python_script="$HOME/Documents/Dotfiles/scripts/dd.py"
  local target_path="$1"

  local output=$(python3 "$python_script" "$target_path")
  local exit_code=$?

  if [[ $exit_code -eq 0 ]]; then
    cd "$output" || { echo "Failed to navigate to: $output"; return 1; }
  else
    echo "$output"
    return 1
  fi
}

## Key Bindings ###
export FUNCNEST=500

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^O' edit-command-line

# Environment Flags
OP_BIOMETRIC_UNLOCK_ENABLED=true
RANGER_LOAD_DEFAULT_RC=false


