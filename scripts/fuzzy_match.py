import os
import sys
from rapidfuzz import process, fuzz


def get_closest_match(search_dir, search_query):
    try:
        # List only directories
        dirs = [
            d
            for d in os.listdir(search_dir)
            if os.path.isdir(os.path.join(search_dir, d))
        ]
        query_length = len(search_query)

        # Filter directories based on character match and length similarity
        filtered_dirs = [
            d
            for d in dirs
            if abs(len(d) - query_length)
            <= max(1, query_length // 3)  # Loose length similarity
            or d.lower().startswith(search_query.lower())  # Strong start similarity
        ]

        # Use Levenshtein distance (WRatio) to find the best match in the filtered list
        if filtered_dirs:
            best_match = process.extractOne(
                search_query, filtered_dirs, scorer=fuzz.WRatio
            )
            if best_match:
                print(best_match[0])  # Output the best match
            else:
                print("", end="")
        else:
            print("", end="")
    except Exception as e:
        print("", end="")


if __name__ == "__main__":
    search_directory = sys.argv[1]
    search_term = sys.argv[2]
    get_closest_match(search_directory, search_term)
