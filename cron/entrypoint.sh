#!/bin/sh
touch /var/log/cron.log
tail -f /var/log/cron.log &
exec cron -f