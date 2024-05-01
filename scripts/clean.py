import os

BLUE_TEXT = "\033[34m"
RESET_TEXT = "\033[0m"
GREEN_TEXT = "\033[32m"
PURPLE_TEXT = "\033[35m"


def draw_boxed_message(lines, show_success=False, success_text="Success"):
    terminal_width = os.get_terminal_size().columns
    width = terminal_width - 4
    print("┌" + "─" * (width + 2) + "┐")
    for line in lines:
        visible_line = line.replace(GREEN_TEXT, "").replace(RESET_TEXT, "")
        padding = (width - len(visible_line)) // 2
        print(
            "│ "
            + " " * padding
            + line
            + " " * (width - len(visible_line) - padding)
            + " │"
        )
    if show_success:
        visible_footer_length = len(success_text) + 2
        dashes_needed = width - visible_footer_length + 1
        success_text_colored = f"{GREEN_TEXT}{success_text}{RESET_TEXT}"
        print("└" + "─" * dashes_needed + " " + success_text_colored + " ─┘")
    else:
        print("└" + "─" * (width + 2) + "┘")


def clear_screen():
    print("\033[2J\033[H", end="")


def delete_files(file_paths):
    deleted_files = []
    for file_path in file_paths:
        try:
            os.remove(file_path)
            deleted_files.append(os.path.basename(file_path))
        except FileNotFoundError:
            pass
        except OSError as e:
            print(f"Error deleting {file_path}: {e}")
    return deleted_files


if __name__ == "__main__":
    files = [
        "/Users/rob/.cache/lvim/lvim.shada",
        "/Users/rob/.cache/lvim/project_nvim/project_history",
    ]

    clear_screen()
    deleted_files = delete_files(files)

    if deleted_files:
        file_names = [f"{GREEN_TEXT}{file}{RESET_TEXT}" for file in deleted_files]
        delete_message = f"Deleted {' + '.join(file_names)}"
        draw_boxed_message([delete_message], show_success=True, success_text="Success")
    else:
        draw_boxed_message(["No Files Deleted"])
