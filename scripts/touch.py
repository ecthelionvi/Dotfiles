import os
import sys

BLUE_TEXT = "\033[94m"
RED_TEXT = "\033[91m"
RESET_TEXT = "\033[0m"


def create_file_with_path(file_path):
    if os.path.isdir(file_path):
        print(f"Error: '{RED_TEXT}{file_path}{RESET_TEXT}' is a directory.")
        return

    directory = os.path.dirname(file_path)
    file_name = os.path.basename(file_path)

    if directory and not os.path.exists(directory):
        os.makedirs(directory)

    try:
        with open(file_path, "a"):
            pass
            print(
                f"Created {RED_TEXT}{directory+'/' if directory else ''}{BLUE_TEXT}{file_name}{RESET_TEXT}"
            )
    except Exception as e:
        print(f"Failed to create or open the file '{directory}/{file_name}': {str(e)}")


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python touch.py <path/to/file>")
    else:
        file_path = sys.argv[1]
        create_file_with_path(file_path)
