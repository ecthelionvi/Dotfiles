import os
import sys
from rapidfuzz import process, fuzz
import shlex

def get_closest_match(named_dirs, search_query):
    try:
        # Use Levenshtein distance (WRatio) to find the best match in the named directories
        best_match = process.extractOne(
            search_query, named_dirs.keys(), scorer=fuzz.WRatio, score_cutoff=70
        )
        if best_match:
            print(named_dirs[best_match[0]])  # Output the corresponding path of the best match
        else:
            print("", end="")
    except Exception as e:
        print("", end="")

if __name__ == "__main__":
    named_dirs_file = os.path.expanduser("~/.named_dirs")
    search_term = sys.argv[1]

    # Read named directories from the file
    named_dirs = {}
    with open(named_dirs_file, "r") as file:
        for line in file:
            if ":" in line:
                name, path = line.strip().split(":", 1)
                name = shlex.quote(name.strip())
                named_dirs[name] = path.strip()

    get_closest_match(named_dirs, search_term)
