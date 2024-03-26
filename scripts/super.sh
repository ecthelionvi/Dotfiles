#!/bin/bash

# URLs for the raw files in the GitHub repository
REPO_URL="https://raw.githubusercontent.com/ecthelionvi/Dotfiles/main/"
BREWFILE_URL="${REPO_URL}brew/Brewfile"
CARGOPACKAGES_URL="${REPO_URL}cargo/CargoPackages.txt"
PIPFILE_URL="${REPO_URL}python/pip.txt"
ZSHRC_URL="${REPO_URL}zsh/.zshrc"
HUSHLOGIN_URL="${REPO_URL}zsh/.hushlogin"
LAZYGIT_CONFIG_URL="${REPO_URL}lazygit/config.yml"
LAZYGIT_CONFIG_DIR="$HOME/Library/Application Support/lazygit"
GITCONFIG_URL="${REPO_URL}git/.gitconfig"
GITIGNORE_GLOBAL_URL="${REPO_URL}git/.gitignore_global"
SUBLIME_SETTINGS_URL="${REPO_URL}sublime/Preferences.sublime-settings"
SUBLIME_SETTINGS_DIR="$HOME/Library/Application Support/Sublime Text/Packages/User"
FONT_URL="https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/JetBrainsMono/Ligatures/Regular/JetBrainsMono%20Regular%20Nerd%20Font%20Complete%20Mono.ttf"
FONT_DIR="$HOME/Library/Fonts"
PROFILE_JSON_URL="${REPO_URL}iterm2/rob.jsn"
DYNAMIC_PROFILES_DIR="$HOME/Library/Application Support/iTerm2/DynamicProfiles"

function setup_homebrew() {
  echo "Setting up Homebrew..."
  if ! command -v brew &> /dev/null; then
    echo "Homebrew not found. Installing Homebrew..."
    if /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; then
      echo "Homebrew installation completed."
    else
      echo "Failed to install Homebrew. Skipping Homebrew setup."
      return 1
    fi
  fi

  echo "Downloading and setting up Brewfile..."
  if curl -fsSL "$BREWFILE_URL" -o "$HOME/Brewfile"; then
    if brew bundle --file="$HOME/Brewfile"; then
      echo "Brewfile setup completed."
      rm "$HOME/Brewfile" # Cleanup
      rm "$HOME/Brewfile.lock.json" # Cleanup Brewfile.lock.json
    else
      echo "Failed to setup Brewfile. Skipping Homebrew setup."
      return 1
    fi
  else
    echo "Failed to download Brewfile. Skipping Homebrew setup."
    return 1
  fi
}

function setup_cargo() {
  echo "Setting up Cargo..."
  if curl -fsSL "$CARGOPACKAGES_URL" -o "$HOME/CargoPackages.txt"; then
    if ! command -v cargo &>/dev/null; then
      echo "Rust not found. Installing Rust..."
      if ! brew install rust; then
        echo "Failed to install Rust. Skipping Cargo setup."
        return 1
      fi
    fi

    while IFS= read -r line; do
      package_name=$(echo "$line" | awk '{print $1}' | sed 's/://')
      echo "Installing Cargo package: $package_name"
      cargo install "$package_name" || echo "Failed to install Cargo package: $package_name. Skipping."
    done < "$HOME/CargoPackages.txt"

    rm "$HOME/CargoPackages.txt" # Cleanup
  else
    echo "Failed to download CargoPackages.txt. Skipping Cargo setup."
    return 1
  fi
}

function setup_python() {
  echo "Setting up Python with pyenv and pip..."
  if ! command -v pyenv &>/dev/null; then
    echo "pyenv not found. Installing pyenv..."
    if ! brew install pyenv; then
      echo "Failed to install pyenv. Skipping Python setup."
      return 1
    fi
  fi

  pyenv install 3.12.0 --skip-existing || echo "Failed to install Python 3.12.0. Skipping Python setup."

  pyenv global 3.12.0
  echo 'eval "$(pyenv init --path)"' >> "$HOME/.zprofile"

  if curl -fsSL "$PIPFILE_URL" -o "$HOME/pip.txt"; then
    while IFS= read -r package; do
      echo "Installing Python package: $package"
      pip install "$package" || echo "Failed to install Python package: $package. Skipping."
    done < "$HOME/pip.txt"

    rm "$HOME/pip.txt" # Cleanup
  else
    echo "Failed to download pip.txt. Skipping Python setup."
    return 1
  fi
}

function setup_zsh() {
  echo "Downloading and applying Zsh configuration..."
  curl -fsSL "$ZSHRC_URL" -o "$HOME/.zshrc" || echo "Failed to download .zshrc. Skipping."
  curl -fsSL "$HUSHLOGIN_URL" -o "$HOME/.hushlogin" || echo "Failed to download .hushlogin. Skipping."
}

function setup_lazygit() {
  echo "Downloading and applying Lazygit configuration..."
  curl -fsSL "$LAZYGIT_CONFIG_URL" -o "$LAZYGIT_CONFIG_DIR/config.yml" || echo "Failed to download Lazygit config. Skipping."
}

function setup_sublime() {
  echo "Downloading and applying Sublime Text configuration..."
  curl -fsSL "$SUBLIME_SETTINGS_URL" -o "$SUBLIME_SETTINGS_DIR/Preferences.sublime-settings" || echo "Failed to download Sublime Text settings. Skipping."
}

function setup_git() {
  echo "Downloading and applying Git configuration..."
  curl -fsSL "$GITCONFIG_URL" -o "$HOME/.gitconfig" || echo "Failed to download .gitconfig. Skipping."
  curl -fsSL "$GITIGNORE_GLOBAL_URL" -o "$HOME/.gitignore_global" || echo "Failed to download .gitignore_global. Skipping."
}

function install_font() {
  echo "Downloading and installing JetBrains Mono Nerd Font..."
  curl -fsSL "$FONT_URL" -o "$FONT_DIR/JetBrainsMonoNerdFont-Regular.ttf" || echo "Failed to download JetBrains Mono Nerd Font. Skipping."
}

function setup_ranger_devicons() {
  echo "Setting up ranger..."
  git clone https://github.com/alexanderjeurissen/ranger_devicons ~/.config/ranger/plugins/ranger_devicons || echo "Failed to clone ranger_devicons plugin. Skipping."
  echo "default_linemode devicons" >> $HOME/.config/ranger/rc.conf
}

function setup_iterm2() {
    echo "Setting up iTerm2..."
    curl -fsSL "$PROFILE_JSON_URL" -o "$DYNAMIC_PROFILES_DIR/rob.json" || echo "Failed to fetch the iTerm2 profile. Skipping."
    echo "Profile fetched and copied to DynamicProfiles. Restart iTerm2 to apply changes."
}

function prompt_user() {
  local question=$1

  while true; do
    read -p "$question [Y/N]: " choice
    case "$choice" in
      y|Y ) return 0 ;;
      n|N ) return 1 ;;
      * ) echo "Invalid choice. Please enter Y or N." ;;
    esac
  done
}

# Check if the --interactive flag is provided
if [[ "$1" == "--interactive" ]]; then
  # Interactive menu
  if prompt_user "Setup Homebrew?"; then
    setup_homebrew
  fi

  if prompt_user "Setup Cargo?"; then
    setup_cargo
  fi

  if prompt_user "Setup Python?"; then
    setup_python
  fi

  if prompt_user "Setup Zsh?"; then
    setup_zsh
  fi

  if prompt_user "Setup Lazygit?"; then
    setup_lazygit
  fi

  if prompt_user "Setup Sublime Text?"; then
    setup_sublime
  fi

  if prompt_user "Setup Git?"; then
    setup_git
  fi

  if prompt_user "Setup Ranger?"; then
    setup_ranger_devicons
  fi

  if prompt_user "Setup iTerm2?"; then
    setup_iterm2
  fi

  if prompt_user "Setup Font?"; then
    install_font
  fi
else
  # Non-interactive mode, run all setup tasks
  setup_homebrew
  setup_cargo
  setup_python
  setup_zsh
  setup_lazygit
  setup_sublime
  setup_git
  install_font
  setup_ranger_devicons
  setup_iterm2
fi

echo "Setup completed."
echo "Restarting the shell..."
exec zsh
