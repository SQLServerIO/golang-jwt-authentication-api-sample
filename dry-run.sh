#!/bin/sh
if test -z "$(which jq)";then
    echo "jq not found (https://stedolan.github.io/jq)"
    exit 1
fi
if test -z "$(redis-cli ping)";then
    echo "NOTE: Redis is not running (no PONG received), this will not succeed."
    exit 1
fi
TOKEN=$(curl -s -H "Content-Type: application/json" -X POST -d '{"Username":"haku","Password":"testing"}' localhost:5000/token-auth|jq -r ".token")
curl -H "Authorization: Bearer $TOKEN" localhost:5000/test/hello
