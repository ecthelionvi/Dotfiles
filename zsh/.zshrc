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
alias cds='py $HOME/Documents/Dotfiles/scripts/clean_DS.py'
alias trash='py $HOME/Documents/Dotfiles/scripts/trash.py'
alias unzip='py $HOME/Documents/Dotfiles/scripts/unzip.py'
alias pj='py $HOME/Documents/Dotfiles/scripts/project.py'
alias clip='py $HOME/Documents/Dotfiles/scripts/clip.py'
alias rzed='py $HOME/Documents/Dotfiles/scripts/rzed.py'
alias rn='py $HOME/Documents/Dotfiles/scripts/rename.py'
alias rm='py $HOME/Documents/Dotfiles/scripts/remove.py'
alias st='py $HOME/Documents/Dotfiles/scripts/start.py'
alias ch='py $HOME/Documents/Dotfiles/scripts/clean.py'
alias zed='py $HOME/Documents/Dotfiles/scripts/zed.py'
alias zip='py $HOME/Documents/Dotfiles/scripts/zip.py'
alias zip='py $HOME/Documents/Dotfiles/scripts/zip.py'
alias dotfiles='cd $HOME/Documents/Dotfiles/'
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
alias cc='clear'
alias lv.='lv .'
alias gls='gls'
alias cat='bat'

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

function git() {
  if [[ $1 == "revert" ]]; then
    shift
    python $HOME/Documents/Dotfiles/scripts/revert.py "$@"
  elif [[ $1 == "fetch" ]]; then
    command git fetch --prune
  elif [[ $1 == "undo" ]]; then
    shift
    python $HOME/Documents/Dotfiles/scripts/undo.py "$@"
  elif [[ $1 == "redo" ]]; then
    shift
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

  local initial_dir=$(pwd)
  local target_path="$1"
  local python_script="$HOME/Documents/Dotfiles/scripts/fuzzy.py"

  if [[ "$target_path" == ..* ]]; then
    local dot_count=${#target_path}
    local up_levels=$(($dot_count - 1))
    local up_dir=$(printf '../%.0s' $(seq 1 $up_levels))
    cd "$up_dir" 2>/dev/null || { echo "Failed to navigate: path not found"; return; }
    return
  fi

  change_dir_or_fuzzy_match() {
    local component="$1"
    if ! cd "$component" 2>/dev/null; then
      local closest_match=$(python3 "$python_script" "$(pwd)" "$component")
      if [[ -n "$closest_match" ]]; then
        cd "$closest_match" || { echo "Failed to navigate further from $(pwd)"; cd "$initial_dir"; return 1; }
      else
        echo "Directory not found: $component in $(pwd)"
        cd "$initial_dir"
        return 1
      fi
    fi
  }

  local component
  local path_remainder="$target_path"
  while [[ "$path_remainder" =~ / ]]; do
    component="${path_remainder%%/*}"
    path_remainder="${path_remainder#*/}"
    [[ -z "$component" ]] && continue
    change_dir_or_fuzzy_match "$component" || return
  done

  [[ -n "$path_remainder" ]] && change_dir_or_fuzzy_match "$path_remainder"
}

## Key Bindings ###
export FUNCNEST=500

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^O' edit-command-line

# Environment Flags
OP_BIOMETRIC_UNLOCK_ENABLED=true
RANGER_LOAD_DEFAULT_RC=false



