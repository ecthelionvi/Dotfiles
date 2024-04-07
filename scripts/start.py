import json
import subprocess
import os
from pathlib import Path


def find_file_in_tree(start_path, filename):
    """Searches for the nearest file moving up the directory tree."""
    current_path = Path(start_path).resolve()
    for parent in [current_path] + list(current_path.parents):
        potential_path = parent / filename
        if potential_path.is_file():
            return parent
    return None


def run_command_in_directory(command, directory):
    """Runs the specified command in the given directory."""
    apple_script = f"""
    tell application "iTerm"
        tell current window
            create tab with default profile
            tell the current session
                write text "clear"
                write text "cd '{directory}' && {command}"
            end tell
        end tell
    end tell
    """
    subprocess.run(["osascript", "-e", apple_script], check=True)


def main():
    project_directory = find_file_in_tree(os.getcwd(), "package.json")
    index_html_directory = find_file_in_tree(os.getcwd(), "index.html")

    command = None
    if project_directory:
        try:
            # Load package.json to determine available scripts
            package_json_path = project_directory / "package.json"
            with open(package_json_path, "r") as file:
                package_json = json.load(file)
                scripts = package_json.get("scripts", {})
                if "dev" in scripts:
                    command = "npm run dev"
                elif "start" in scripts:
                    command = "npm start"
        except Exception:
            pass  # Ignore errors and attempt to fall back to live-server

    # Fallback to live-server if command isn't set and index.html is found
    if command is None and index_html_directory is not None:
        command = "live-server"
        project_directory = (
            index_html_directory  # Use the directory where index.html was found
        )

    if command:
        run_command_in_directory(command, project_directory)
    else:
        print("Unable to start project: No valid 'package.json' or 'index.html' found.")


if __name__ == "__main__":
    main()
