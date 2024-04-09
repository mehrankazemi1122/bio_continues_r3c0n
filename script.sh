#!/bin/bash

# Check if a file name is provided as an argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <filename>"
    exit 1
fi

filename="$1"

# Check if the file existss
if [ ! -f "$filename" ]; then
    echo "File not found: $filename"
    exit 1
fi

# Iterate over each line in the file##
while IFS= read -r line; do
    response=$(curl -s "$line")
    echo $response
    echo $response | base64
    encoded_response=$(echo "$response" | base64)
#    echo $response | base64
    if [ "$encoded_response" = "Cg==" ] || [ "$response" = "404 page not found" ]; then
        echo "nothing !!!"
    else
        # Convert the response to a JSON object with jq
        # The response is assumed to be a simple string that needs to be JSON encoded
        json_target=$(jq -nc --arg target "$line" '{"content": $target}')
        json_response=$(jq -nc --arg resp "$response" '{"content": $resp}')

        # Send the JSON response to test.com
        curl -X POST -H "Content-Type: application/json" -d "$json_target" https://discord.com/api/webhooks/1216775264588005407/KPWsewc6mEFSPesILV8WFDi8eB6SXC6wZ_Inno-_GJU_jQKzSXdp5NX3HAtIuNzZyUEX
        curl -X POST -H "Content-Type: application/json" -d "$json_response" https://discord.com/api/webhooks/1216775264588005407/KPWsewc6mEFSPesILV8WFDi8eB6SXC6wZ_Inno-_GJU_jQKzSXdp5NX3HAtIuNzZyUEX
                curl -X POST -H "Content-Type: application/json" -d "{\"content\":\"------------------------\"}" https://discord.com/api/webhooks/1216775264588005407/KPWsewc6mEFSPesILV8WFDi8eB6SXC6wZ_Inno-_GJU_jQKzSXdp5NX3HAtIuNzZyUEX
    fi
done < "$filename"
