#!/bin/bash

# Configure your email address
echo "Enter your email address: "
read email

# SSH key configuration
ssh_dir="$HOME/.ssh"
key_filename="id_ed25519"
key_path="$ssh_dir/$key_filename"
config_file="$ssh_dir/config"

# Create .ssh directory if it doesn't exist
if [ ! -d "$ssh_dir" ]; then
    mkdir -p "$ssh_dir"
    echo "Created SSH directory at $ssh_dir"
fi

# Check for existing SSH keys
if ls "$ssh_dir/$key_filename"* 1> /dev/null 2>&1; then
    echo "Existing SSH keys found:"
    ls -l "$ssh_dir/$key_filename"*
    echo "Consider backing up and removing these before generating new ones, or use a different filename."
else
    echo "When prompted, enter a passphrase for your SSH key (optional, but recommended for additional security)."
    ssh-keygen -t ed25519 -C "$email" -f "$key_path"
    echo "SSH key pair generated successfully:"
    echo "- Private key: $key_path"
    echo "- Public key: ${key_path}.pub"
fi

# Add private key to the ssh-agent and store passphrase in the keychain
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS systems
    ssh-add --apple-use-keychain "$key_path"
else
    # Non-macOS systems
    ssh-add "$key_path"
fi
echo "SSH key added to ssh-agent and keychain."

# Check if config file exists, create if it doesn't, and append configuration
if [ ! -f "$config_file" ]; then
    touch "$config_file"
fi

# Add or update the SSH config file to automatically load keys and use keychain
if ! grep -q "Host github.com" "$config_file"; then
    echo "Host github.com" >> "$config_file"
    echo "  AddKeysToAgent yes" >> "$config_file"
    echo "  UseKeychain yes" >> "$config_file"
    echo "  IdentityFile $key_path" >> "$config_file"
fi

# Instructions for adding the SSH key to GitHub
echo
echo "Next steps:"
echo "1. Copy your SSH public key to the clipboard:"
echo "   macOS: pbcopy < ${key_path}.pub"
echo "   Linux (requires xclip): xclip -sel clip < ${key_path}.pub"
echo "   Windows (Git Bash): clip < ${key_path}.pub"
echo
echo "2. Go to GitHub and navigate to Settings -> SSH and GPG keys -> New SSH key."
echo "3. Paste your SSH public key into the 'Key' field and give it a meaningful title."
echo "4. Click 'Add SSH key'."
echo
echo "5. Test your SSH connection:"
echo "   ssh -T git@github.com"
echo
echo "You should see a message that you've successfully authenticated, but GitHub does not provide shell access."
