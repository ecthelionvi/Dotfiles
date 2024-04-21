import questionary
import subprocess
import sys


def clear_screen():
    print("\033[2J\033[H", end="")


def create_project():
    try:
        choice = questionary.select(
            "Select the technology you want to use:",
            choices=[
                "Vite",
                "Next",
                "Angular",
            ],
        ).ask()

        if choice is None:
            raise KeyboardInterrupt

        project_name = questionary.text("Enter your project name:").ask()
        if project_name is None:
            raise KeyboardInterrupt

        if choice == "Vite":
            command = f"npm create vite@latest {project_name.lower()}"
        elif choice == "Next.js":
            command = f"npx create-next-app@latest {project_name.lower()} --use-vite"
        elif choice == "Angular":
            command = f"npx @angular/cli new {project_name.lower()}"
        else:
            sys.exit(1)

        subprocess.run(command, check=True, shell=True)

    except KeyboardInterrupt:
        clear_screen()
    except subprocess.CalledProcessError as e:
        print(f"An error occurred while creating the project: {e}")
        sys.exit(1)


if __name__ == "__main__":
    create_project()
