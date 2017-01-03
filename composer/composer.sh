#!/usr/bin/env bash

# Store composer command line args
COMPOSER_ARGS=$@

# Retrieve local user UID and group GID
set -- `ls -nd .` && LOCAL_UID=$3 && LOCAL_GID=$4

# Run composer command with the correct rights
sudo -g \#$LOCAL_GID -u \#$LOCAL_UID composer $COMPOSER_ARGS