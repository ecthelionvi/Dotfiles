import subprocess
import sys


def main():
    if len(sys.argv) != 2:
        print("Usage: python zed.py <file>")
        sys.exit(1)

    filename = sys.argv[1]
    target_word = input("Enter the target word: ")
    replacement_word = input("Enter the replacement word: ")

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
