import os
import subprocess

def clear_screen():
    print("\033[2J\033[H", end="")

# Source .zshrc
os.system("source ~/.zshrc")

# Clear screen
clear_screen()
