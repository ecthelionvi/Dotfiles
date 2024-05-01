import os
import sys


def rename_file(old_name, new_name):
    try:
        os.rename(old_name, new_name)
        # Applying ANSI color codes: cyan for old_name, yellow for new_name
        print(f"Renamed \033[96m{old_name}\033[0m to \033[93m{new_name}\033[0m")
    except FileNotFoundError:
        print(f"File not found: \033[96m{old_name}\033[0m")
    except OSError as e:
        print(
            f"Error renaming \033[96m{old_name}\033[0m to \033[93m{new_name}\033[0m: {e}"
        )


if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python rename.py [old_name] [new_name]")
        sys.exit(1)

    old_name = sys.argv[1]
    new_name = sys.argv[2]

    rename_file(old_name, new_name)
