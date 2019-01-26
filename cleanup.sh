#!/bin/bash

echo "CLEANUP BEGIN"

#forked from https://gist.github.com/eedugon/69da0397c142e56f4186ee691502e7ee
BASE_PATH=/var/lib/registry
CONFIG_PATH=/etc/docker/registry/config.yml
DRY_RUN=0
KEEP_LAST_IMAGES=0
REGISTRY_GC_COMMAND="/bin/registry garbage-collect $CONFIG_PATH --delete-untagged=true"

echo "Calling '$REGISTRY_GC_COMMAND'"
bash -c "$REGISTRY_GC_COMMAND"

echo "CLEANUP END"

echo "START REGISTRY"
echo "/entrypoint.sh $CONFIG_PATH" > /async-cmd

