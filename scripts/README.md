# Super Setup Script

This script automates the setup process for your development environment by installing and configuring various tools and packages.

## Usage

To execute the script using curl, run the following command in your terminal:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/ecthelionvi/Dotfiles/main/scripts/super.sh) --interactive
```

This command fetches the `super.sh` script from the GitHub repository and executes it using bash.

## Script Explanation

The `super.sh` script performs the following tasks:

1. **Homebrew and Brewfile Setup**
   - Downloads the `Brewfile` from the GitHub repository.
   - Installs Homebrew if it's not already installed.
   - Installs the packages and tools listed in the `Brewfile` using `brew bundle`.
   - Cleans up the downloaded `Brewfile`.

2. **Cargo and CargoPackages Setup**
   - Downloads the `CargoPackages.txt` file from the GitHub repository.
   - Installs Rust and Cargo if not already installed.
   - Reads the `CargoPackages.txt` file and installs each Cargo package listed.
   - Cleans up the downloaded `CargoPackages.txt` file.

3. **Python Setup with pyenv and pip**
   - Installs pyenv if not already installed.
   - Installs Python 3.12.0 using pyenv if not already installed.
   - Sets Python 3.12.0 as the global Python version.
   - Adds the necessary pyenv initialization command to the `.zprofile` file.
   - Downloads the `pip.txt` file from the GitHub repository.
   - Reads the `pip.txt` file and installs each Python package listed using pip.
   - Cleans up the downloaded `pip.txt` file.

4. **Zsh Setup**
   - Downloads the `.zshrc` and `.hushlogin` files from the GitHub repository.
   - Applies the downloaded files to the home directory.

5. **Lazygit Configuration**
   - Downloads the lazygit configuration file (`config.yml`) from the GitHub repository.
   - Saves the configuration file to the lazygit configuration directory.

6. **Git Configuration**
   - Downloads the `.gitconfig` and `.gitignore_global` files from the GitHub repository.
   - Applies the downloaded files to the home directory.

7. Sublime Configuration
   - Downloads the `Preferences.sublime-settings` file from the GitHub repository.
   - Applies the downloaded file to the Sublime Text configuration directory.

9. Font Installation
   - Downloads the JetBrainsMonoNerdFont-Regular from the Github repository.

After the script finishes executing, it will display a message indicating that the setup is completed and prompts you to restart your shell for the changes to take effect.

---

# SSH Setup Script

This script automates the process of generating an SSH key, adding it to the ssh-agent, and configuring the SSH client for macOS and other Unix-like systems.

## Usage

To execute the script directly from the terminal, run the following command:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/ecthelionvi/Dotfiles/main/scripts/ssh.sh) --interactive
```

This command downloads the `ssh.sh` script from the GitHub repository and executes it using bash.

## Script Explanation

The `ssh.sh` script performs the following tasks:

1. **Prompt for Email Address**
   - Asks the user to input their email address, which is associated with the SSH key as a label.

2. **SSH Key Generation**
   - Checks for the existence of the default SSH directory and creates it if necessary.
   - Checks if an SSH key already exists to avoid overwriting it and provides instructions if one is found.
   - Generates a new SSH key using the Ed25519 algorithm with the provided email as the label.

3. **ssh-agent Integration**
   - Starts the ssh-agent if it is not already running.
   - Adds the new SSH key to the ssh-agent. On macOS, it also adds the key to the macOS keychain for secure passphrase storage.

4. **SSH Configuration for GitHub**
   - Ensures the SSH config file exists, creating it if necessary.
   - Configures the SSH client to automatically use the new SSH key for connections to GitHub and to use the macOS keychain if available.

5. **Next Steps Guidance**
   - Provides instructions on how to copy the public SSH key to the clipboard based on the user's operating system.
   - Explains the steps for adding the SSH key to the user's GitHub account.
   - Includes a command for testing the SSH connection to GitHub.
