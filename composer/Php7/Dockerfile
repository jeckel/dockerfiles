FROM php:7-cli
MAINTAINER Jeckel <jeckel@jeckel.fr>

ENV DEBIAN_FRONTEND noninteractive
ENV COMPOSER_HOME /composer-cache-dir

RUN apt-get update && \
    apt-get install -y git unzip sudo && \
    rm -rf /var/lib/apt/lists/*

# Installing composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php composer-setup.php && \
    php -r "unlink('composer-setup.php');" && \
    mv composer.phar /usr/local/bin/composer

COPY composer.sh /usr/local/bin/composer.sh
RUN chmod +x /usr/local/bin/composer.sh

RUN if [ ! -e $COMPOER_HOME ]; then \
    mkdir $COMPOSER_HOME ; \
    fi

VOLUME /project
WORKDIR /project

ENTRYPOINT ["composer.sh", "--ansi"]