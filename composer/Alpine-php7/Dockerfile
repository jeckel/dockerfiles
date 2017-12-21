FROM php:7-cli-alpine
MAINTAINER Jeckel <jeckel@jeckel.fr>

ENV COMPOSER_HOME /composer

RUN	apk update && \
    apk upgrade && \
    apk add --update --no-cache \
        php7 \
        php7-openssl \
        php7-curl \
        php7-phar \
        php7-json \
        php7-zlib \
        php7-mbstring \
        git \
        sudo && \
# Fix sudo rights
    sed -i "s/root ALL=(ALL)/root ALL=(ALL:ALL)/g" /etc/sudoers

COPY composer-install.sh /usr/local/bin/composer-install.sh
COPY composer.sh /usr/local/bin/composer.sh
RUN chmod +x /usr/local/bin/composer.sh /usr/local/bin/composer-install.sh

# Installing composer
RUN composer-install.sh

RUN if [ ! -e $COMPOSER_HOME ]; then \
    mkdir $COMPOSER_HOME ; \
    fi

# CLeanup
RUN rm -Rf /var/{cache,lib}/apk /etc/apk/cache

#RUN ln -s /usr/bin/php7 /usr/bin/php

VOLUME /project
WORKDIR /project

ENTRYPOINT ["composer.sh", "--ansi"]