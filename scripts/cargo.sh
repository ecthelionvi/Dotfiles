#!/bin/bash

# Check for Cargo packages file path argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 /path/to/your/CargoPackages.txt"
    exit 1
fi

CARGO_PACKAGES_FILE=$1

# Check if Cargo is installed
if ! command -v cargo &>/dev/null; then
    echo "Cargo not found, installing Cargo..."
    brew install rust
else
    echo "Cargo is already installed."
fi

# Install Cargo packages from list
echo "Installing Cargo packages from list..."
while IFS= read -r line; do
    package_name=$(echo "$line" | awk '{print $1}') # Modify this line as needed to parse your CargoPackages.txt correctly
    if [ ! -z "$package_name" ]; then
        cargo install "$package_name"
    fi
done < "$CARGO_PACKAGES_FILE"

echo "Cargo setup completed."
