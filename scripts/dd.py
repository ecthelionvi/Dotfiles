import os
import sys
import subprocess

DEBUG = False


def find_best_match(directory, target):
    python_script = os.path.expanduser("~/Documents/Dotfiles/scripts/fuzzy.py")
    closest_match = subprocess.run(
        ["python3", python_script, directory, target], capture_output=True, text=True
    ).stdout.strip()
    return os.path.join(directory, closest_match)


def find_best_match_dirs(target):
    python_script_dirs = os.path.expanduser(
        "~/Documents/Dotfiles/scripts/fuzzy_dirs.py"
    )
    closest_match_dirs = subprocess.run(
        ["python3", python_script_dirs, target], capture_output=True, text=True
    ).stdout.strip()
    return closest_match_dirs


def dd(target_path):
    initial_dir = os.getcwd()
    named_dirs_file = os.path.expanduser("~/.named_dirs")

    if DEBUG:
        print(f"[DEBUG] Initial directory: {initial_dir}", file=sys.stderr)
        print(f"[DEBUG] Target path: {target_path}", file=sys.stderr)

    if target_path == ".":
        subprocess.run(
            ["cd", "-"], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL
        )
        print(os.getcwd())
        return

    # Handle dots functionality
    if target_path.startswith(".."):
        dot_count = len(target_path)
        up_levels = dot_count - 1
        up_dir = "../" * up_levels
        try:
            os.chdir(up_dir)
            print(os.getcwd())
            return
        except FileNotFoundError:
            print(f"Invalid path: {up_dir}", file=sys.stderr)
            return

    # Load named directories into a dictionary
    named_dirs = {}
    if os.path.isfile(named_dirs_file):
        with open(named_dirs_file, "r") as file:
            for line in file:
                line = line.strip()
                if ":" in line:
                    named_dir, named_dir_path = line.split(":", 1)
                    named_dir = named_dir.strip('"').strip("'")
                    named_dir_path = os.path.expanduser(named_dir_path.strip())
                    named_dirs[named_dir.lower()] = named_dir_path

    path_components = target_path.split("/")
    current_dir = initial_dir

    for component in path_components:
        if not component:
            continue

        if DEBUG:
            print(f"[DEBUG] Searching for component: {component}", file=sys.stderr)

        # Check if the component matches a named directory
        if component.lower() in named_dirs:
            named_dir_path = named_dirs[component.lower()]
            if os.path.isdir(named_dir_path):

                if DEBUG:
                    print(
                        f"[DEBUG] Navigating to named directory: {named_dir_path}",
                        file=sys.stderr,
                    )

                current_dir = named_dir_path
                os.chdir(
                    current_dir
                )  # Change the current directory to the named directory

                if DEBUG:
                    print(
                        f"[DEBUG] Current directory changed to: {current_dir}",
                        file=sys.stderr,
                    )

                continue

        # If not a named directory, perform fuzzy matching
        best_match = find_best_match(current_dir, component)
        if best_match and os.path.isdir(best_match):

            if DEBUG:
                print(f"[DEBUG] Best match found: {best_match}", file=sys.stderr)

            current_dir = best_match
            os.chdir(
                current_dir
            )  # Change the current directory to the matched directory

            if DEBUG:
                print(
                    f"[DEBUG] Current directory changed to: {current_dir}",
                    file=sys.stderr,
                )
        else:
            print(f"No matching directory found for: {component}", file=sys.stderr)
            return

    print(current_dir)


if __name__ == "__main__":
    if len(sys.argv) > 1:
        target_path = sys.argv[1]
        dd(target_path)
    else:
        print("Please provide a target path as an argument.")
