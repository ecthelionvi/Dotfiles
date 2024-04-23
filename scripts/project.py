import subprocess
import sys
import questionary


def clear_screen():
    print("\033[2J\033[H", end="")


def create_project():
    try:
        choice = questionary.select(
            "Select the technology you want to use:",
            choices=[
                "React",
                "Next",
                "Angular",
            ],
        ).ask()

        if choice is None:
            raise KeyboardInterrupt

        project_name = questionary.text("Enter your project name:").ask()
        if project_name is None:
            raise KeyboardInterrupt

        # Only lowercase the first character and keep the rest as is
        formatted_project_name = project_name[0].lower() + project_name[1:]

        if choice == "React":
            command = f"npx create-react-app {formatted_project_name}"
        elif choice == "Next":
            command = f"npx create-next-app {formatted_project_name}"
        elif choice == "Angular":
            command = f"npx @angular/cli new {formatted_project_name}"
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
