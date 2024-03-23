#!/bin/bash

SCRIPT_DIR="$(dirname "$0")"
BREWFILE_PATH="$SCRIPT_DIR/Brewfile"
CARGO_PACKAGES_FILE="$SCRIPT_DIR/CargoPackages.txt"
PIP_FILE_PATH="$SCRIPT_DIR/pip.txt" # Added line for pip.txt file path

# Check if the Brewfile exists in the same directory as the script
if [[ -f "$BREWFILE_PATH" ]]; then
    echo "Brewfile found. Running brew.sh with $BREWFILE_PATH"
    ./brew.sh "$BREWFILE_PATH"
else
    # If not found, prompt user for the path
    echo "Brewfile not found in script directory. Please enter the path to your Brewfile:"
    read BREWFILE_PATH
    if [[ -f "$BREWFILE_PATH" ]]; then
        echo "Running brew.sh with $BREWFILE_PATH"
        ./brew.sh "$BREWFILE_PATH"
    else
        echo "Brewfile not found at $BREWFILE_PATH, skipping Homebrew setup."
    fi
fi

# Check if the CargoPackages.txt exists in the same directory as the script
if [[ -f "$CARGO_PACKAGES_FILE" ]]; then
    echo "CargoPackages.txt found. Running cargo.sh with $CARGO_PACKAGES_FILE"
    ./cargo.sh "$CARGO_PACKAGES_FILE"
else
    # If not found, prompt user for the path
    echo "CargoPackages.txt not found in script directory. Please enter the path to your CargoPackages.txt:"
    read CARGO_PACKAGES_FILE
    if [[ -f "$CARGO_PACKAGES_FILE" ]]; then
        echo "Running cargo.sh with $CARGO_PACKAGES_FILE"
        ./cargo.sh "$CARGO_PACKAGES_FILE"
    else
        echo "CargoPackages.txt not found at $CARGO_PACKAGES_FILE, skipping Cargo setup."
    fi
fi

# Run python.sh script
echo "Running python.sh for Python setup..."
./python.sh

# Added section for pip.sh script execution
# Check if the pip.txt exists in the same directory as the script
if [[ -f "$PIP_FILE_PATH" ]]; then
    echo "pip.txt found. Running pip.sh with $PIP_FILE_PATH"
    ./pip.sh "$PIP_FILE_PATH" # This assumes pip.sh is designed to take the file path as an argument
else
    echo "pip.txt not found in script directory, skipping pip package installations."
fi

echo "All setup scripts have been executed."
