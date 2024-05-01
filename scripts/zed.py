import subprocess
import sys
import questionary

GREEN_TEXT = "\033[92m"
YELLOW_TEXT = "\033[93m"
BLUE_TEXT = "\033[94m"
RED_TEXT = "\033[91m"
RESET_TEXT = "\033[0m"


def main():
    if len(sys.argv) != 2:
        print(f"Usage: python zed.py {BLUE_TEXT}<file>{RESET_TEXT}")
        sys.exit(1)

    filename = sys.argv[1]

    # Use questionary to ask for the old name (target) and new name (replacement)
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
            f"{GREEN_TEXT}Replaced{RESET_TEXT} {YELLOW_TEXT}{old_name}{RESET_TEXT} {GREEN_TEXT}with{RESET_TEXT} {RED_TEXT}{new_name}{RESET_TEXT}"
        )
    except subprocess.CalledProcessError as e:
        print(f"An error occurred while trying to replace the word: {e}")


if __name__ == "__main__":
    main()
