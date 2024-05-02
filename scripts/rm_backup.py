import os
import sys
import sqlite3
from datetime import datetime
import questionary
import hashlib
import zipfile
import tempfile

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
        file_hash TEXT,
        file_data BLOB,
        timestamp TEXT,
        undone INTEGER DEFAULT 0,
        is_directory INTEGER DEFAULT 0
    )
"""
)
conn.commit()


# Function to generate the hash of a file
def generate_file_hash(file_path):
    sha256_hash = hashlib.sha256()
    with open(file_path, "rb") as file:
        for chunk in iter(lambda: file.read(4096), b""):
            sha256_hash.update(chunk)
    return sha256_hash.hexdigest()


# Function to create a backup of the file or directory
def create_backup(path):
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    absolute_path = os.path.abspath(path)

    if os.path.isfile(absolute_path):
        file_hash = generate_file_hash(absolute_path)
        cursor.execute("SELECT id FROM backups WHERE file_hash = ?", (file_hash,))
        result = cursor.fetchone()

        if result:
            backup_id = result[0]
            cursor.execute(
                "UPDATE backups SET timestamp = ? WHERE id = ?", (timestamp, backup_id)
            )
            conn.commit()
            print(f"Updated backup timestamp for: {absolute_path}")
            return

        with open(absolute_path, "rb") as file:
            file_data = file.read()
        cursor.execute(
            "INSERT INTO backups (original_path, file_hash, file_data, timestamp) VALUES (?, ?, ?, ?)",
            (absolute_path, file_hash, file_data, timestamp),
        )
        conn.commit()
    elif os.path.isdir(absolute_path):
        temp_dir = tempfile.mkdtemp()
        zip_path = os.path.join(temp_dir, f"{os.path.basename(absolute_path)}.zip")
        with zipfile.ZipFile(zip_path, "w") as zip_file:
            for root, dirs, files in os.walk(absolute_path):
                for file in files:
                    file_path = os.path.join(root, file)
                    zip_file.write(file_path, os.path.relpath(file_path, absolute_path))

        with open(zip_path, "rb") as file:
            file_data = file.read()
        cursor.execute(
            "INSERT INTO backups (original_path, file_data, timestamp, is_directory) VALUES (?, ?, ?, ?)",
            (absolute_path, file_data, timestamp, 1),
        )
        conn.commit()

        os.remove(zip_path)
        os.rmdir(temp_dir)

    print(f"Backup created for: {absolute_path}")


# Function to undo the last removal and restore the file or directory
def undo_last_removal():
    cursor.execute(
        "SELECT id, original_path, file_data, is_directory FROM backups WHERE undone = 0 ORDER BY id DESC LIMIT 1"
    )
    result = cursor.fetchone()

    if result:
        backup_id, original_path, file_data, is_directory = result
        directory = os.path.dirname(original_path)

        # Create the directory if it doesn't exist
        os.makedirs(directory, exist_ok=True)

        if is_directory:
            temp_dir = tempfile.mkdtemp()
            zip_path = os.path.join(temp_dir, f"{os.path.basename(original_path)}.zip")
            with open(zip_path, "wb") as file:
                file.write(file_data)

            with zipfile.ZipFile(zip_path, "r") as zip_file:
                zip_file.extractall(original_path)

            os.remove(zip_path)
            os.rmdir(temp_dir)
        else:
            with open(original_path, "wb") as file:
                file.write(file_data)

        cursor.execute("UPDATE backups SET undone = 1 WHERE id = ?", (backup_id,))
        conn.commit()

        print(f"Restored: {original_path}")
    else:
        print("No backup found to undo.")


# Function to redo the last undone removal
def redo_last_removal():
    cursor.execute(
        "SELECT id, original_path, is_directory FROM backups WHERE undone = 1 ORDER BY id DESC LIMIT 1"
    )
    result = cursor.fetchone()

    if result:
        backup_id, original_path, is_directory = result

        if is_directory:
            shutil.rmtree(original_path)
        elif os.path.isfile(original_path):
            os.remove(original_path)

        cursor.execute("UPDATE backups SET undone = 0 WHERE id = ?", (backup_id,))
        conn.commit()

        print(f"Removed: {original_path}")
    else:
        print("No undone backup found to redo.")


# Function to restore a specific file or directory
def restore_file():
    cursor.execute(
        "SELECT id, original_path, timestamp, is_directory FROM backups ORDER BY timestamp DESC"
    )
    results = cursor.fetchall()

    if results:
        choices = [
            f"{os.path.basename(original_path)} (Removed: {datetime.strptime(timestamp, '%Y%m%d_%H%M%S').strftime('%Y-%m-%d %H:%M:%S')})"
            for _, original_path, timestamp, _ in results
        ]
        selected = questionary.select(
            "Select a file or directory to restore:", choices=choices
        ).ask()

        if selected:
            backup_id = results[choices.index(selected)][0]
            cursor.execute(
                "SELECT original_path, file_data, is_directory FROM backups WHERE id = ?",
                (backup_id,),
            )
            result = cursor.fetchone()

            if result:
                original_path, file_data, is_directory = result
                directory = os.path.dirname(original_path)

                if directory:
                    # Create the directory if it doesn't exist
                    os.makedirs(directory, exist_ok=True)

                    if is_directory:
                        temp_dir = tempfile.mkdtemp()
                        zip_path = os.path.join(
                            temp_dir, f"{os.path.basename(original_path)}.zip"
                        )
                        with open(zip_path, "wb") as file:
                            file.write(file_data)

                        with zipfile.ZipFile(zip_path, "r") as zip_file:
                            zip_file.extractall(original_path)

                        os.remove(zip_path)
                        os.rmdir(temp_dir)
                    else:
                        with open(original_path, "wb") as file:
                            file.write(file_data)

                    cursor.execute(
                        "UPDATE backups SET undone = 1 WHERE id = ?", (backup_id,)
                    )
                    conn.commit()

                    print(f"Restored: {os.path.basename(original_path)}")
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
    print(
        "Usage: python rm_backup.py <file_or_directory> [--undo] [--redo] [--restore]"
    )
    sys.exit(1)

# Check if the undo, redo, or restore flag is provided
if "--undo" in sys.argv:
    undo_last_removal()
elif "--redo" in sys.argv:
    redo_last_removal()
elif "--restore" in sys.argv:
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
    print(f"Removed: {path}")

# Close the database connection
conn.close()
