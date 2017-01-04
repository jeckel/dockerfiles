FROM alpine:latest
MAINTAINER Jeckel <jeckel@jeckel.fr>

ENV COMPOSER_HOME /composer-cache-dir

RUN	apk update && \
    apk upgrade && \
    apk add --update --no-cache \
        php5-cli \
        php5-openssl \
        php5-curl \
        php5-phar \
        php5-json \
        php5-zlib \
        git \
        sudo && \
# Installing composer
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php composer-setup.php && \
    php -r "unlink('composer-setup.php');" && \
    mv composer.phar /usr/local/bin/composer && \
# Fix sudo rights
    sed -i "s/root ALL=(ALL)/root ALL=(ALL:ALL)/g" /etc/sudoers

COPY composer.sh /usr/local/bin/composer.sh
RUN chmod +x /usr/local/bin/composer.sh

RUN if [ ! -e $COMPOER_HOME ]; then \
    mkdir $COMPOSER_HOME ; \
    fi

VOLUME /project
WORKDIR /project

ENTRYPOINT ["composer.sh", "--ansi"]