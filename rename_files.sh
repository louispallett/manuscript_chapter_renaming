#!/bin/bash

# Check if an argument is provided
if [ -z "$2" ]; then
    clear
    echo " "
    echo "========================"
    echo "File Renaming"
    echo "========================"
    echo " "
    echo "Usage: $0 <directory> <startingValue>"
    echo " "
    echo "Starting value is equivilant to first chapter number - i.e. for a file with chapters 10 - 30, you would set this to 10, whereas chapters 1 - 9, you would set this to 1."
    echo " "
    echo "Also, please note that first chapters up to 9 must be done together FIRST, then move these files away and complete remaining files. This is due to numbering by computers vs numbering by humans (reading chapter 10 and chapter 11 as 1.0 and 1.1 respectively)."
    echo " "
    echo "########################################################################"
    echo "# ERROR: Please try again with correct command line arguments supplied"
    echo "########################################################################"
    echo " "
    exit 1
fi

# Get variables from command line
directory="$1"
startingValue="$2"

# Check if the directory exists
if [ ! -d "$directory" ]; then
    clear
    echo " "
    echo "########################################################################"
    echo "# ERROR: Directory '$directory' not found"
    echo "########################################################################"
    echo " "
    exit 1
fi

cd "$directory" || exit

# Value we loop FROM
i="$startingValue"

# Loop through each file
for file in *; do
    # Check if item is a file
    if [ -f "$file" ]; then
        # Get extension
        extension="${file##*.}"

        # Generate new name and rename
        new_name=$(printf "%02d_Chapter %d.%s" "$i" "$i" "$extension")
        mv "$file" "$new_name"

        ((i++))
    fi
done

echo "File renaming complete."

# NOTE: The first 9 chapters must be done seperately. All other chapters after can be done together!