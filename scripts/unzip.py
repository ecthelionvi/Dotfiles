import subprocess
import sys
import os

GREEN_TEXT = "\033[92m"
BLUE_TEXT = "\033[94m"
YELLOW_TEXT = "\033[93m"
RESET_TEXT = "\033[0m"


def unzip_file(zip_file_path, extract_to=None):
    if not os.path.isfile(zip_file_path):
        print(f"{zip_file_path} not found")
        sys.exit(1)

    if extract_to is None:
        extract_to = os.path.splitext(zip_file_path)[0]

    if not os.path.exists(extract_to):
        os.makedirs(extract_to)

    # Running the unzip command with suppressed output
    try:
        with open(os.devnull, "wb") as devnull:
            subprocess.check_call(
                ["unzip", "-d", extract_to, zip_file_path], stdout=devnull
            )

        # Green "Unzipped into" and blue directory name
        print(
            f"{GREEN_TEXT}Unzipped into{RESET_TEXT} {BLUE_TEXT}{extract_to}{RESET_TEXT}"
        )
    except subprocess.CalledProcessError as e:
        print(f"Error unzipping file: {e}")
    except Exception as e:
        print(f"An unexpected error occurred: {e}")


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print(
            f"Usage: python unzip.py {BLUE_TEXT}<zip_file_path>{RESET_TEXT} {YELLOW_TEXT}[extraction_path]{RESET_TEXT}"
        )
        sys.exit(1)

    zip_file_path = sys.argv[1]
    extraction_path = sys.argv[2] if len(sys.argv) > 2 else None
    unzip_file(zip_file_path, extraction_path)
