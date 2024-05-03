import os
import sys
import subprocess
import questionary


GREEN_TEXT = "\033[92m"
RED_TEXT = "\033[91m"
RESET_TEXT = "\033[0m"


def zip_folder(folder_path):
    if not os.path.isdir(folder_path):
        print(
            f"The path {RED_TEXT}{folder_path}{RESET_TEXT} is not a directory or does not exist."
        )
        sys.exit(1)

    folder_name = os.path.basename(folder_path)
    zip_file_name = f"{folder_name}_backup.zip"

    try:
        with open(os.devnull, "wb") as devnull:
            subprocess.check_call(
                ["zip", "-r", zip_file_name, folder_path],
                stdout=devnull,
                stderr=devnull,
            )
    except subprocess.CalledProcessError as e:
        print(f"Error zipping folder: {e}")
        sys.exit(1)
    except Exception as e:
        print(f"An unexpected error occurred: {e}")
        sys.exit(1)


def replace_text(directory, old_text, new_text):
    for subdir, dirs, files in os.walk(directory):
        for file in files:
            filepath = os.path.join(subdir, file)
            try:
                with open(filepath, "r", encoding="utf-8", errors="ignore") as file:
                    filedata = file.read()
                filedata = filedata.replace(old_text, new_text)
                with open(filepath, "w", encoding="utf-8", errors="ignore") as file:
                    file.write(filedata)
            except IOError as e:
                print(f"Error processing file {filepath}: {e}")


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python rzed.py <directory>")
        sys.exit(1)

    directory = sys.argv[1]
    if not os.path.isdir(directory):
        print(f"{RED_TEXT}{directory}/{RESET_TEXT} not found")
        sys.exit(1)

    create_backup = questionary.confirm("Do you want to create a backup?").ask()

    if create_backup:
        old_text = questionary.text("Enter the old text:").ask()
        new_text = questionary.text("Enter the new text:").ask()
        zip_folder(directory)
        replace_text(directory, old_text, new_text)
        print(f"Replacement complete in {RED_TEXT}{directory}/{RESET_TEXT}")
    else:
        sys.exit(1)
