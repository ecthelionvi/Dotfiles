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

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    # Install Homebrew if it's not found
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Download and setup Brewfile
curl -fsSL "$BREWFILE_URL" -o "$HOME/Brewfile"
brew bundle --file="$HOME/Brewfile"
rm "$HOME/Brewfile" # Cleanup
rm "$HOME/Brewfile.lock.json" # Cleanup Brewfile.lock.json

# Setup Cargo and download CargoPackages.txt
curl -fsSL "$CARGOPACKAGES_URL" -o "$HOME/CargoPackages.txt"
command -v cargo &>/dev/null || brew install rust
while IFS= read -r line; do
    package_name=$(echo "$line" | awk '{print $1}' | sed 's/://')
    cargo install "$package_name"
done < "$HOME/CargoPackages.txt"
rm "$HOME/CargoPackages.txt" # Cleanup

# Python setup with pyenv and pip
command -v pyenv &>/dev/null || brew install pyenv
pyenv install 3.12.0 --skip-existing
pyenv global 3.12.0
echo 'eval "$(pyenv init --path)"' >> "$HOME/.zprofile"
curl -fsSL "$PIPFILE_URL" -o "$HOME/pip.txt"
while IFS= read -r package; do
    pip install "$package"
done < "$HOME/pip.txt"
rm "$HOME/pip.txt" # Cleanup

# Download and apply Dotfiles (.zshrc and .hushlogin)
curl -fsSL "$ZSHRC_URL" -o "$HOME/.zshrc"
curl -fsSL "$HUSHLOGIN_URL" -o "$HOME/.hushlogin"

# Download and apply lazygit config
curl -fsSL "$LAZYGIT_CONFIG_URL" -o "$LAZYGIT_CONFIG_DIR/config.yml"

# Download and apply git config files (.gitconfig and .gitignore_global)
curl -fsSL "$GITCONFIG_URL" -o "$HOME/.gitconfig"
curl -fsSL "$GITIGNORE_GLOBAL_URL" -o "$HOME/.gitignore_global"

# Download and apply Sublime Text settings
curl -fsSL "$SUBLIME_SETTINGS_URL" -o "$SUBLIME_SETTINGS_DIR/Preferences.sublime-settings"

echo "Setup completed. Please restart your shell."

# Clean up the script itself
rm -- "$0"
