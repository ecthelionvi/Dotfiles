import os
import sys


def rename_file(old_name, new_name):
    try:
        os.rename(old_name, new_name)
        print(f"Renamed {old_name} to {new_name}")
    except FileNotFoundError:
        print(f"File not found: {old_name}")
    except OSError as e:
        print(f"Error renaming {old_name} to {new_name}: {e}")


if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python rename.py [old_name] [new_name]")
        sys.exit(1)

    old_name = sys.argv[1]
    new_name = sys.argv[2]

    rename_file(old_name, new_name)
