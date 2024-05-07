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

        # Filter directories prioritizing start similarity
        start_similarity_dirs = [
            d for d in dirs if d.lower().startswith(search_query.lower())
        ]

        # If no directories are found with start similarity, then check for length similarity as a fallback
        if not start_similarity_dirs:
            start_similarity_dirs = [
                d
                for d in dirs
                if abs(len(d) - query_length) <= max(1, query_length // 3)
                and d.lower()[0]
                == search_query.lower()[0]  # Check for same starting character
            ]

        # Use Levenshtein distance (WRatio) to find the best match in the filtered list
        if start_similarity_dirs:
            best_match = process.extractOne(
                search_query, start_similarity_dirs, scorer=fuzz.WRatio
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
