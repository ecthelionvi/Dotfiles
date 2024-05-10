import sys


def parse_path(target_path):
    components = target_path.split("/")
    return [component for component in components if component]


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python dd_parser.py <target_path>")
        sys.exit(1)

    target_path = sys.argv[1]
    components = parse_path(target_path)
    print(" ".join(components))
