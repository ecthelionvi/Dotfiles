import subprocess
import sys
import os


def unzip_file(zip_file_path, extract_to=None):
    if not os.path.isfile(zip_file_path):
        print(f"The file {zip_file_path} does not exist or is not a file.")
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
        print(f"\033[92mUnzipped into\033[0m \033[94m{extract_to}\033[0m")
    except subprocess.CalledProcessError as e:
        print(f"Error unzipping file: {e}")
    except Exception as e:
        print(f"An unexpected error occurred: {e}")


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python unzip.py <zip_file_path> [extraction_path]")
        sys.exit(1)

    zip_file_path = sys.argv[1]
    extraction_path = sys.argv[2] if len(sys.argv) > 2 else None
    unzip_file(zip_file_path, extraction_path)
