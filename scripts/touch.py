import os
import sys

BLUE_TEXT = "\033[94m"
RED_TEXT = "\033[91m"
RESET_TEXT = "\033[0m"


def is_directory(path):
    return os.path.isdir(path)


def path_exists(path):
    return os.path.exists(path)


def create_directory(directory):
    if path_exists(directory):
        return f"{RED_TEXT}{directory}/{RESET_TEXT}", "exists"
    else:
        os.makedirs(directory)
        return f"{RED_TEXT}{directory}/{RESET_TEXT}", "created"


def create_file(path):
    if is_directory(path):
        return f"{RED_TEXT}{path}/{RESET_TEXT}", "directory"
    if path_exists(path):
        directory = os.path.dirname(path)
        file_name = os.path.basename(path)
        if directory:
            return f"{RED_TEXT}{directory}/{BLUE_TEXT}{file_name}{RESET_TEXT}", "exists"
        else:
            return f"{BLUE_TEXT}{file_name}{RESET_TEXT}", "exists"
    directory = os.path.dirname(path)
    file_name = os.path.basename(path)
    if directory and not path_exists(directory):
        os.makedirs(directory)
    try:
        with open(path, "a"):
            pass
        if directory:
            return (
                f"{RED_TEXT}{directory}/{BLUE_TEXT}{file_name}{RESET_TEXT}",
                "created",
            )
        else:
            return f"{BLUE_TEXT}{file_name}{RESET_TEXT}", "created"
    except Exception as e:
        return f"{file_name}", "failed"


def create_item(path):
    if path.endswith("/"):
        return create_directory(path[:-1])
    else:
        return create_file(path)


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print(
            "Usage: python touch.py <path/to/file_or_directory> [<file_or_directory> ...]"
        )
    else:
        created_items = []
        existing_items = []
        directory_items = []
        failed_items = []
        for path in sys.argv[1:]:
            item, status = create_item(path)
            if status == "created":
                created_items.append(item)
            elif status == "exists":
                existing_items.append(item)
            elif status == "directory":
                directory_items.append(item)
            elif status == "failed":
                failed_items.append(item)

        if created_items:
            print("Created:", " ".join(created_items))
        if existing_items:
            if len(existing_items) == 1:
                print(" ".join(existing_items), "already exists")
            else:
                print(" ".join(existing_items), "already exist")
        if directory_items:
            if len(directory_items) == 1:
                print(" ".join(directory_items), "is a directory")
            else:
                print(" ".join(directory_items), "are directories")
        if failed_items:
            print("Failed to create or open:", " ".join(failed_items))
