# Scripts Overview

This document provides an overview and usage instructions for three scripts designed to automate the setup of development environments: `brew.sh` for Homebrew, `cargo.sh` for Cargo, and `python.sh` for managing Python versions with `pyenv`.

## brew.sh - Homebrew Setup

`brew.sh` is a script for installing Homebrew (if not already installed) and restoring packages from a provided `Brewfile`.

### How It Works:

1. Checks if Homebrew is installed by trying to run `brew` command.
2. If Homebrew is not found, it installs Homebrew using the official installation script from Homebrew's GitHub repository.
3. Restores packages and casks from the specified `Brewfile`.

### Usage:

```bash
./brew.sh /path/to/your/Brewfile
```

### Parameters:

- **Brewfile Path**: The first and only argument to the script, specifying the location of your `Brewfile`.

## cargo.sh - Cargo Setup

`cargo.sh` is designed to ensure Cargo (Rust's package manager) is installed and then install a list of Rust packages from a provided text file.

### How It Works:

1. Checks if Cargo is installed by trying to run `cargo` command.
2. If Cargo is not found, it installs Rust (which includes Cargo) via Homebrew.
3. Reads a list of package names from a provided file and installs each package using `cargo install`.

### Usage:

```bash
./cargo.sh /path/to/your/CargoPackages.txt
```

### Parameters:

- **CargoPackages.txt Path**: The path to a text file containing a list of Cargo packages to install. Each package should be on its own line.

## python.sh - Pyenv and Python Setup

`python.sh` automates the installation of `pyenv` via Homebrew, installs a specific version of Python (e.g., 3.12.0), and sets it as the global Python version.

### How It Works:

1. Installs `pyenv` using Homebrew.
2. Installs the specified version of Python using `pyenv install`.
3. Sets the installed Python version as the global default version for the system.
4. Adds `pyenv init` to the shell's configuration file (`.zprofile`) to ensure `pyenv` is properly initialized in future shell sessions.

### Usage:

```bash
./python.sh
```

### Note:

The `python.sh` script is hardcoded to install Python 3.12.0 and modify `.zprofile`. If you need a different Python version or use a different shell configuration file, you will need to modify the script accordingly.

## Conclusion

These scripts are designed to streamline the setup of development environments by automating the installation and configuration of Homebrew, Cargo, and Python versions via `pyenv`. Ensure you have the necessary permissions to install software on your system before running these scripts.
