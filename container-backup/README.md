[![](https://images.microbadger.com/badges/image/jeckel/container-backup.svg)](https://microbadger.com/images/jeckel/container-backup "Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/version/jeckel/container-backup.svg)](https://microbadger.com/images/jeckel/container-backup "Get your own version badge on microbadger.com") [![Twitter](https://img.shields.io/badge/Twitter-%40jeckel4-blue.svg)](https://twitter.com/intent/user?screen_name=jeckel4) [![LinkedIn](https://img.shields.io/badge/LinkedIn-Julien%20Mercier-blue.svg)](https://www.linkedin.com/in/jeckel/)

# THIS DOCKERFILE IS OBSOLETE

Please now consider looking at this other Dockerfiles:
- [Volume-Backup](https://github.com/jeckel/dockerfiles/blob/master/volume-backup/) to backup volumes
- [MySQL-Backup](https://github.com/jeckel/dockerfiles/blob/master/mysql-backup/) to backup mysql database

# ---------------------------

# Container Backup

This image is used to backup data from your container in a scheduled period.

It can backup :
- mounted volume from another volume
- linked mysql/mariadb databases


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
    --volumes-from nginx_container \
    -e SCHEDULE="daily" \
    jeckel\container-backup
```

This will use the backups folder as a target :
- mounted folder's name is used as a basename for the backup files.
- linked mysql's name is used as a basename for the dump files.

For example, using the option `-v /path/to/volume:/project` will backup the volume folder into a tar.gz file called `backup_project_<datetime>.tar.gz`


* **Make a one time backup**

```shell
docker run --rm -it \
    --link mysql_container \
    -v $(pwd)/backups/:/backups \
    --volumes-from nginx_container \
    jeckel\container-backup backup.sh
```

## Environments

Some environment variable has default value, so you needn't set all of them in most cases.

* `SCHEDULE`: Schedule of backups, default is `"daily"`
* `VOLUME` : Specify which mounted volume to backup, is not defined, all mounted volumes (except `/backups`) will be backup
* `DUMP_DEBUG` : If set to `"true"` then show verbose infos, default is `"false"`

## Schedule syntax:

* `"hourly"`: 0 minute every hour.
* `"daily"`: 02:00 every day.
* `"weekly"`: 03:00 on Sunday every week.
* `"monthly"`: 05:00 on 1st every month.
* `"0 5 * * 6"`: crontab syntax.


## in `docker-compose` with wordpress

```yml
version: '2'
services:
  wordpress:
    image: wordpress
    depends_on:
      - mysql
    ports:
      - 8080:80
    environment:
      - WORDPRESS_DB_PASSWORD=wordpress
  mysql:
    image: mariadb
    environment:
      - MYSQL_ROOT_PASSWORD=wordpress
      - MYSQL_DATABASE=wordpress
      - MYSQL_USER=wordpress
      - MYSQL_PASSWORD=wordpress
  backup:
    image: jeckel/container-backup
    depends_on:
      - wordpress
      - mysql
    links:
      - mysql
    volumes:
      - ./backups:/backups
    volumes_from:
      - wordpress
      - mysql
```

In this example :
- all volumes from the `wordpress` and `mysql` container will be archived in a `tar.gz` file in the `backups` folder
- database from `mysql` container will be dumped

## Current limitation

MySQL dump is base on environment variables, so only one database per container will be dumped.
