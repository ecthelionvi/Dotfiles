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

# Language
setopt CORRECT

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
alias fuzzy='py $HOME/Documents/Dotfiles/scripts/fuzzy_match.py'
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
# alias rm='rm -rf'
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

jobs() {
  if [[ $1 == "-e" ]]; then
    command crontab -e
  elif [[ $1 == "-l" ]]; then
    command crontab -l
  elif [[ $1 == "-r" ]]; then
    command crontab -r
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

# function dd {
#     if [[ "$1" == "." ]]; then
#         cd - > /dev/null || return
#         return
#     fi

#     local cleaned_path=$(echo "$1" | sed 's/\[\[.*\]\]//g')
#     local dots="${cleaned_path//[^.]}"
#     local up_levels=$((${#dots} - 1))
#     
#     if [[ $up_levels -gt 0 ]]; then
#         local new_path="${1#$dots}"
#         new_path="${new_path#/}"
#         local i=0
#         local up_dir=""
#         while [[ $i -lt $up_levels ]]; do
#             up_dir="../$up_dir"
#             i=$((i+1))
#         done
#         cd "$up_dir$new_path" || return
#     else
#         cd "$1" || return
#     fi
# }

# function dd {
#   if [[ "$1" == "." ]]; then
#     cd - > /dev/null || return
#     return
#   fi

#   local initial_dir=$(pwd)  # Store the initial directory to revert if needed.
#   local target_path="$1"

#   # Handle dot-based navigation.
#   if [[ "$target_path" == ..* ]]; then
#     local dots="${target_path//[^.]}"
#     local dot_count=${#dots}
#     local up_levels=$(($dot_count - 1))
#     local up_dir=""
#     for ((i=0; i<up_levels; i++)); do
#       up_dir="../$up_dir"
#     done
#     cd "$up_dir" 2>/dev/null || {
#       echo "Failed to navigate: path not found"
#       return
#     }
#     return
#   fi

#   # Process path components.
#   local component
#   local path_remainder="$target_path"
#   while [[ "$path_remainder" =~ / ]]; do
#     component="${path_remainder%%/*}"  # Get the first component.
#     path_remainder="${path_remainder#*/}"  # Remove the first component from the path.

#     if [[ -z "$component" ]]; then
#       continue  # Skip empty components.
#     fi

#     if ! cd "$component" 2>/dev/null; then
#       # Call Python script to perform fuzzy matching
#       local closest_match=$(python3 /Users/rob/fuzzy_match.pyc "$(pwd)" "$component")
#       if [[ -n "$closest_match" ]]; then
#         # echo "Navigating to the closest match: $closest_match"
#         cd "$closest_match" || {
#           echo "Failed to navigate further from $(pwd)"
#           cd "$initial_dir"
#           return
#         }
#       else
#         echo "Directory not found: $component in $(pwd)"
#         cd "$initial_dir"
#         return
#       fi
#     fi
#   done

#   # Process the last component if any.
#   if [[ -n "$path_remainder" ]]; then
#     if ! cd "$path_remainder" 2>/dev/null; then
#       local closest_match=$(python3 /Users/rob/fuzzy_match.pyc "$(pwd)" "$path_remainder")
#       if [[ -n "$closest_match" ]]; then
#         # echo "Navigating to the closest match: $closest_match"
#         cd "$closest_match" || {
#           echo "Failed to navigate further from $(pwd)"
#           cd "$initial_dir"
#           return
#         }
#       else
#         echo "Directory not found: $path_remainder in $(pwd)"
#         cd "$initial_dir"
#         return
#       fi
#     fi
#   fi
# }


function dd {
  declare -A cache  # Declare an associative array to store cached paths

  if [[ "$1" == "." ]]; then
    cd - > /dev/null || return
    return
  fi

  local initial_dir=$(pwd)  # Store the initial directory to revert if needed.
  local target_path="$1"

  # Handle dot-based navigation.
  if [[ "$target_path" == ..* ]]; then
    local dots="${target_path//[^.]}"
    local dot_count=${#dots}
    local up_levels=$(($dot_count - 1))
    local up_dir=""
    for ((i=0; i<up_levels; i++)); do
      up_dir="../$up_dir"
    done
    cd "$up_dir" 2>/dev/null || {
      echo "Failed to navigate: path not found"
      return
    }
    return
  fi

  # Process path components.
  local component
  local path_remainder="$target_path"
  while [[ "$path_remainder" =~ / ]]; do
    component="${path_remainder%%/*}"  # Get the first component.
    path_remainder="${path_remainder#*/}"  # Remove the first component from the path.

    if [[ -z "$component" ]]; then
      continue  # Skip empty components.
    fi

    if ! cd "$component" 2>/dev/null; then
      if [[ -n "${cache[$component]}" ]]; then
        cd "${cache[$component]}" || continue
      else
        local closest_match=$(python3 $HOME/Documents/Dotfiles/scripts/fuzzy_match.py "$(pwd)" "$component")
        if [[ -n "$closest_match" ]]; then
          cache[$component]="$closest_match"  # Cache the result
          cd "$closest_match" || {
            echo "Failed to navigate further from $(pwd)"
            cd "$initial_dir"
            return
          }
        else
          echo "Directory not found: $component in $(pwd)"
          cd "$initial_dir"
          return
        fi
      fi
    fi
  done

  if [[ -n "$path_remainder" ]]; then
    if ! cd "$path_remainder" 2>/dev/null; then
      if [[ -n "${cache[$path_remainder]}" ]]; then
        cd "${cache[$path_remainder]}" || continue
      else
        local closest_match=$(python3 $HOME/Documents/Dotfiles/scripts/fuzzy_match.py "$(pwd)" "$path_remainder")
        if [[ -n "$closest_match" ]]; then
          cache[$path_remainder]="$closest_match"  # Cache the result
          cd "$closest_match" || {
            echo "Failed to navigate further from $(pwd)"
            cd "$initial_dir"
            return
          }
        else
          echo "Directory not found: $path_remainder in $(pwd)"
          cd "$initial_dir"
          return
        fi
      fi
    fi
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
