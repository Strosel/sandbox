#!/bin/bash

# gogio 

REPO="sandbox"
GITHUB_PATH="strosel/${REPO}"
API_URL="https://api.github.com/repos/${GITHUB_PATH}/contents/${REPO}"

go build -o $REPO github.com/$GITHUB_PATH

echo "{ \
    \"message\": \"new release\",\
    \"branch\": \"pages\",\
    \"content\": \"$(openssl base64 -A -in ./sandbox)\",\
    \"sha\": \"$(curl -X GET $API_URL | jq .sha)\"
    }" > data.txt

curl \
    -X PUT \
    -H "Accept: application/vnd.github.v3+json" \
    -H "Authorization: token ${GITHUB_TOKEN}" \
    -d @data.txt \
    --write-out "%{http_code}" \
    $API_URL