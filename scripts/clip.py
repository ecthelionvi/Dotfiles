import subprocess
import sys


def copy_to_clipboard(file_path):
    try:
        with open(file_path, "rb") as file:
            # Use subprocess to send file content to pbcopy
            process = subprocess.Popen("pbcopy", stdin=subprocess.PIPE)
            process.communicate(file.read())

        # Print success message in green
        print("\033[92mCopied to Clipboard\033[0m")  # ANSI escape code for green text
    except FileNotFoundError:
        print(f"Error: The file {file_path} does not exist.")
    except Exception as e:
        print(f"An error occurred: {e}")


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python clip.py <file_path>")
    else:
        copy_to_clipboard(sys.argv[1])
