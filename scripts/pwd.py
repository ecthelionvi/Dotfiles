import subprocess
import sys
import os

GREEN_TEXT = "\033[92m"
RESET_TEXT = "\033[0m"


def copy_pwd_to_clipboard(file_path=None):
    try:
        # Determine the path to use
        if file_path:
            pwd = os.path.realpath(file_path)
        else:
            pwd = os.path.realpath(os.getcwd())

        # Initialize subprocess to use pbcopy to copy to clipboard
        process = subprocess.Popen(["pbcopy"], stdin=subprocess.PIPE)
        process.communicate(input=pwd.encode())

        # Success output
        print(f"Copied {GREEN_TEXT}{pwd}{RESET_TEXT} to clipboard")
    except Exception as e:
        # Error handling
        print(f"An error occurred: {e}")


if __name__ == "__main__":
    # Ensure that the command line usage is correct
    if len(sys.argv) > 2:
        print("Usage: python script.py [file_path]")
    elif len(sys.argv) == 2:
        copy_pwd_to_clipboard(sys.argv[1])
    else:
        copy_pwd_to_clipboard()
