[![](https://images.microbadger.com/badges/image/jeckel/phpanalysis.svg)](https://microbadger.com/images/jeckel/phpanalysis "Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/version/jeckel/phpanalysis.svg)](https://microbadger.com/images/jeckel/phpanalysis "Get your own version badge on microbadger.com") [![Twitter](https://img.shields.io/badge/Twitter-%40jeckel4-blue.svg)](https://twitter.com/intent/user?screen_name=jeckel4)

# PHP Analysis

A container used to generate reports of Quality Analysis of a PHP project.

This container include the followig tools :
* [PHP_CodeSniffer](https://github.com/squizlabs/PHP_CodeSniffer)

Planned tools :
* PHPCPD
* PHPMD
* ...

## How to use this image

Simply run the following command at the root of your project.

```bash
$ docker run -it --rm -v `pwd`:/project jeckel/phpanalysis
```

This container is build with lot of environment variables useable to configure your analysis.

## Environment Variables :

### PHP_CodeSniffer

#### `PHPCS_CODING_STANDARD`

The coding standard, you can also specify a path to your own standard here e. g. /path/to/my/standard/dir/

* Default : `ENV PHPCS_CODING_STANDARD=PSR2`

#### `PHPCS_IGNORE`

Comma-separated list of file patterns being ignored.

* Default : `ENV PHPCS_IGNORE=vendor/,tests/_support/`

#### `PHPCS_FILE_PATTERN`

egrep compatible pattern of files to be checked

* Default : `ENV PHPCS_FILE_PATTERN="\.(php)$"`

#### `PHPCS_IGNORE_WARNINGS`

Ignore warnings

* Default : `ENV PHPCS_IGNORE_WARNINGS=1`

#### `PHPCS_ENCODING`

Encoding
* Default : `ENV PHPCS_ENCODING=utf-8`