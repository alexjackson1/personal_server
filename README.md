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
installed on your system. 

Run the `launch.sh` script in the root directory of this repository. This script will:
1. Check for required dependencies.
2. Validate environment variables in the `.env` file.
3. Configure the necessary file permisions and data directories.
4. Start the Docker containers for Nextcloud, PostgreSQL, Redis, and pgAdmin.

```bash
./launch.sh
```
## Configuration

The `launch.sh` script and `docker-compose.yml` files rely on environment variables specified in the `.env` file located in the same directory as the `launch.sh` script.

The `.env` file defines the settings for the Nextcloud deployment, including database credentials, server ports, and admin accounts. Below is a sample `.env` file:

```bash
COMPOSE_PROJECT_NAME=aj_nextcloud

AJ_NEXTCLOUD_DATA_DIR="/data/aj_nextcloud"     # Path to store Nextcloud data
POSTGRES_USER="username"                       # PostgreSQL username
POSTGRES_PASSWORD="password"                   # PostgreSQL password
POSTGRES_DB="nextcloud"                        # PostgreSQL database name
PGADMIN_DEFAULT_EMAIL="john.smith@example.com" # Default email for pgAdmin login
PGADMIN_DEFAULT_PASSWORD="password"            # Default password for pgAdmin login
PGADMIN_PORT=5050                              # Port for pgAdmin
NEXTCLOUD_ADMIN_USER="admin"                   # Nextcloud admin username
NEXTCLOUD_ADMIN_PASSWORD="password"            # Nextcloud admin password
NEXTCLOUD_PORT=8080                            # Port for accessing Nextcloud
REDIS_PORT=6379                                # Redis cache port
REDIS_PASSWORD="password"                      # Redis cache password
```

