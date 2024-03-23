import os
import fnmatch
import itertools
import threading
import time
import sys

# Spinner
def spinner():
    spinner = itertools.cycle(['-', '/', '|', '\\'])
    while True:
        sys.stdout.write(next(spinner))   # write the next character
        sys.stdout.flush()                # flush stdout buffer (actual character display)
        sys.stdout.write('\b')            # erase the last written char
        time.sleep(0.1)                   # short delay before the next update

def find_and_delete_files(pattern, root_dir):
    deleted_files_count = 0
    for root, dirs, files in os.walk(root_dir):
        for filename in fnmatch.filter(files, pattern):
            file_path = os.path.join(root, filename)
            try:
                os.remove(file_path)
                deleted_files_count += 1
                print(f"\rDeleted {file_path}")
            except OSError as e:
                print(f"\rError deleting {file_path}: {e}")
    return deleted_files_count

if __name__ == "__main__":
    pattern = ".DS_Store"
    root_dir = os.path.expanduser("~")  # Start search from the user's home directory

    # Start spinner in a separate thread
    spinner_thread = threading.Thread(target=spinner, daemon=True)
    spinner_thread.start()

    deleted_files_count = find_and_delete_files(pattern, root_dir)

    # Stop spinner
    spinner_thread.join(timeout=0.1)
    sys.stdout.write('\b \b')  # Clear the spinner character
    print(f"Deleted {deleted_files_count} Files")
