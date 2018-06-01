[![](https://images.microbadger.com/badges/image/jeckel/container-backup.svg)](https://microbadger.com/images/jeckel/container-backup "Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/version/jeckel/container-backup.svg)](https://microbadger.com/images/jeckel/container-backup "Get your own version badge on microbadger.com") [![Twitter](https://img.shields.io/badge/Twitter-%40jeckel4-blue.svg)](https://twitter.com/intent/user?screen_name=jeckel4) [![LinkedIn](https://img.shields.io/badge/LinkedIn-Julien%20Mercier-blue.svg)](https://www.linkedin.com/in/jeckel/)

# MySQL Database Backup

This image is used to backup MySQL Database from your MySQL container in a scheduled period.

## Usage

There are two ways to run this tool.
- run as daemon and backup volumes on schedules
- run as one time backup

**Examples**

* **Backup all mounted volumes and linkes databases on daily basis**

```shell
docker run -d --rm \
    --link mysql_container \
    -v $(pwd)/backups/:/backups \
    -e SCHEDULE="daily" \
    -e MYSQL_HOST="some_mysql" \
    -e MYSQL_USER="user" \
    -e MYSQL_PASSWORD="password" \
    -e MYSQL_DATABASE="testdb" \
    jeckel\mysql-backup
```

This will use the backups folder as a target :
- linked mysql's name is used as a basename for the dump files.


* **Make a one time backup**

```shell
docker run --rm -it \
    --link mysql_container \
    -v $(pwd)/backups/:/backups \
    -e MYSQL_HOST="some_mysql" \
    -e MYSQL_USER="user" \
    -e MYSQL_PASSWORD="password" \
    -e MYSQL_DATABASE="testdb" \
    jeckel\mysql-backup backup.sh
```

## Environments

Some environment variable has default value, so you needn't set all of them in most cases.

* `SCHEDULE`: Schedule of backups, default is `"daily"`
* `TARGET_DIRECTORY`: Folder in which backups will be stored, default is `/backups` (it should be a persistent volume of some sort)
* `KEEP_NB_BACKUP`: If defined, only the last `x` backups will be kept, other backup will be deleted. If not specified, no backups are deleted by this script. 
* `MYSQL_HOST`: Hostname of the mysql container
* `MYSQL_DATABASE`: Database name on the mysql container
* `MYSQL_USER`: Username to use with at least read access on that database
* `MYSQL_PASSWORD`: Password to use with username
* `DUMP_OPTIONS`: Additionnal option you want to use with mysqldump

## Schedule syntax:

* `"hourly"`: 0 minute every hour.
* `"daily"`: 02:00 every day.
* `"weekly"`: 03:00 on Sunday every week.
* `"monthly"`: 05:00 on 1st every month.
* `"0 5 * * 6"`: crontab syntax.

## Example

You can look at the [test docker-compose.yml file](https://github.com/jeckel/dockerfiles/blob/master/volume-backup/tests/docker-compose.yml) to see some examples.

## License
Released under the MIT License.

Copyright Julien MERCIER https://github.com/jeckel