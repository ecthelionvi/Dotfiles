import os
import sys
import sqlite3
from datetime import datetime
import questionary
import hashlib
import zipfile
import tempfile
import shutil

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
        original_path TEXT,
        zip_hash TEXT,
        zip_data BLOB,
        timestamp TEXT
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


# Function to create a backup of the file or directory
def create_backup(path):
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    absolute_path = os.path.abspath(path)

    temp_dir = tempfile.mkdtemp()
    zip_path = os.path.join(temp_dir, f"{os.path.basename(absolute_path)}.zip")

    with zipfile.ZipFile(zip_path, "w") as zip_file:
        if os.path.isfile(absolute_path):
            zip_file.write(absolute_path, os.path.basename(absolute_path))
        elif os.path.isdir(absolute_path):
            for root, dirs, files in os.walk(absolute_path):
                for file in files:
                    file_path = os.path.join(root, file)
                    zip_file.write(file_path, os.path.relpath(file_path, absolute_path))

    zip_hash = generate_zip_hash(zip_path)
    cursor.execute("SELECT id FROM backups WHERE zip_hash = ?", (zip_hash,))
    result = cursor.fetchone()

    if result:
        backup_id = result[0]
        cursor.execute(
            "UPDATE backups SET timestamp = ? WHERE id = ?", (timestamp, backup_id)
        )
        conn.commit()
        # print(f"Updated backup timestamp for: {absolute_path}")
    else:
        with open(zip_path, "rb") as file:
            zip_data = file.read()
        cursor.execute(
            "INSERT INTO backups (original_path, zip_hash, zip_data, timestamp) VALUES (?, ?, ?, ?)",
            (absolute_path, zip_hash, zip_data, timestamp),
        )
        conn.commit()
        # print(f"Backup created for: {absolute_path}")

    os.remove(zip_path)
    os.rmdir(temp_dir)


# Function to restore a specific file or directory
def restore_file():
    cursor.execute(
        "SELECT id, original_path, timestamp FROM backups ORDER BY timestamp DESC"
    )
    results = cursor.fetchall()

    if results:
        choices = []
        for _, original_path, timestamp in results:
            if os.path.basename(original_path).endswith(".zip"):
                choice = f"{os.path.basename(original_path)[:-4]}/ (Removed: {datetime.strptime(timestamp, '%Y%m%d_%H%M%S').strftime('%Y-%m-%d %H:%M:%S')})"
            else:
                choice = f"{os.path.basename(original_path)} (Removed: {datetime.strptime(timestamp, '%Y%m%d_%H%M%S').strftime('%Y-%m-%d %H:%M:%S')})"
            choices.append(choice)

        selected = questionary.select(
            "Select a file or directory to restore:", choices=choices
        ).ask()

        if selected:
            backup_id = results[choices.index(selected)][0]
            cursor.execute(
                "SELECT original_path, zip_data FROM backups WHERE id = ?", (backup_id,)
            )
            result = cursor.fetchone()

            if result:
                original_path, zip_data = result
                directory = os.path.dirname(original_path)

                if directory:
                    temp_dir = tempfile.mkdtemp()
                    zip_path = os.path.join(
                        temp_dir, f"{os.path.basename(original_path)}.zip"
                    )
                    with open(zip_path, "wb") as file:
                        file.write(zip_data)

                    if os.path.exists(original_path):
                        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
                        cursor.execute(
                            "UPDATE backups SET timestamp = ? WHERE id = ?",
                            (timestamp, backup_id),
                        )
                        conn.commit()
                        # print(
                        #     f"File or directory already exists. Updated backup timestamp for: {os.path.basename(original_path)}"
                        # )
                    else:
                        # Create the directory if it doesn't exist
                        os.makedirs(original_path, exist_ok=True)

                        with zipfile.ZipFile(zip_path, "r") as zip_file:
                            for member in zip_file.namelist():
                                if member.endswith("/"):
                                    os.makedirs(
                                        os.path.join(original_path, member),
                                        exist_ok=True,
                                    )
                                else:
                                    zip_file.extract(member, original_path)
                        print(f"Restored {os.path.basename(original_path)}")

                    os.remove(zip_path)
                    os.rmdir(temp_dir)
                else:
                    print("Invalid original path. Unable to restore.")
            else:
                print("Backup not found for the selected file or directory.")
        else:
            print("No file or directory selected for restoration.")
    else:
        print("No backups found to restore.")


# Check if the script is being run with the correct arguments
if len(sys.argv) < 2:
    print("Usage: python rm_backup.py <file_or_directory> [--restore]")
    sys.exit(1)

# Check if the restore flag is provided
if "--restore" in sys.argv:
    restore_file()
else:
    # Get the file or directory path from the command line argument
    path = sys.argv[1]

    # Create a backup of the file or directory
    create_backup(path)

    # Remove the file or directory
    if os.path.isfile(path):
        os.remove(path)
    elif os.path.isdir(path):
        shutil.rmtree(path)
    print(f"Removed {path}")

# Close the database connection
conn.close()
