[![](https://images.microbadger.com/badges/image/jeckel/composer.svg)](https://microbadger.com/images/jeckel/composer "Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/version/jeckel/composer.svg)](https://microbadger.com/images/jeckel/composer "Get your own version badge on microbadger.com")

## jeckel/composer

![Composer](https://getcomposer.org/img/logo-composer-transparent5.png)

Composer is a tool for dependency management in PHP. It allows you to declare the libraries your project depends on and it will manage (install/update) them for you.
 
Please visit website : https://getcomposer.org/

## Supported tags and respective `Dockerfile` links

* `Alpine-php7`, `latest` (*[Dockerfile](https://github.com/jeckel/dockerfiles/blob/master/composer/Alpine-php7/Dockerfile)*)
* `Alpine-php5` (*[Dockerfile](https://github.com/jeckel/dockerfiles/blob/master/composer/Alpine-php5/Dockerfile)*)
* `Php7` (*[Dockerfile](https://github.com/jeckel/dockerfiles/blob/master/composer/Php7/Dockerfile)*)

The **Php7** version is based on the official [`php:7-cli`](https://hub.docker.com/_/php/) container and is mutch more larger (around 165 MB)

The **Alpine-Php[x]** version is based on Alpine and is much smaller (around 18 MB) 

## Volumes
Your local project needs to be mounted on the `/project` folder

## Usage

You can use all composer's options and command at the end of this command line :

```bash
docker run -v `pwd`:/project --rm -it jeckel/composer [command] [options]
```
Or, for the alpine version :
```bash
docker run -v `pwd`:/project --rm -it jeckel/composer [command] [options]
```


For example :
* to initialize your composer project :
```bash
docker run -v `pwd`:/project --rm -it jeckel/composer init
```
* to install or update you dependencies :
```bash
docker run -v `pwd`:/project --rm -it jeckel/composer install
```

### Restriction :
As composer is running in a dedicated container, it cannot perform platform requirements. Then it is recommanded o use the option `--ignore-platform-reqs` when executing `install` or `update` commands :

```bash
docker run -v `pwd`:/project --rm -it jeckel/composer install --ignore-platform-reqs
```

## Docker-compose

Exemple of docker-compose configuration :

```yaml
version: '2'
services:
  composer:
    image: jeckel/composer:Alpine-php5
    volumes:
      - .:/project
```

## Add shell alias

Create shell alias

```bash
$ echo "alias composer='docker run --rm -it -v \$(pwd):/project jeckel/composer'" >> ~/.bashrc
$ source ~/.bashrc
```