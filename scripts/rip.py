import os
import sys

# List of directories and files to ignore
IGNORE_DIRS = {".git", "node_modules", "venv", ".idea", ".vscode"}
IGNORE_FILES = {".DS_Store", "Dockerfile"}
IGNORE_EXTENSIONS = {".yaml", ".yml"}


def copy_repo_contents_to_file(repo_path, output_file):
    with open(output_file, "w") as out_file:
        for root, dirs, files in os.walk(repo_path):
            # Ignore specified directories
            dirs[:] = [d for d in dirs if d not in IGNORE_DIRS]

            for file in files:
                # Ignore specified files and extensions
                if file in IGNORE_FILES or any(
                    file.endswith(ext) for ext in IGNORE_EXTENSIONS
                ):
                    continue

                file_path = os.path.join(root, file)
                with open(file_path, "r", errors="ignore") as f:
                    out_file.write(f"\n---\n")
                    out_file.write(f"File: {file_path}\n")
                    out_file.write(f.read())
                    out_file.write("\n")


def main():
    if len(sys.argv) != 2:
        print("Usage: python script.py <repo_path>")
        sys.exit(1)

    repo_path = sys.argv[1]
    output_file = "repo.txt"

    if not os.path.isdir(repo_path):
        print(f"Error: {repo_path} is not a valid directory.")
        sys.exit(1)

    copy_repo_contents_to_file(repo_path, output_file)
    print(f"Contents copied to {output_file}")


if __name__ == "__main__":
    main()
