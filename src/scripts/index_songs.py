import os
import json
import sys

EXCLUSIONS = [".git", ".gitignore", "README.md"]
def main(directory_path: str):
    songs = [] #index(dir)
    songs.extend(os.listdir(directory_path))
    songs = [song for song in songs
             if song not in EXCLUSIONS]
    json_data = { "songs": sorted(songs) }

    file_path = "index.json"
    # Open the file in write mode
    with open(file_path, 'w') as json_file:
        # Write the JSON data to the file
        json.dump(json_data, json_file, indent=2)

main(sys.argv[1])

