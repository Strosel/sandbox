#!/bin/bash

# gogio 

go build -o sandbox github.com/strosel/sandbox

curl \
    -i -X PUT \
    -H 'Authorization: token ${GITHUB_TOKEN}' \
    -d "{\"path\": \"sandbox\", \
    \"message\": \"update\", \"content\": \"$(openssl base64 -A -in ./sandbox)\", \"branch\": \"pages\", \
    \"sha\": $(curl -X GET https://api.github.com/repos/strosel/sandbox/contents/sandbox | jq .sha)}" \
    "https://api.github.com/repos/strosel/sandbox/contents/mattei.csv"