#!/bin/bash

# Check for Brewfile path argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 /path/to/your/Brewfile"
    exit 1
fi

BREWFILE_PATH=$1

# Check if Homebrew is installed
if ! command -v brew &>/dev/null; then
    echo "Homebrew not found, installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew is already installed."
fi

# Restore Homebrew packages from Brewfile
echo "Restoring Homebrew packages from Brewfile..."
brew bundle --file="$BREWFILE_PATH"

echo "Homebrew setup completed."
