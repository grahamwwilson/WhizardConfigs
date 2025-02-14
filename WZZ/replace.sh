#!/bin/bash

# Check if correct number of arguments is passed
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <search_string> <file>"
    exit 1
fi

# Assign parameters to variables
search_string="$1"
file="$2"

# Generate the output filename dynamically based on the search string
output_file="${file%.txt}_${search_string}.sin"

sed "s/#${search_string}process/process/g" "$file" > "$output_file"

echo "Replacement complete. Output written to $output_file"

exit
