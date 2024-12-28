# Personal Nextcloud Server

This repository contains the configuration files and setup instructions to 
deploy a personal Nextcloud server using Docker. 

Nextcloud is a powerful, self-hosted cloud storage solution that allows users to
securely store, share, and collaborate on files. This setup integrates
PostgreSQL as the database and Redis for caching to ensure optimal performance.
Additionally, a pgAdmin container is included for managing the PostgreSQL
database.

## Usage

To deploy the Nextcloud server, ensure that Docker and Docker Compose are
installed on your system, and then run `docker compose up -d`.

## Configuration

The `docker-compose.yml` relies on environment variables specified in an `.env`
file located in the root directory.

The `.env` file defines the settings for the Nextcloud deployment, including 
database credentials, server ports, and admin accounts. Below is a sample 
`.env` file:

```bash
COMPOSE_PROJECT_NAME=server                    # Docker Compose project name

POSTGRES_USER="username"                       # PostgreSQL username
POSTGRES_PASSWORD="password"                   # PostgreSQL password
POSTGRES_DB="nextcloud"                        # PostgreSQL database name

PGADMIN_DEFAULT_EMAIL="john.smith@example.com" # Default email for pgAdmin login
PGADMIN_DEFAULT_PASSWORD="password"            # Default password for pgAdmin login
PGADMIN_PORT=5050                              # Port for pgAdmin

NEXTCLOUD_HOSTNAME=nextcloud.example.local     # Nextcloud hostname
NEXTCLOUD_OVERWRITEPROTOCOL=https              # Overwrite nextcloud protocol
NEXTCLOUD_TRUSTED_DOMAINS="localhost:8080"     # Trusted domains
NEXTCLOUD_ADMIN_USER="admin"                   # Nextcloud admin username
NEXTCLOUD_ADMIN_PASSWORD="password"            # Nextcloud admin password
NEXTCLOUD_PORT=8080                            # Port for accessing Nextcloud

REDIS_PORT=6379                                # Redis cache port
REDIS_PASSWORD="password"                      # Redis cache password
```
