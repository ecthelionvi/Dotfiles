import os
import sys
import subprocess


def dd(target_path):
    initial_dir = os.getcwd()
    python_script = os.path.expanduser("~/Documents/Dotfiles/scripts/fuzzy.py")
    python_script_dirs = os.path.expanduser(
        "~/Documents/Dotfiles/scripts/fuzzy_dirs.py"
    )
    named_dirs_file = os.path.expanduser("~/.named_dirs")

    if target_path == ".":
        subprocess.run(
            ["cd", "-"], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL
        )
        return

    # Suppressing output for named directory navigation
    if os.path.isfile(named_dirs_file):
        with open(named_dirs_file, "r") as file:
            for line in file:
                if line.startswith(f'"{target_path}":'):
                    named_dir_path = line.split(":")[1].strip()
                    if named_dir_path:
                        try:
                            os.chdir(named_dir_path)
                            print(os.getcwd())
                            return
                        except FileNotFoundError:
                            return

    # Fuzzy matching for named directories
    closest_match_dirs = subprocess.run(
        ["python3", python_script_dirs, target_path], capture_output=True, text=True
    ).stdout.strip()
    if closest_match_dirs:
        try:
            os.chdir(closest_match_dirs)
            print(os.getcwd())
            return
        except FileNotFoundError:
            print(f"Failed to navigate to: {closest_match_dirs}")
            return

    if target_path.startswith(".."):
        dot_count = len(target_path)
        up_levels = dot_count - 1
        up_dir = "../" * up_levels
        try:
            os.chdir(up_dir)
            print(os.getcwd())
            return
        except FileNotFoundError:
            return

    def change_dir_or_fuzzy_match(component):
        try:
            os.chdir(component)
            return True
        except FileNotFoundError:
            closest_match = subprocess.run(
                ["python3", python_script, os.getcwd(), component],
                capture_output=True,
                text=True,
            ).stdout.strip()
            if closest_match:
                try:
                    os.chdir(closest_match)
                    return True
                except FileNotFoundError:
                    print(f"Failed to navigate further from {os.getcwd()}")
                    os.chdir(initial_dir)
                    return False
            else:
                print(f"No matching directory found for: {component}")
                os.chdir(initial_dir)
                return False

    path_components = target_path.split("/")
    for component in path_components:
        if not component:
            continue
        if not change_dir_or_fuzzy_match(component):
            return

    print(os.getcwd())


if __name__ == "__main__":
    if len(sys.argv) > 1:
        target_path = sys.argv[1]
        dd(target_path)
    else:
        print("Please provide a target path as an argument.")
