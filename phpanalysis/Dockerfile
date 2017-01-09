FROM alpine:latest
MAINTAINER Jeckel <jeckel@jeckel.fr>

ENV PHPCS_CODING_STANDARD=PSR2
#ENV EXCLUDE=vendor/,tests/_support/
ENV EXCLUDE=vendor/
ENV PHPCS_FILE_PATTERN="\.(php)$"
ENV PHPCS_IGNORE_WARNINGS=1
ENV PHPCS_ENCODING=utf-8

RUN	apk update && \
    apk upgrade && \
    apk add --update --no-cache \
        php7 \
        php7-phar \
        php7-ctype \
        php7-json \
        php7-mbstring \
        php7-zlib && \
    ln -s /usr/bin/php7 /usr/bin/php

ADD https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar /usr/local/bin/phpcs
ADD https://phar.phpunit.de/phpcpd.phar /usr/local/bin/phpcpd
ADD phpanalysis.sh /usr/local/bin/phpanalysis.sh

RUN chmod +x /usr/local/bin/phpcs \
    /usr/local/bin/phpcpd \
    /usr/local/bin/phpanalysis.sh

RUN sed -i "s/memory_limit = 128M/memory_limit = 512M/g" /etc/php7/php.ini

VOLUME /project
WORKDIR /project

ENTRYPOINT ["phpanalysis.sh"]