# Super Setup Script

This script automates the setup process for your development environment by installing and configuring various tools and packages.

## Usage

To execute the script using curl, run the following command in your terminal:

```bash
curl -fsSL https://raw.githubusercontent.com/ecthelionvi/Dotfiles/main/scripts/super.sh | bash
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

After the script finishes executing, it will display a message indicating that the setup is completed and prompts you to restart your shell for the changes to take effect.

## Notes

- Make sure you have a stable internet connection while running the script, as it downloads files from the GitHub repository.
- The script assumes that the necessary directories for lazygit and other configurations already exist. If they don't, you may need to create them manually.
- Review the contents of the files being downloaded (`Brewfile`, `CargoPackages.txt`, `pip.txt`, `.zshrc`, `.hushlogin`, `config.yml`, `.gitconfig`, `.gitignore_global`) to ensure they align with your requirements.

If you encounter any issues or have questions, please refer to the GitHub repository or contact the maintainer for assistance.
