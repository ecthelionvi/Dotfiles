import os
import shutil
import tempfile

# Define your directories
ssh_folder_documents = "/Users/rob/Documents/ssh"
home_ssh_folder = "/Users/rob/.ssh"
home_directory = "/Users/rob"

# Files to be swapped
files_to_swap = [".gitconfig", "id_ed25519", "id_ed25519.pub"]


def swap_files(documents_folder, home_folder, home_ssh_folder, file_list):
    # Create a temporary directory
    with tempfile.TemporaryDirectory() as tmp_folder:
        # print(f"Created temporary directory: {tmp_folder}")

        # Step 1: Temporarily hold the files from the home directory in the temp folder
        for file_name in file_list:
            if file_name == ".gitconfig":
                home_file = os.path.join(home_folder, file_name)
            else:
                home_file = os.path.join(home_ssh_folder, file_name)

            tmp_file_location = os.path.join(tmp_folder, file_name)

            if os.path.exists(home_file):
                shutil.move(home_file, tmp_file_location)
                # print(f"Moved {home_file} to {tmp_file_location}")

        # Step 2: Move the corresponding files from Documents/ssh to the home directory
        for file_name in file_list:
            doc_file = os.path.join(documents_folder, file_name)
            if file_name == ".gitconfig":
                home_file = os.path.join(home_folder, file_name)
            else:
                home_file = os.path.join(home_ssh_folder, file_name)

            if os.path.exists(doc_file):
                shutil.move(doc_file, home_file)
                # print(f"Moved {doc_file} to {home_file}")
            else:
                print(
                    f"Warning: {doc_file} does not exist. {file_name} has not been copied to the home directory."
                )

        # Step 3: Move the temporarily held files from the temp folder to Documents/ssh
        for file_name in file_list:
            tmp_file_location = os.path.join(tmp_folder, file_name)
            if os.path.exists(tmp_file_location):
                shutil.move(tmp_file_location, documents_folder)
                # print(f"Moved {tmp_file_location} to {documents_folder}")

        print(f"Swap completed, temporary directory cleaned up.")


# Execute the swap operation
swap_files(ssh_folder_documents, home_directory, home_ssh_folder, files_to_swap)
