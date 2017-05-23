#!/bin/bash

readonly BACKUP_DIRECTORY=/backups
readonly NOW=$(date +"%Y%m%d%H%M%S")
readonly DUMP_DEBUG_FLAG=${DUMP_DEBUG:-false}


# Retrieve local user UID and group GID
cd ${BACKUP_DIRECTORY}
set -- `ls -nd .` && LOCAL_UID=$3 && LOCAL_GID=$4

if [ $DUMP_DEBUG_FLAG = 'true' ]; then
  TAR_OPTIONS="-v"
else
  TAR_OPTIONS=""
fi

# ----------------------------------------------------------
# Backup a mounted volume
# @usage
#    backup_volume <path_to_backup>
#
# @param    path to volume
# @variable $NOW is read
# @variable $BACKUP_DIRECTORY is read
# @variable $LOCAL_UID is read
# @variable $LOCAL_GID is read
# @variable $TAR_OPTIONS is read
# @variable $DUMP_DEBUG_FLAG is read
function backup_volume() {
    local SRC=$1
    local TARGET_FILE=backup_$(basename ${SRC})_${NOW}.tar.gz
    local TARGET=${BACKUP_DIRECTORY}/${TARGET_FILE}

    if [ $DUMP_DEBUG_FLAG = 'true' ]; then
        printf "Start backup volume '${SRC}'...\n"
    fi

    cd $(dirname ${SRC})
    tar ${TAR_OPTIONS} -czf ${TARGET} $(basename ${SRC})
    chown $LOCAL_UID:$LOCAL_GID ${TARGET}

    if [ $DUMP_DEBUG_FLAG = 'true' ]; then
        printf "Volume backup completed (${TARGET_FILE})\n"
    fi
}

# ----------------------------------------------------------
# Backup a linked mysql database
# @usage
#    backup_database <link name>
#
# @param    link name
# @variable $NOW is read
# @variable $BACKUP_DIRECTORY is read
# @variable $LOCAL_UID is read
# @variable $LOCAL_GID is read
# @variable $DUMP_DEBUG_FLAG is read
function backup_database() {
    local LINKED_CONTAINER=$1
#    local HOST=$(eval "echo \$${LINKED_CONTAINER}_ENV_MYSQL_HOST")
    local HOST=$(eval "echo \$${LINKED_CONTAINER}_PORT_3306_TCP_ADDR")
    local USER=$(eval "echo \$${LINKED_CONTAINER}_ENV_MYSQL_USER")
    local PASSWORD=$(eval "echo \$${LINKED_CONTAINER}_ENV_MYSQL_PASSWORD")
    local DATABASE=$(eval "echo \$${LINKED_CONTAINER}_ENV_MYSQL_DATABASE")

    local TARGET_FILE=backup_db_${1}_${NOW}.gz
    local TARGET=${BACKUP_DIRECTORY}/${TARGET_FILE}

    if [ $DUMP_DEBUG_FLAG = 'true' ]; then
        printf "Start backup MySQL Databe '${DATABASE}' on '${HOST}'...\n"
    fi

    mysqldump -h ${HOST} -u${USER} -p${PASSWORD} ${DATABASE} | gzip > ${TARGET}
    chown $LOCAL_UID:$LOCAL_GID ${TARGET}

    if [ $DUMP_DEBUG_FLAG = 'true' ]; then
        printf "Mysql backup completed (${TARGET_FILE})\n"
    fi
}

# If env variable $VOLUME is not defined, backup all mounted volumes
if [ -z ${VOLUME} ] ; then
    # Take only ext4 directories, exclude systems directories (/etc) and the backup directory
    VOLUMES_TO_BACKUP=( $(mount | grep ext4 | grep -v /etc | grep -v ${BACKUP_DIRECTORY} | cut -d\  -f 3) )
    for VOLUME in "${VOLUMES_TO_BACKUP[@]}"
    do
        backup_volume $VOLUME
    done
else
    backup_volume $VOLUME
fi

DATABASES_TO_BACKUP=( $(env | grep _ENV_MYSQL_DATABASE | cut -d\= -f 1) )
for DATABASE in "${DATABASES_TO_BACKUP[@]}"
do
    LINKED_CONTAINER=${DATABASE%_ENV_MYSQL_DATABASE*}
    backup_database ${LINKED_CONTAINER}
done