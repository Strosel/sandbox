#!/bin/bash

# gogio 

go build -o sandbox github.com/strosel/sandbox

curl \
    -sSL \
    -XPOST \
    -H 'Authorization: token ${GITHUB_TOKEN}' \
    -d '{"branch": "pages"}' \
    --upload-file "./sandbox" \
    --header "Content-Type:application/octet-stream" \
    --write-out "%{http_code}" \
    "https://api.github.com/repos/strosel/sandbox/contents/sandbox"