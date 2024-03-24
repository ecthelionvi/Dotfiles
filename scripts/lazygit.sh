#!/bin/bash

# Source and destination paths
SOURCE_FILE="$HOME/Documents/Dotfiles/lazygit/config.yml"
DESTINATION_DIR="$HOME/Library/Application Support/lazygit/"
DESTINATION_FILE="$DESTINATION_DIR/config.yml"

# Check if the source config file exists
if [[ -f "$SOURCE_FILE" ]]; then
    # Copy the config file to the destination, replacing if it already exists
    cp "$SOURCE_FILE" "$DESTINATION_FILE"
    echo "Lazygit config.yml has been copied to $DESTINATION_DIR"
else
    echo "Source config.yml not found: $SOURCE_FILE"
fi
