#!/bin/bash

# Define the child directory containing all the files
CHILD_DIR="dijkstrawberry"

# Create directories if they don't exist
mkdir -p captions metadata posts thumbnails

# Move files into their respective directories
for file in "$CHILD_DIR"/*; do
    if [[ $file == *.txt ]]; then
        mv "$file" captions/
    elif [[ $file == *.json.xz ]]; then
        mv "$file" metadata/
    elif [[ $file == *.mp4 ]]; then
        mv "$file" posts/
    elif [[ $file == *.jpg ]]; then
        mv "$file" thumbnails/
    fi
done

# Extract JSON data from .xz files in metadata and remove the .xz files
cd metadata || exit
for compressed_file in *.json.xz; do
    if [[ -f $compressed_file ]]; then
        xz --decompress "$compressed_file"
    fi
done

echo "Files have been organized successfully."
