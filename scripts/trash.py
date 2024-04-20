import os
import sys

BLUE_TEXT = "\033[34m"
GREEN_TEXT = "\033[32m"
RESET_COLOR = "\033[0m"
PURPLE_TEXT = "\033[35m"


def draw_boxed_message(lines, show_success=False, success_text="Success"):
    terminal_width = os.get_terminal_size().columns
    width = terminal_width - 4
    print("┌" + "─" * (width + 2) + "┐")
    for line in lines:
        visible_line = line.replace(GREEN_TEXT, "").replace(RESET_COLOR, "")
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
        success_text_colored = f"{GREEN_TEXT}{success_text}{RESET_COLOR}"
        print("└" + "─" * dashes_needed + " " + success_text_colored + " ─┘")
    else:
        print("└" + "─" * (width + 2) + "┘")


def clear_screen():
    print("\033[2J\033[H", end="")


def human_readable_size(size, decimal_places=1):
    units = ["B", "KB", "MB", "GB", "TB", "PB"]
    unit = units.pop(0)
    while size >= 1024 and units:
        size /= 1024.0
        unit = units.pop(0)
    return f"{size:.{decimal_places}f} {unit}"


def calculate_directory_size(directory):
    total_size = 0
    for dirpath, dirnames, filenames in os.walk(directory):
        for filename in filenames:
            filepath = os.path.join(dirpath, filename)
            if os.path.isfile(filepath):
                total_size += os.path.getsize(filepath)
    return total_size


def empty_trash():
    try:
        clear_screen()
        message = "Are you sure you want to permanently delete all items in the trash?"
        draw_boxed_message([message], show_success=False)

        prompt_query = f"Do you want to continue? {PURPLE_TEXT}[Y/N]{RESET_COLOR} "
        prompt_option = f"{BLUE_TEXT}(Y):{RESET_COLOR} "
        sys.stdout.write(prompt_query + prompt_option)
        sys.stdout.flush()

        confirmation = sys.stdin.readline().strip()
        if confirmation.upper() == "Y" or confirmation == "":
            trash_path = os.path.expanduser("~/.Trash")
            total_size = calculate_directory_size(trash_path)
            readable_size = human_readable_size(total_size, decimal_places=1)

            os.system("rm -rf ~/.Trash/*")

            clear_screen()
            success_message = f"Removed - {GREEN_TEXT}{readable_size}{RESET_COLOR}"
            draw_boxed_message([success_message], show_success=True)
        else:
            clear_screen()
    except KeyboardInterrupt:
        clear_screen()


if __name__ == "__main__":
    empty_trash()
