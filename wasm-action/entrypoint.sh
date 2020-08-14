#!/bin/bash

# gogio 

go build -o sandbox github.com/strosel/sandbox

data="{ \
    \"message\": \"new release\",\
    \"branch\": \"pages\",\
    \"content\": \"$(openssl base64 -A -in ./sandbox)\",\
    \"sha\": $(curl -X GET https://api.github.com/repos/username/repo/contents/mattei.csv | jq .sha))\"
    }"

curl \
    -X PUT \
    -H "Accept: application/vnd.github.v3+json" \
    -H "Authorization: token ${GITHUB_TOKEN}" \
    -d "${DATA}" \
    --write-out "%{http_code}" \
    "https://api.github.com/repos/strosel/sandbox/contents/sandbox"