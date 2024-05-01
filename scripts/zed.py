import subprocess
import sys


def main():
    # Check if the filename is provided as a command-line argument
    if len(sys.argv) != 2:
        print("Usage: python zed.py <file>")
        sys.exit(1)

    filename = sys.argv[1]

    # Get the target word and replacement word from the user
    target_word = input("Enter the target word: ")
    replacement_word = input("Enter the replacement word: ")

    # Constructing the sed command
    sed_command = f"sed -i 's/{target_word}/{replacement_word}/g' {filename}"

    # Execute the sed command
    try:
        subprocess.run(sed_command, check=True, shell=True)
        print("Success: The word has been replaced.")
    except subprocess.CalledProcessError as e:
        print("An error occurred while trying to replace the word.")


if __name__ == "__main__":
    main()
