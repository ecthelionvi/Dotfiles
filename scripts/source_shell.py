import os
import subprocess

def clear_screen():
    print("\033[2J\033[H", end="")

# Source .zshrc
os.system("source ~/.zshrc")

# Execute zsh
subprocess.run(["zsh"])

# Clear screen
clear_screen()
