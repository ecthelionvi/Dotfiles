import os

def draw_boxed_message(lines):
    width = max(len(line) for line in lines)
    print('┌' + '─' * (width + 2) + '┐')
    for line in lines:
        print('│ ' + line.ljust(width) + ' │')
    print('└' + '─' * (width + 2) + '┘')

def delete_file(file_path):
    messages = []
    try:
        os.remove(file_path)
        messages.append(f"Deleted {file_path}")
    except FileNotFoundError:
        messages.append(f"File not found: {file_path}")
    except OSError as e:
        messages.append(f"Error deleting {file_path}: {e}")
    return messages

if __name__ == "__main__":
    files = ["/Users/rob/.cache/lvim/lvim.shada", "/Users/rob/.cache/lvim/project_nvim/project_history"]
    delete_messages = []
    for file_path in files:
        delete_messages.extend(delete_file(file_path))
    draw_boxed_message(delete_messages)

