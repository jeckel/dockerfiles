FROM alpine:latest
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
    ln -s /usr/bin/php7 /usr/bin/php && \
# Installing composer
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php composer-setup.php && \
    php -r "unlink('composer-setup.php');" && \
    mv composer.phar /usr/local/bin/composer && \
# Fix sudo rights
    sed -i "s/root ALL=(ALL)/root ALL=(ALL:ALL)/g" /etc/sudoers

COPY composer.sh /usr/local/bin/composer.sh
RUN chmod +x /usr/local/bin/composer.sh

RUN if [ ! -e $COMPOSER_HOME ]; then \
    mkdir $COMPOSER_HOME ; \
    fi

# CLeanup
RUN rm -Rf /var/{cache,lib}/apk /etc/apk/cache

#RUN ln -s /usr/bin/php7 /usr/bin/php

VOLUME /project
WORKDIR /project

ENTRYPOINT ["composer.sh", "--ansi"]