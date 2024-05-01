import os
import fnmatch
import sys
from alive_progress import alive_bar

BLUE_TEXT = "\033[34m"
GREEN_TEXT = "\033[32m"
RESET_TEXT = "\033[0m"
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


def find_and_delete_files(pattern, root_dir):
    deleted_count = 0
    for root, dirs, files in os.walk(root_dir):
        for filename in fnmatch.filter(files, pattern):
            file_path = os.path.join(root, filename)
            try:
                os.remove(file_path)
                deleted_count += 1
            except OSError as e:
                print(f"\rError deleting {file_path}: {e}")
    return deleted_count


if __name__ == "__main__":
    pattern = ".DS_Store"
    root_dir = os.path.expanduser("~")

    try:
        clear_screen()
        message = "Are you sure you want to permanently delete all .DS_Store files?"
        draw_boxed_message([message], show_success=False)
        prompt_query = f"Do you want to continue? {PURPLE_TEXT}[Y/N]{RESET_TEXT} "
        prompt_option = f"{BLUE_TEXT}(Y):{RESET_TEXT} "
        sys.stdout.write(prompt_query + prompt_option)
        sys.stdout.flush()
        confirmation = sys.stdin.readline().strip()

        if confirmation.upper() == "Y" or confirmation == "":
            clear_screen()
            with alive_bar(
                title="Deleting .DS_Store Files",
                unknown="dots_waves",
                stats=False,
                monitor=False,
                force_tty=True,
            ) as bar:
                deleted_count = find_and_delete_files(pattern, root_dir)
                bar()
            clear_screen()
            success_message = (
                f"Removed {GREEN_TEXT}{deleted_count}{RESET_TEXT} .DS_Store Files"
            )
            draw_boxed_message([success_message], show_success=True)
        else:
            clear_screen()
    except KeyboardInterrupt:
        clear_screen()
