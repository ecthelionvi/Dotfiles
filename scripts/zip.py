import subprocess
import sys
import os

GREEN_TEXT = "\033[92m"
RED_TEXT = "\033[91m"
RESET_TEXT = "\033[0m"


def zip_folder(folder_path):
    if not os.path.isdir(folder_path):
        print(f"The path {folder_path} is not a directory or does not exist.")
        sys.exit(1)

    folder_name = os.path.basename(folder_path)
    zip_file_name = f"{folder_name}.zip"

    # Running the zip command with suppressed output
    try:
        with open(os.devnull, "wb") as devnull:
            subprocess.check_call(
                ["zip", "-r", zip_file_name, folder_path], stdout=devnull
            )

        # Green "Zipped into" and red zip file name
        print(
            f"{GREEN_TEXT}Zipped into{RESET_TEXT} {RED_TEXT}{zip_file_name}{RESET_TEXT}"
        )
    except subprocess.CalledProcessError as e:
        print(f"Error zipping folder: {e}")
    except Exception as e:
        print(f"An unexpected error occurred: {e}")


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python zip.py <folder_path>")
        sys.exit(1)

    folder_path = sys.argv[1]
    zip_folder(folder_path)
