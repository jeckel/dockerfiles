#!/bin/bash

# ----------------------------------------------------------
# Backup a linked mysql database
function backup_database() {
    local mysqlHost=$1
    local mysqlUser=$2
    local mysqlPwd=$3
    local mysqlDatabase=$4
    local targetDir=$5

    local target=${targetDir}/backup_db_${mysqlDatabase}_$(date +"%Y%m%d%H%M%S").sql.gz
    local uid
    local gid

    cd ${targetDir}
    set -- `ls -nd .` && uid=$3 && gid=$4

    mysqldump -h ${mysqlHost} -u${mysqlUser} -p${mysqlPwd} ${DUMP_OPTIONS} ${mysqlDatabase} | gzip > ${target}
    chown ${uid}:${gid} ${target}
}

# ----------------------------------------------------------
# Cleanup obsolete backup
#
# @param    path to source folder
# @param    path to target folder
# @param    nb backup to keep
function cleanup() {
    local mysqlDatabase=$1
    local targetDir=$2
    local backupMask=${targetDir}/backup_db_${mysqlDatabase}_*.sql.gz
    local keepHistory=$3

    # Keep only the last "$keepHistory" backups
    ls -1dr ${backupMask} | tail -n +$((keepHistory + 1)) | xargs rm -rf
}

backup_database ${MYSQL_HOST} ${MYSQL_USER} ${MYSQL_PASSWORD} ${MYSQL_DATABASE} ${TARGET_DIRECTORY}

if [ ! -z ${KEEP_NB_BACKUP} ]; then
    cleanup ${MYSQL_DATABASE} ${TARGET_DIRECTORY} ${KEEP_NB_BACKUP}
fi