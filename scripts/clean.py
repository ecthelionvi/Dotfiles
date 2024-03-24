import os


def delete_file(file_path):
    try:
        os.remove(file_path)
        print(f"Deleted {file_path}")
    except FileNotFoundError:
        print(f"File not found: {file_path}")
    except OSError as e:
        print(f"Error deleting {file_path}: {e}")
if __name__ == "__main__":
    files = ["/Users/rob/.cache/lvim/lvim.shada", "/Users/rob/.cache/lvim/project_nvim/project_history"]
    for file_path in files:
        delete_file(file_path)
