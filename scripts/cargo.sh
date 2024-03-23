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
    # Extract just the package name (before the first space)
    package_name=$(echo "$line" | awk '{print $1}')
    # Remove potential trailing colon
    package_name=${package_name%:}
    if [ ! -z "$package_name" ]; then
        echo "Installing $package_name..."
        cargo install "$package_name"
    fi
done < "$CARGO_PACKAGES_FILE"

echo "Cargo setup completed."
