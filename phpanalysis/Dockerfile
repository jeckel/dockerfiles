FROM alpine:latest
MAINTAINER Jeckel <jeckel@jeckel.fr>

ENV PHPCS_CODING_STANDARD=PSR2
ENV EXCLUDE=vendor/,tests/_support/
#ENV EXCLUDE=vendor/
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
        php7-bz2 \
        php7-zlib \
        php7-xml \
        php7-dom \
        sudo && \
    ln -s /usr/bin/php7 /usr/bin/php && \
# Fix sudo rights
    sed -i "s/root ALL=(ALL)/root ALL=(ALL:ALL)/g" /etc/sudoers

ADD https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar /usr/local/bin/phpcs
ADD https://phar.phpunit.de/phploc.phar /usr/local/bin/phploc
ADD http://static.phpmd.org/php/latest/phpmd.phar /usr/local/bin/phpmd
ADD phpanalysis.sh /usr/local/bin/phpanalysis.sh

RUN chmod +x /usr/local/bin/phpcs \
    /usr/local/bin/phploc \
    /usr/local/bin/phpmd \
    /usr/local/bin/phpanalysis.sh

RUN sed -i "s/memory_limit = 128M/memory_limit = 512M/g" /etc/php7/php.ini

VOLUME /project
WORKDIR /project

ENTRYPOINT ["phpanalysis.sh"]