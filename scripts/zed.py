import subprocess
import sys
import questionary  # Import the questionary library


def main():
    if len(sys.argv) != 2:
        print("Usage: python zed.py <file>")
        sys.exit(1)

    filename = sys.argv[1]

    # Use questionary to ask for the target (old name) and replacement (new name) words
    old_name = questionary.text("Enter the old name:").ask()
    new_name = questionary.text("Enter the new name:").ask()

    # Check if user canceled the input
    if old_name is None or new_name is None:
        print("Input was canceled. Exiting.")
        sys.exit(1)

    # Adjust the sed command for macOS compatibility
    # Use `-i ''` to edit in place without creating a backup file
    sed_command = f"sed -i '' 's/{old_name}/{new_name}/g' {filename}"

    try:
        subprocess.run(sed_command, check=True, shell=True)
        # Print success message with colored parts
        print(
            f"\033[92mRenamed\033[0m \033[93m{old_name}\033[0m \033[92mto\033[0m \033[91m{new_name}\033[0m"
        )
    except subprocess.CalledProcessError as e:
        print(f"An error occurred while trying to replace the word: {e}")


if __name__ == "__main__":
    main()
