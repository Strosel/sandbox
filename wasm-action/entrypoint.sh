#!/bin/bash


REPO="sandbox"
GITHUB_PATH="strosel/${REPO}"
API_URL="https://api.github.com/repos/${GITHUB_PATH}"

gogio -target js -o $REPO github.com/$GITHUB_PATH

SHA=$(curl -X GET \
    "${API_URL}/git/trees/pages" | \
    jq '.tree | map(select(.path == "main.wasm")) | .[0]? | .sha')

echo "{ \
    \"message\": \"new release\",\
    \"branch\": \"pages\",\
    \"content\": \"$(openssl base64 -A -in ./$REPO/main.wasm)\",\
    \"sha\": ${SHA}
    }" > data.txt

curl \
    -X PUT \
    -H "Accept: application/vnd.github.v3+json" \
    -H "Authorization: token ${GITHUB_TOKEN}" \
    -d @data.txt \
    --write-out "%{http_code}" \
    "${API_URL}/contents/main.wasm"