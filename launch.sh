#!/bin/bash

set -e

export $(grep -vE '^\s*#' .env | grep -vE '^\s*$' | xargs)

mkdir -p /mnt/ajcloud/pgadmin_data
sudo chown -R 5050:5050 /mnt/ajcloud/pgadmin_data

envsubst < servers.json.template > servers.json
docker compose up -d