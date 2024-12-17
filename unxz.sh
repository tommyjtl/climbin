#!/bin/bash

# Directory containing the .json.xz files
DIRECTORY="."

# Navigate to the directory
cd "$DIRECTORY" || exit

# Loop through all .json.xz files in the directory
for file in *.json.xz; do
  if [[ -f "$file" ]]; then
    # Decompress the file using xz
    xz -d "$file"
    echo "Unzipped: $file"
  else
    echo "No .json.xz files found in the directory."
  fi
done
