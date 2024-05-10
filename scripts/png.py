import os
import sys
from PIL import Image
from halo import Halo
from concurrent.futures import ThreadPoolExecutor

RESET_TEXT = "\033[0m"
YELLOW_TEXT = "\033[93m"


def convert_to_png(file_path):
    try:
        if not os.path.exists(file_path):
            return None
        image = Image.open(file_path)
        filename = os.path.basename(file_path)  # Extract the filename
        png_file = os.path.splitext(filename)[0] + ".png"
        image.save(png_file, "PNG")
        os.remove(file_path)
        return f"{YELLOW_TEXT}{filename}{RESET_TEXT}"  # Return the filename only
    except Exception as e:
        print(f"Error converting {filename}: {e}")
        return None


def convert_files(files):
    with ThreadPoolExecutor() as executor:
        results = list(executor.map(convert_to_png, files))
    converted_files = [file for file in results if file is not None]
    if converted_files:
        spinner.stop()
        print(f"Converted: {' '.join(converted_files)} to PNG")
    else:
        print("No image files found or converted.")


def convert_all_to_png():
    current_dir = os.getcwd()
    files = os.listdir(current_dir)
    image_extensions = [".jpg", ".jpeg", ".png", ".bmp", ".gif", ".webp"]
    image_files = [
        os.path.join(current_dir, f)
        for f in files
        if os.path.splitext(f)[1].lower() in image_extensions
    ]
    convert_files(image_files)


def print_usage():
    usage = "Usage: python script.py [<file_path> ...] [--all]"
    print(usage)


if __name__ == "__main__":
    if len(sys.argv) == 1 or (len(sys.argv) == 2 and sys.argv[1] == "--all"):
        spinner = Halo(text="Converting", spinner="dots")
        spinner.start()
        convert_all_to_png()
    elif len(sys.argv) > 1:
        file_paths = [
            os.path.join(os.getcwd(), f) for f in sys.argv[1:] if not f.startswith("--")
        ]
        if file_paths:
            spinner = Halo(text="Converting", spinner="dots")
            spinner.start()
            convert_files(file_paths)
        else:
            print_usage()
    else:
        print_usage()
