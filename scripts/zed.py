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

    old_name = questionary.text("Enter the old text:").ask()

    if old_name:
        new_name = questionary.text("Enter the new text:").ask()
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
