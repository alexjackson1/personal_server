#!/bin/bash
set -euo pipefail

# Define variables
ENV_FILE=".env"
SERVERS_TEMPLATE_FILE="servers.json.template"
SERVERS_OUTPUT_FILE="servers.json"
DOCKER_COMPOSE_CMD="docker compose"
PGADMIN_USER_ID=5050   # Hardcoded by the Docker image, can be overridden in .env
PGADMIN_GROUP_ID=5050  # Hardcoded by the Docker image, can be overridden in .env

# Function to log messages
echo_info() {
    echo "[INFO] $1"
}

echo_error() {
    echo "[ERROR] $1" >&2
}

# Check for required files
if [ ! -f "$ENV_FILE" ]; then
    echo_error "$ENV_FILE not found."
    exit 1
fi

echo_info "Loading environment variables from $ENV_FILE..."
# Export variables from the .env file
set -a
if ! source "$ENV_FILE"; then
    echo_error "Failed to source $ENV_FILE. Check for syntax errors."
    exit 1
fi
set +a

# Ensure required variables are set
: "${POSTGRES_USER:?Error: POSTGRES_USER is not set in $ENV_FILE}"
: "${POSTGRES_PASSWORD:?Error: POSTGRES_PASSWORD is not set in $ENV_FILE}"

# Check for required template file
if [ ! -f "$SERVERS_TEMPLATE_FILE" ]; then
    echo_error "$SERVERS_TEMPLATE_FILE not found."
    exit 1
fi

# Ensure envsubst is installed
if ! command -v envsubst &>/dev/null; then
    echo_error "envsubst not found. Install it using 'sudo apt install gettext' or 'brew install gettext'."
    exit 1
fi

# Check Docker availability
if ! command -v docker &>/dev/null; then
    echo_error "Docker not found. Please install it."
    exit 1
fi

# Check Docker Compose availability
if ! $DOCKER_COMPOSE_CMD version &>/dev/null; then
    DOCKER_COMPOSE_CMD="docker-compose"
    if ! $DOCKER_COMPOSE_CMD version &>/dev/null; then
        echo_error "Neither 'docker compose' nor 'docker-compose' is available. Please install Docker Compose."
        exit 1
    fi
fi

echo_info "Using Docker Compose command: $DOCKER_COMPOSE_CMD"

# Warn if AJ_NEXTCLOUD_DATA_DIR is not set
if [ -z "${AJ_NEXTCLOUD_DATA_DIR:-}" ]; then
    echo_info "AJ_NEXTCLOUD_DATA_DIR is not set. Falling back to default: /mnt/aj_nextcloud"
fi

# Extract target directory
TARGET_DIR=${AJ_NEXTCLOUD_DATA_DIR:-/mnt/aj_nextcloud}
PGADMIN_DATA_DIR="${TARGET_DIR}/pgadmin_data"
echo_info "Data directory: ${TARGET_DIR}"

# Create target directory
if [ ! -d "$TARGET_DIR" ]; then
    mkdir -p "$TARGET_DIR"
    echo_info "Created target directory: $TARGET_DIR"
fi

# Check if target directory is writable
if ! touch "$TARGET_DIR/testfile" &>/dev/null; then
    echo_error "$TARGET_DIR is not writable by the current user."
    exit 1
fi
rm -f "$TARGET_DIR/testfile"

echo_info "$TARGET_DIR is writable. Proceeding with the script."

# Create directory for pgAdmin data
if [ ! -d "$PGADMIN_DATA_DIR" ]; then
    mkdir -p "$PGADMIN_DATA_DIR"
    echo_info "Created pgAdmin data directory: $PGADMIN_DATA_DIR"
fi

# Set ownership for pgAdmin data directory
if ! chown -R "$PGADMIN_USER_ID:$PGADMIN_GROUP_ID" "$PGADMIN_DATA_DIR"; then
    echo_error "Failed to set ownership for $PGADMIN_DATA_DIR. Please check permissions."
    exit 1
fi

echo_info "Ownership set for $PGADMIN_DATA_DIR"

# Generate servers.json from the template
echo_info "Generating $SERVERS_OUTPUT_FILE from template..."
if ! envsubst < "$SERVERS_TEMPLATE_FILE" > "$SERVERS_OUTPUT_FILE"; then
    echo_error "Failed to generate $SERVERS_OUTPUT_FILE. Check your environment variables."
    exit 1
fi

echo_info "$SERVERS_OUTPUT_FILE generated successfully."

# Start Docker containers
echo_info "Starting Docker containers..."
if ! $DOCKER_COMPOSE_CMD up -d; then
    echo_error "Failed to start Docker containers."
    exit 1
fi

echo_info "Docker containers started successfully."
