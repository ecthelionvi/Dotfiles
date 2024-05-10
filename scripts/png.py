import os
import sys
import time
from PIL import Image

RESET_TEXT = "\033[0m"
YELLOW_TEXT = "\033[93m"


def convert_to_png(file_path):
    try:
        if not os.path.exists(file_path):
            return False
        image = Image.open(file_path)
        png_file = os.path.splitext(file_path)[0] + ".png"
        image.save(png_file, "PNG")
        os.remove(file_path)
        return True
    except Exception as e:
        print(f"Error converting {file_path}: {e}")
        return False


def convert_all_to_png():
    try:
        current_dir = os.getcwd()
        files = os.listdir(current_dir)
        image_extensions = [".jpg", ".jpeg", ".png", ".bmp", ".gif", ".webp"]
        image_files = [
            f for f in files if os.path.splitext(f)[1].lower() in image_extensions
        ]
        converted_files = []
        invalid_files = []
        for file in image_files:
            file_path = os.path.join(current_dir, file)
            if convert_to_png(file_path):
                converted_files.append(f"{YELLOW_TEXT}{file}{RESET_TEXT}")
            else:
                invalid_files.append(file)
        print_conversion_message(converted_files, invalid_files)
    except Exception as e:
        print(f"An error occurred: {e}")


def print_conversion_message(converted_files, invalid_files):
    if invalid_files:
        invalid_files_str = " ".join(invalid_files)
        print(f"{invalid_files_str} not converted")
    if converted_files:
        print(f"Converted: {' '.join(converted_files)} to PNG")
    elif not invalid_files:
        print("No image files found")


def print_usage():
    usage = "Usage: python script.py [<file_path> ...] [--all]"
    print(usage)


if __name__ == "__main__":
    start_time = time.time()
    if len(sys.argv) == 1:
        convert_all_to_png()
    elif len(sys.argv) == 2 and sys.argv[1] == "--all":
        convert_all_to_png()
    elif len(sys.argv) >= 2:
        converted_files = []
        invalid_files = []
        for file_path in sys.argv[1:]:
            if file_path == "--all":
                print_usage()
                sys.exit(1)
            if convert_to_png(file_path):
                converted_files.append(f"{YELLOW_TEXT}{file_path}{RESET_TEXT}")
            else:
                invalid_files.append(file_path)
        print_conversion_message(converted_files, invalid_files)
    else:
        print_usage()
    end_time = time.time()
    execution_time = end_time - start_time
    print(f"\nExecution time: {execution_time:.2f} seconds")
