#!/bin/bash

# Define source and destination directories
DOTFILES_DIR="$HOME/Documents/Dotfiles/zsh"
DEST_DIR="$HOME"

# List of files to copy
FILES_TO_COPY=(".zshrc" ".hushlogin")

# Loop through each file and copy it to the home directory
for file in "${FILES_TO_COPY[@]}"; do
    SRC_PATH="$DOTFILES_DIR/$file"
    DEST_PATH="$DEST_DIR/$file"

    # Check if the source file exists
    if [[ -f "$SRC_PATH" ]]; then
        # If the destination file already exists, back it up
        if [[ -f "$DEST_PATH" ]]; then
            echo "Backing up existing $file to $file.backup"
            mv "$DEST_PATH" "$DEST_PATH.backup"
        fi

        # Copy the file from Dotfiles to the home directory
        echo "Copying $file to home directory"
        cp "$SRC_PATH" "$DEST_PATH"
    else
        echo "Source file $SRC_PATH does not exist. Skipping."
    fi
done

echo "Done Copying Zsh Files"
