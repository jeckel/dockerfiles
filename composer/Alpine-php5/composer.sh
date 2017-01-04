#!/usr/bin/env sh

# Store composer command line args
COMPOSER_ARGS=$@

# Retrieve local user UID and group GID
set -- `ls -nd .` && LOCAL_UID=$3 && LOCAL_GID=$4

# Update rights on cache dir
chown $LOCAL_UID:$LOCAL_GID /composer-cache-dir

# Run composer command with the correct rights
sudo -g \#$LOCAL_GID -u \#$LOCAL_UID -E composer $COMPOSER_ARGS