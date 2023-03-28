import os


def delete_file(file_path):
    try:
        os.remove(file_path)
        # print(f"Deleted {file_path}")
    except FileNotFoundError:
        print(f"File not found: {file_path}")
    except OSError as e:
        print(f"Error deleting {file_path}: {e}")


if __name__ == "__main__":
    file_path = "/Users/rob/.cache/lvim/lvim.shada"
    delete_file(file_path)
