#!/bin/bash

# Check if a directory argument is provided
if [ -z "$2" ]; then
    echo "Usage: $0 <directory> <startingValue>"
    exit 1
fi

# Specify the directory from the command line argument
directory="$1"
# Specify first file number (i.e. 1 for first file to be "01_Chapter 1" or 10 to be "10_Chapter 10")
startingValue="$2"

# Check if the specified directory exists
if [ ! -d "$directory" ]; then
    echo "Error: Directory '$directory' not found."
    exit 1
fi

cd "$directory" || exit

# Initialize a Chapter Number variable (based on command line argument 2)
i="$startingValue"

# Loop through each file in the directory
for file in *; do
    # Check if the item is a file
    if [ -f "$file" ]; then
        # Extract extension
        extension="${file##*.}"

        # Generate the new name with the correct format
        new_name=$(printf "%02d_Chapter %d.%s" "$i" "$i" "$extension")

        # Renaming
        mv "$file" "$new_name"

        ((i++))
    fi
done

echo "File renaming complete."

# NOTE: This code currently works for chapters up to 9 files, but is buggy when > 9. Due to file renaming. Can split up files in batches of 10 (for now).
# This is due to how humans read numbering vs computers.