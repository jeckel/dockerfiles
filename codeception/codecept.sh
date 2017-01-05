#!/usr/bin/env bash

# Store command line args
CMD_ARGS=$@

# Retrieve local user UID and group GID
set -- `ls -nd .` && LOCAL_UID=$3 && LOCAL_GID=$4

which codecept

# Run command with the correct rights
sudo -g \#$LOCAL_GID -u \#$LOCAL_UID -E /repo/codecept $CMD_ARGS