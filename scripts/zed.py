import subprocess
import sys
import questionary


def main():
    if len(sys.argv) != 2:
        print("Usage: python zed.py <file>")
        sys.exit(1)

    filename = sys.argv[1]

    # Use questionary to ask for the target and replacement words
    target_word = questionary.text("Enter the target word:").ask()
    replacement_word = questionary.text("Enter the replacement word:").ask()

    # Check if user canceled the input
    if target_word is None or replacement_word is None:
        print("Input was canceled. Exiting.")
        sys.exit(1)

    # Adjust the sed command for macOS compatibility
    # Use `-i ''` to edit in place without creating a backup file
    sed_command = f"sed -i '' 's/{target_word}/{replacement_word}/g' {filename}"

    try:
        subprocess.run(sed_command, check=True, shell=True)
        print("Success: The word has been replaced.")
    except subprocess.CalledProcessError as e:
        print(f"An error occurred while trying to replace the word: {e}")


if __name__ == "__main__":
    main()
