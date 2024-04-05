import subprocess
import os


def run_live_server_in_iterm():
    current_directory = os.getcwd()  # Gets the current working directory
    apple_script = f"""
    tell application "iTerm"
        tell current window
            create tab with default profile
            tell current session
                write text "cd {current_directory} && live-server"
            end tell
        end tell
    end tell
    """
    subprocess.run(["osascript", "-e", apple_script], check=True)


if __name__ == "__main__":
    run_live_server_in_iterm()
