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


# SEEMS LIKE LATEST VERSIONS OF docker registry PERFORMS THIS AS WELL. TEST AND COMPARE WITH A FULL REPO
# IFS=$'\n'
# used_hashes=`mktemp`
# marked_hashes=`mktemp`
# found=""
# #for repository in `find ${BASE_PATH} -mindepth 2 -maxdepth 2 -type d | sed "s#${BASE_PATH}/##"`; do
# for repository in `find ${BASE_PATH} -name "_manifests" -type d | sed -e "s#${BASE_PATH}/##" -e "s#/_manifests##"`; do
#     echo "# Processing repository: $repository"
#     ls ${BASE_PATH}/${repository}/_manifests/tags/*/current/link >/dev/null 2>&1 || { echo "ERROR: Invalid repository. No tags/*/current/link files found"; echo; continue; }
#     test -d "${BASE_PATH}/${repository}/_manifests/revisions/sha256" || { echo "ERROR: Invalid repository. revisions/sha256 dir not found"; echo; continue; }

#     for tag_hash in ${BASE_PATH}/${repository}/_manifests/tags/*/current/link; do 
#         cat "${tag_hash}" | cut -d':' -f2; 
#     done > "${used_hashes}"
    
#     echo "# Removing revisions of $repository:"
#     ls -t ${BASE_PATH}/${repository}/_manifests/revisions/sha256 | fgrep -vf "${used_hashes}" | tail -n+${KEEP_LAST_IMAGES} | tee ${marked_hashes}
#     if test -s $marked_hashes ; then
#       if [ ${DRY_RUN} -ne 1 ]; then
#           cat ${marked_hashes} | sed "s#^#${BASE_PATH}/${repository}/_manifests/revisions/sha256/#" | xargs rm -rf && found="true"
#       fi
#     else
#       echo "Nothing to delete."
#     fi
#     echo
# done
# rm ${used_hashes}
# rm ${marked_hashes}
#
#
#
