#!/bin/bash

# Check if a file name is provided as an argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <filename>"
    exit 1
fi

filename="$1"

# Check if the file exists
if [ ! -f "$filename" ]; then
    echo "File not found: $filename"
    exit 1
fi

# Iterate over each line in the file
while IFS= read -r line; do
    response=$(curl -s "$line" | tr -d '[:space:]')
    if [ -z "$response" ]; then
        echo "nothing !!!"
    else
        # Ensure the response is not empty or just whitespace before sending
        trimmed_response=$(echo "$response" | tr -d '[:space:]')
        if [ -z "$trimmed_response" ]; then
            echo "nothing !!!"
        else
            curl -X POST -d "$response" https://discord.com/api/webhooks/1216775264588005407/KPWsewc6mEFSPesILV8WFDi8eB6SXC6wZ_Inno-_GJU_jQKzSXdp5NX3HAtIuNzZyUEX
        fi
    fi
done < "$filename"
