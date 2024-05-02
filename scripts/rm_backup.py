import os
import sys
import sqlite3
from datetime import datetime
import questionary
import hashlib
import zipfile
import tempfile
import shutil


BLUE_TEXT = "\033[34m"
RESET_TEXT = "\033[0m"
RED_TEXT = "\033[91m"

# Set up the SQLite database connection
db_path = os.path.expanduser("~/.cache/rm_backup/rm_backup.db")
os.makedirs(os.path.dirname(db_path), exist_ok=True)
conn = sqlite3.connect(db_path)
cursor = conn.cursor()

# Create the backup table if it doesn't exist
cursor.execute(
    """
    CREATE TABLE IF NOT EXISTS backups (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        full_path TEXT,
        name TEXT,
        zip_hash TEXT,
        zip_data BLOB,
        timestamp TEXT,
        is_directory INTEGER
    )
"""
)
conn.commit()


# Function to generate the hash of a zip file
def generate_zip_hash(zip_path):
    sha256_hash = hashlib.sha256()
    with zipfile.ZipFile(zip_path, "r") as zip_file:
        # Sort the file names in the zip archive
        sorted_file_names = sorted(zip_file.namelist())

        for file_name in sorted_file_names:
            with zip_file.open(file_name, "r") as file:
                while True:
                    chunk = file.read(4096)
                    if not chunk:
                        break
                    sha256_hash.update(chunk)

    return sha256_hash.hexdigest()


def create_backup(path):
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    absolute_path = os.path.abspath(path)
    name = os.path.basename(absolute_path)
    parent_dir = os.path.dirname(absolute_path)  # Store only the parent directory path
    is_directory = os.path.isdir(absolute_path)

    zip_path = os.path.join(parent_dir, f"{name}.zip")

    with zipfile.ZipFile(zip_path, "w") as zip_file:
        if os.path.isfile(absolute_path):
            zip_file.write(absolute_path, name)
        elif os.path.isdir(absolute_path):
            for root, dirs, files in os.walk(absolute_path):
                for dir in dirs:
                    dir_path = os.path.join(root, dir)
                    zip_file.write(
                        dir_path, os.path.relpath(dir_path, start=parent_dir)
                    )
                for file in files:
                    file_path = os.path.join(root, file)
                    zip_file.write(
                        file_path, os.path.relpath(file_path, start=parent_dir)
                    )

    zip_hash = generate_zip_hash(zip_path)
    with open(zip_path, "rb") as file:
        zip_data = file.read()

    cursor.execute(
        "INSERT INTO backups (full_path, name, zip_hash, zip_data, timestamp, is_directory) VALUES (?, ?, ?, ?, ?, ?)",
        (parent_dir, name, zip_hash, zip_data, timestamp, 1 if is_directory else 0),
    )
    conn.commit()
    print("Zip path: ", zip_path)
    os.remove(zip_path)


def format_choices(results):
    choices = []
    for _, name, timestamp, is_dir in results:
        date_str = datetime.strptime(timestamp, "%Y%m%d_%H%M%S").strftime(
            "%Y-%m-%d %H:%M:%S"
        )
        if is_dir:
            choice = f"{name}/ (Removed: {date_str})"
        else:
            choice = f"{name} (Removed: {date_str})"
        choices.append(choice)
    return choices


def process_restoration(backup_id):
    cursor.execute(
        "SELECT full_path, name, zip_data, is_directory FROM backups WHERE id = ?",
        (backup_id,),
    )
    result = cursor.fetchone()

    if not result:
        print("Backup not found for the selected file or directory.")
        return

    full_path, name, zip_data, is_directory = result
    perform_file_extraction(full_path, name, zip_data, is_directory)


def perform_file_extraction(full_path, name, zip_data, is_directory):
    target_path = os.path.join(full_path, name)
    zip_path = os.path.join(full_path, f"{name}.zip")
    print("Target path: ", target_path)
    print("Zip path: ", zip_path)

    try:
        with open(zip_path, "wb") as file:
            file.write(zip_data)

        with zipfile.ZipFile(zip_path, "r") as zip_file:
            if is_directory:
                if os.path.exists(target_path):
                    shutil.rmtree(target_path)
                zip_file.extractall(full_path)
            else:
                if os.path.exists(target_path):
                    os.remove(target_path)
                zip_file.extract(name, full_path)

        print_restore_message(full_path, name, is_directory)

    finally:
        os.remove(zip_path)


def print_restore_message(full_path, name, is_directory):
    if is_directory:
        print(f"Restored {RED_TEXT}{name}/{RESET_TEXT} to {full_path}")
    else:
        print(f"Restored {BLUE_TEXT}{name}{RESET_TEXT} to {full_path}")


def restore_file():
    cursor.execute(
        "SELECT id, name, timestamp, is_directory FROM backups ORDER BY timestamp DESC"
    )
    results = cursor.fetchall()

    if not results:
        print("No backups found to restore.")
        return

    choices = format_choices(results)
    selected = questionary.select(
        "Select a file or directory to restore:", choices=choices
    ).ask()
    if not selected:
        print("No file or directory selected for restoration.")
        return

    backup_id = results[choices.index(selected)][0]
    process_restoration(backup_id)


# Check if the script is being run with the correct arguments
if len(sys.argv) < 2:
    print(
        "Usage: python rm_backup.py <file_or_directory> [<file_or_directory> ...] [--restore]"
    )
    sys.exit(1)

# Check if the restore flag is provided
if "--restore" in sys.argv:
    restore_file()
else:
    # Get the file or directory paths from the command line arguments
    paths = sys.argv[1:]
    paths = [path for path in paths if path != "--restore"]

    for path in paths:
        # Create a backup of the file or directory
        create_backup(path)

        # Remove the file or directory
        if os.path.isfile(path):
            os.remove(path)
            print(f"Removed {BLUE_TEXT}{path}{RESET_TEXT}")
        elif os.path.isdir(path):
            shutil.rmtree(path)
            print(f"Removed {RED_TEXT}{path}/{RESET_TEXT}")

# Close the database connection
conn.close()
