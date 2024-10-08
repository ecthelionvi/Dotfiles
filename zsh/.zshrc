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
alias ran='run_clear ranger'
alias zsh="lv $HOME/.zshrc"
alias ls='eza --icons -1'
alias lv='run_clear lvim'
alias path='realpath'
alias dd='noglob dd'
alias hm='cd $HOME'
alias cat='bat'

### Scripts ###
alias tt='noglob python3 $SCRIPTS/touch.py'
alias cds='py $SCRIPTS/clean_DS.py'
alias clip='py $SCRIPTS/clip.py'
alias rzed='py $SCRIPTS/rzed.py'
alias rn='py $SCRIPTS/rename.py'
alias ch='py $SCRIPTS/clean.py'
alias zed='py $SCRIPTS/zed.py'
alias zip='py $SCRIPTS/zip.py'


function py() {
    python3 "$@"
}

function python() {
    /usr/bin/python3 "$@"
}

function swap() {
    # Run the Python script
    py "$SCRIPTS/swap.py"
    
    # Execute the SSH agent, suppress its output
    eval "$(ssh-agent -s)" >/dev/null 2>&1
    
    # Add the SSH key, suppress output
    ssh-add ~/.ssh/id_ed25519 >/dev/null 2>&1
    
    # Test SSH connection with GitHub
    github_output=$(ssh -T git@github.com 2>&1)
    if echo "$github_output" | grep -q "You've successfully authenticated"; then
        echo "$github_output"
    else
        echo "GitHub SSH test failed."
    fi
    
    # Test SSH connection with GitLab
    gitlab_output=$(ssh -T git@gitlab.com 2>&1)
    if echo "$gitlab_output" | grep -q "Welcome to GitLab"; then
        echo "$gitlab_output"
    else
        echo "GitLab SSH test failed."
    fi
}

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

# function git() {
#   if [[ $1 == "revert" ]]; then
#     shift
#     python3 $HOME/Documents/Dotfiles/scripts/revert.py "$@"
#   elif [[ $1 == "fetch" ]]; then
#     command git fetch --all --prune
#   elif [[ $1 == "undo" ]]; then
#     shift
#     python3 $HOME/Documents/Dotfiles/scripts/undo.py "$@"
#   elif [[ $1 == "redo" ]]; then
#     shift
#     python3 $HOME/Documents/Dotfiles/scripts/redo.py "$@"
#   elif [[ $1 == "prune" ]]; then
#     command git branch --delete --gone
#   elif [[ $1 == "log" ]]; then
#     command git log --pretty=format:"%h%x09%an%x09%ad%x09%s" --date=format:"%Y-%m-%d %H:%M:%S"
#   elif [[ $1 == "email" ]]; then
#     command git config user.email
#   else
#     command git "$@"
#   fi
# }


function git() {
    case "$1" in
        "email")
            command git config user.email
            ;;
        "fetch")
            command git fetch --all --prune
            command git branch --delete --gone
            ;;
        "redo")
            echo -n "Are you sure you want to redo? This will restore the last undone commit. (y/n) "
            read confirm
            if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; then
                command git reset --hard $(git rev-parse --verify HEAD@{1})
                echo "Last undone commit has been restored."
            else
                echo "Redo cancelled."
            fi
            ;;
        "undo")
            echo -n "Are you sure you want to undo the last commit? This will unstage changes. (y/n) "
            read confirm
            if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; then
                command git reset HEAD~1
                echo "Last commit undone. Changes are now unstaged."
            else
                echo "Undo cancelled."
            fi
            ;;
        "revert")
            shift
            echo -n "Are you sure you want to revert? This will create a new commit to undo changes. (y/n) "
            read confirm
            if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; then
                command git revert "$@"
            else
                echo "Revert cancelled."
            fi
            ;;
        "log")
            command git log --pretty=format:"%h%x09%an%x09%ad%x09%s" --date=format:"%Y-%m-%d %H:%M:%S"
            ;;
        *)
            command git "$@"
            ;;
    esac
}

function cd() {

  if [[ "$1" == "." ]]; then
    builtin cd - > /dev/null || return
    return
  fi

  builtin cd "$@" 2>/dev/null

  if [[ $? -ne 0 ]]; then
    local output
    output=$(python3 "$HOME/Documents/Dotfiles/scripts/dd.py" "$1")
    local exit_code=$?

    if [[ $exit_code -eq 0 ]]; then
      builtin cd "$output" || echo "Failed to navigate to: $output"
    else
      echo "$output"
      return 1
    fi
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
