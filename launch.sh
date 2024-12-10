#!/bin/bash

set -e

export $(cat .env | xargs)

envsubst < servers.json.template > servers.json
docker compose up -d