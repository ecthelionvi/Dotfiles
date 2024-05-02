import os
import sys

BLUE_TEXT = "\033[94m"
RED_TEXT = "\033[91m"
RESET_TEXT = "\033[0m"
GREEN_TEXT = "\033[32m"


def create_file_with_path(file_path):
    # Check if the path is a directory
    if os.path.isdir(file_path):
        print(f"Error: '{RED_TEXT}{file_path}{RESET_TEXT}' is a directory.")
        return

    # Extract the directory path and file name
    directory = os.path.dirname(file_path)
    file_name = os.path.basename(file_path)

    # Create the directory if it does not exist
    if directory and not os.path.exists(directory):
        os.makedirs(directory)

    try:
        # Create the file, similar to "touch"
        # "open" with "a" option will create the file if it doesn't exist and won't truncate it if it does
        with open(file_path, "a"):
            pass  # Just to trigger the file creation without writing anything
            print(
                f"{GREEN_TEXT}Created{RESET_TEXT} {RED_TEXT}{directory+'/' if directory else ''}{BLUE_TEXT}{file_name}{RESET_TEXT}"
            )
    except Exception as e:
        # Handle other exceptions that may occur
        print(
            f"Failed to create or open the file '{RED_TEXT}{directory}/{BLUE_TEXT}{file_name}{RESET_TEXT}': {str(e)}"
        )


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print(f"Usage: python touch.py {BLUE_TEXT}<path/to/file>{RESET_TEXT}")
    else:
        file_path = sys.argv[1]
        create_file_with_path(file_path)
