#!/bin/bash

# Default file name
PIP_FILE_NAME="pip.txt"

# Check if pip.txt exists in the current directory
if [[ -f "$PIP_FILE_NAME" ]]; then
    echo "Found $PIP_FILE_NAME. Proceeding with package installations..."
else
    echo "$PIP_FILE_NAME does not exist in the current directory. Exiting."
    exit 1
fi

# Ensure pip is installed
if ! command -v pip &>/dev/null; then
    echo "pip is not installed. Please install pip before proceeding."
    exit 1
fi

# Install packages from pip.txt
while IFS= read -r package; do
    echo "Installing $package..."
    pip install "$package"
done < "$PIP_FILE_NAME"

echo "Package installation completed."
