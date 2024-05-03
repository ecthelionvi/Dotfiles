import os
import fnmatch


def find_and_delete_files(pattern, root_dir):
    for root, dirs, files in os.walk(root_dir):
        for filename in fnmatch.filter(files, pattern):
            file_path = os.path.join(root, filename)
            try:
                os.remove(file_path)
            except OSError:
                pass


if __name__ == "__main__":
    pattern = ".DS_Store"
    root_dir = os.path.expanduser("~")

    find_and_delete_files(pattern, root_dir)
