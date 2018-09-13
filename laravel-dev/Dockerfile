FROM php:7-fpm-alpine
LABEL maintainer="Julien MERCIER-ROJAS <julien@jeckel-lab.fr>"
# This Dockerfile build a php image with composer included
# It used for development only
#
# Reminder : It's not recommanded to have composer installed in container for production
# as this is required for developpement only.
#

# Install xdebug mysql and zip extensions
RUN apk add --no-cache --update --virtual buildDeps autoconf gcc musl-dev make zlib-dev \
     && pecl install xdebug \
     && docker-php-ext-install pdo_mysql zip \
     && docker-php-ext-enable xdebug \
     && apk del buildDeps autoconf gcc musl-dev make zlib-dev

# Install composer
RUN wget https://raw.githubusercontent.com/composer/getcomposer.org/863c57de1807c99d984f7b56f0ea56ebd7e5045b/web/installer -O - -q | php -- --quiet &&\
    mv composer.phar /usr/local/bin/composer && \
    composer self-update

# Install Laravel installer
USER www-data
RUN composer global require "laravel/installer"

ENV PATH="/home/www-data/.composer/vendor/bin:${PATH}"

WORKDIR /project