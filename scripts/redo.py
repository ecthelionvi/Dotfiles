import os
import sys

# Define text colors
BLUE_TEXT = "\033[34m"
GREEN_TEXT = "\033[32m"
RESET_COLOR = "\033[0m"
PURPLE_TEXT = "\033[35m"


def draw_boxed_message(lines, show_success=False, success_text="Success"):
    terminal_width = os.get_terminal_size().columns
    width = terminal_width - 4
    print("┌" + "─" * (width + 2) + "┐")
    for line in lines:
        visible_line = (
            line.replace(GREEN_TEXT, "")
            .replace(RESET_COLOR, "")
            .replace(PURPLE_TEXT, "")
        )
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


def redo_last_undo():
    try:
        clear_screen()
        message = "Are you sure you want to reapply the last undone operation?"
        draw_boxed_message([message], show_success=False)

        prompt_query = f"Do you want to continue? {PURPLE_TEXT}[Y/N]{RESET_COLOR} "
        prompt_option = f"{BLUE_TEXT}(Y/N):{RESET_COLOR} "
        sys.stdout.write(prompt_query + prompt_option)
        sys.stdout.flush()

        confirmation = sys.stdin.readline().strip()
        if confirmation.upper() == "Y" or confirmation == "":
            # Executing Git command to redo the last undo
            os.system("git reset --hard HEAD@{1}")

            clear_screen()
            success_message = "The last undone operation has been reapplied."
            draw_boxed_message([success_message], show_success=True)
        else:
            clear_screen()
    except KeyboardInterrupt:
        clear_screen()


if __name__ == "__main__":
    redo_last_undo()
