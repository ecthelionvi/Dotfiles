#!/bin/bash

# Install pyenv with Homebrew
echo "Installing pyenv..."
brew install pyenv

# Install Python 3.12.0
echo "Installing Python 3.12.0..."
pyenv install 3.12.0

# List installed versions
echo "Listing installed Python versions..."
pyenv versions

# Set global Python version to 3.12.0
echo "Setting global Python version to 3.12.0..."
pyenv global 3.12.0

# Add pyenv init to your shell's configuration file
SHELL_CONFIG_FILE="${HOME}/.zprofile" # Changed to .zprofile for zsh users

echo 'eval "$(pyenv init --path)"' >> "$SHELL_CONFIG_FILE"

echo "Added pyenv init to $SHELL_CONFIG_FILE. Please restart your shell or run 'source $SHELL_CONFIG_FILE'."
