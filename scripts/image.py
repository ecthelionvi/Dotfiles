import os
from PIL import Image


def convert_webp_to_png():
    # List all files in the current directory
    files = os.listdir(".")

    # Filter for webp files
    webp_files = [f for f in files if f.endswith(".webp")]

    # Convert each webp file to png and remove the original file
    for file in webp_files:
        image = Image.open(file)
        # Define the new filename
        png_file = file[:-5] + ".png"
        # Save the image in PNG format
        image.save(png_file, "PNG")
        # Remove the original webp file
        os.remove(file)
        print(f"Converted and removed {file}, new file is {png_file}")


# Run the conversion function
if __name__ == "__main__":
    convert_webp_to_png()
