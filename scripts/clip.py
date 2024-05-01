import subprocess
import sys

GREEN_TEXT = "\033[92m"
RESET_TEXT = "\033[0m"
BLUE_TEXT = "\033[34m"


def copy_to_clipboard(file_path):
    try:
        with open(file_path, "rb") as file:
            # Use subprocess to send file content to pbcopy
            process = subprocess.Popen("pbcopy", stdin=subprocess.PIPE)
            process.communicate(file.read())
            # Print success message in green
            print(f"{GREEN_TEXT}Copied to Clipboard{RESET_TEXT}")
    except FileNotFoundError:
        print(f"{BLUE_TEXT}{file_path}{RESET_TEXT} not found")
    except Exception as e:
        print(f"An error occurred: {e}")


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print(f"Usage: python clip.py {BLUE_TEXT}<file_path>{RESET_TEXT}")
    else:
        copy_to_clipboard(sys.argv[1])
