import subprocess
import sys
import os

GREEN_TEXT = "\033[92m"
RESET_TEXT = "\033[0m"
BLUE_TEXT = "\033[34m"


def copy_to_clipboard(file_path):
    try:
        with open(file_path, "rb") as file:
            process = subprocess.Popen("pbcopy", stdin=subprocess.PIPE)
            process.communicate(file.read())

        file_name = os.path.basename(file_path)

        print(
            f"Copied {BLUE_TEXT}{file_name}{RESET_TEXT} to clipboard"
        )

    except FileNotFoundError:
        print(f"{BLUE_TEXT}{file_path}{RESET_TEXT} not found")
    except Exception as e:
        print(f"An error occurred: {e}")


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python clip.py <file_path>")
    else:
        copy_to_clipboard(sys.argv[1])
