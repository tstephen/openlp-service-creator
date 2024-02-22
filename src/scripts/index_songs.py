import os
import json
import sys

def main(directory_path: str):
    songs = [] #index(dir)
    songs.extend(os.listdir(directory_path))
    json_data = { "songs": sorted(songs) }

    file_path = "index.json"
    # Open the file in write mode
    with open(file_path, 'w') as json_file:
        # Write the JSON data to the file
        json.dump(json_data, json_file, indent=2)

main(sys.argv[1])

