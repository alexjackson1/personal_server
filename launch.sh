#!/bin/bash

set -e

export $(grep -vE '^\s*#' .env | grep -vE '^\s*$' | xargs)

envsubst < servers.json.template > servers.json
docker compose up -d