import os
import sys


def create_file_with_path(file_path):
    # Check if the path is a directory
    if os.path.isdir(file_path):
        print(f"Error: '{file_path}' is a directory.")
        return

    # Extract the directory path
    directory = os.path.dirname(file_path)

    # Create the directory if it does not exist
    if directory and not os.path.exists(directory):
        os.makedirs(directory)

    try:
        # Create the file, similar to "touch"
        # "open" with "a" option will create the file if it doesn't exist and won't truncate it if it does
        with open(file_path, "a"):
            pass  # Just to trigger the file creation without writing anything
    except Exception as e:
        # Handle other exceptions that may occur
        print(f"Failed to create or open the file '{file_path}': {str(e)}")


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python touch.py <path/to/file>")
    else:
        file_path = sys.argv[1]
        create_file_with_path(file_path)
