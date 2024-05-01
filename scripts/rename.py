import os
import sys

GREEN_TEXT = "\033[92m"
YELLOW_TEXT = "\033[93m"
RED_TEXT = "\033[91m"
RESET_TEXT = "\033[0m"


def rename_file(old_name, new_name):
    try:
        os.rename(old_name, new_name)
        # Green for the words "Renamed" and "to", yellow for old_name, red for new_name
        print(
            f"{GREEN_TEXT}Renamed{RESET_TEXT} {YELLOW_TEXT}{old_name}{RESET_TEXT} {GREEN_TEXT}to{RESET_TEXT} {RED_TEXT}{new_name}{RESET_TEXT}"
        )
    except FileNotFoundError:
        print(f"File not found: {YELLOW_TEXT}{old_name}{RESET_TEXT}")
    except OSError as e:
        print(
            f"Error renaming {YELLOW_TEXT}{old_name}{RESET_TEXT} to {RED_TEXT}{new_name}{RESET_TEXT}: {e}"
        )


if __name__ == "__main__":
    if len(sys.argv) != 3:
        print(
            f"Usage: python rename.py {YELLOW_TEXT}[old_name]{RESET_TEXT} {RED_TEXT}[new_name]{RESET_TEXT}"
        )
        sys.exit(1)

    old_name = sys.argv[1]
    new_name = sys.argv[2]
    rename_file(old_name, new_name)
