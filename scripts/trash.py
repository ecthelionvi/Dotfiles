import os


def empty_trash():
    confirmation = input("Are you sure you want to empty the trash? (Y/N): ")
    if confirmation.upper() == "Y":
        os.system("rm -rf ~/.Trash/*")


if __name__ == "__main__":
    empty_trash()
