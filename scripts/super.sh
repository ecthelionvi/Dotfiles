#!/bin/bash

# Prompt user for the path to the Brewfile
echo "Please enter the path to your Brewfile:"
read BREWFILE_PATH

# Check if the Brewfile exists
if [[ -f "$BREWFILE_PATH" ]]; then
    echo "Running brew.sh with $BREWFILE_PATH"
    ./brew.sh "$BREWFILE_PATH"
else
    echo "Brewfile not found at $BREWFILE_PATH, skipping Homebrew setup."
fi

# Prompt user for the path to the Cargo packages list
echo "Please enter the path to your CargoPackages.txt:"
read CARGO_PACKAGES_FILE

# Check if the CargoPackages.txt exists
if [[ -f "$CARGO_PACKAGES_FILE" ]]; then
    echo "Running cargo.sh with $CARGO_PACKAGES_FILE"
    ./cargo.sh "$CARGO_PACKAGES_FILE"
else
    echo "CargoPackages.txt not found at $CARGO_PACKAGES_FILE, skipping Cargo setup."
fi

# Run python.sh script
echo "Running python.sh for Python setup..."
./python.sh

echo "All setup scripts have been executed."
