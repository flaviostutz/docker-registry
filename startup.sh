#!/bin/bash

# LINE="$CLEANUP_CRON /cleanup.sh"
LINE="$CLEANUP_CRON bash -c 'echo /cleanup.sh > /async-cmd'"
echo "Preparing cron '$LINE'..."
crontab -l | { cat; echo "$LINE"; } | crontab -

echo "Scheduling cleanups..."
crond -f&

sleep 1 && echo "/entrypoint.sh /etc/docker/registry/config.yml" > /async-cmd&

/async-cmd.sh
