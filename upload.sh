#!/bin/bash

API_KEY="$1"
DIRECTORY="$2"
URLS_FILE="$DIRECTORY/file.txt"

# Ensure the URLs file is empty initially

> "$URLS_FILE"

# For every image file, create url and parse it to a text file! 

for file in "$DIRECTORY"/*.{jpg,jpeg,png,gif}; do
    if [ -f "$file" ]; then
        response=$(curl -F "key=$API_KEY" -F "image=@$file" https://api.imgbb.com/1/upload)
        url=$(echo "$response" | grep -o '"url":"[^"]*' | sed 's/"url":"//' | head -n 1 | sed 's/\\//g')
        echo "Uploaded: $file"
        echo "URL: $url"
        echo "$url" >> "$URLS_FILE"
    fi
done
