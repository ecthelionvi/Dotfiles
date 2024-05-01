import os
import sys
import subprocess
import questionary


def zip_folder(folder_path):
    if not os.path.isdir(folder_path):
        print(f"The path {folder_path} is not a directory or does not exist.")
        sys.exit(1)

    folder_name = os.path.basename(folder_path)
    zip_file_name = f"{folder_name}_backup.zip"

    # Running the zip command with suppressed output
    try:
        with open(os.devnull, "wb") as devnull:
            subprocess.check_call(
                ["zip", "-r", zip_file_name, folder_path],
                stdout=devnull,
                stderr=devnull,
            )
    except subprocess.CalledProcessError as e:
        print(f"Error zipping folder: {e}")
        sys.exit(1)  # Exit if zipping fails
    except Exception as e:
        print(f"An unexpected error occurred: {e}")
        sys.exit(1)  # Exit on general errors


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
        print(f"The provided directory {directory} does not exist.")
        sys.exit(1)

    create_backup = questionary.confirm("Do you want to create a backup?").ask()
    old_text = questionary.text("Enter the text to replace:").ask()
    new_text = questionary.text("Enter the new text:").ask()

    if create_backup:
        zip_folder(directory)

    # Replace text
    replace_text(directory, old_text, new_text)
    print(f"\033[92mReplacement Complete in\033[0m \033[91m{directory}\033[0m")