import os
import sys
import fnmatch
from halo import Halo  # Import Halo for the spinner


def find_and_delete_files(pattern, root_dir):
    deleted_files_count = 0
    for root, dirs, files in os.walk(root_dir):
        for filename in fnmatch.filter(files, pattern):
            file_path = os.path.join(root, filename)
            try:
                os.remove(file_path)
                deleted_files_count += 1
            except OSError as e:
                print(f"\rError deleting {file_path}: {e}")
    return deleted_files_count


if __name__ == "__main__":
    pattern = ".DS_Store"
    root_dir = os.path.expanduser("~")  # Start search from the user's home directory

    spinner = Halo(
        text="Deleting .DS_Store Files", spinner="dots"
    )  # Initialize Halo spinner
    spinner.start()  # Start the spinner

    deleted_files_count = find_and_delete_files(pattern, root_dir)

    spinner.stop()  # Stop the spinner when done
