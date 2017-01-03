[![](https://images.microbadger.com/badges/image/jeckel/composer.svg)](https://microbadger.com/images/jeckel/composer "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/jeckel/composer.svg)](https://microbadger.com/images/jeckel/composer "Get your own version badge on microbadger.com")

## jeckel/composer

![Composer](https://getcomposer.org/img/logo-composer-transparent5.png)

Composer is a tool for dependency management in PHP. It allows you to declare the libraries your project depends on and it will manage (install/update) them for you.
 
Please visit website : https://getcomposer.org/

## Features

* Based on php7.0-cli
* Use latest version of composer

## Volumes
Your local project needs to be mounted on the `/project` folder

## Usage

You can use all composer's options and command at the end of this command line :

```bash
docker run -v `pwd`:/project --rm -it composer [command] [options]
```


For exemple :
* to initialize your composer project :
```bash
docker run -v `pwd`:/project --rm -it composer init
```
* to install or update you dependencies :
```bash
docker run -v `pwd`:/project --rm -it composer install
```

### Note :
As composer is running in a dedicated composer, it cannot perform platform requirements. Then it is recommanded o use the option `--ignore-platform-reqs` when executing `install` or `update` commands :

```bash
docker run -v `pwd`:/project --rm -it composer install --ignore-platform-reqs
```

## Docker-compose

Exemple of docker-compose configuration :

```yaml
version: '2'
services:
  composer:
    image: jeckel/composer
    volumes:
      - .:/project
```