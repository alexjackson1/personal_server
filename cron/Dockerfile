FROM debian:stable-slim

# Install the necessary packages
RUN apt-get update && apt-get install -y \
  cron wget ca-certificates php-cli dumb-init \
  && rm -rf /var/lib/apt/lists/*

# Copy the crontab file to the cron.d directory
COPY crontab /etc/cron.d/crontab
RUN chmod 0644 /etc/cron.d/crontab
RUN crontab /etc/cron.d/crontab

# Copy the script and make it executable
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Use dumb-init as entrypoint
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/entrypoint.sh"]

