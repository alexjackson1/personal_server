#!/bin/bash

set -e

envsubst < servers.json.template > servers.json
docker compose up -d