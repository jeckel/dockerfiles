FROM php:alpine
MAINTAINER Jeckel <jeckel@jeckel.fr>

RUN	apk update && \
    apk upgrade && \
    apk add --update --no-cache \
        sudo && \
# Fix sudo rights
    sed -i "s/root ALL=(ALL)/root ALL=(ALL:ALL)/g" /etc/sudoers

ADD https://phar.phpunit.de/phpunit.phar /usr/local/bin/phpunit

COPY launcher.sh /usr/local/bin/launcher.sh
RUN chmod +rx /usr/local/bin/launcher.sh \
    /usr/local/bin/phpunit

#RUN ln -s /usr/bin/php7 /usr/bin/php

# Cleanup
RUN rm -Rf /var/{cache,lib}/apk /etc/apk/cache

VOLUME /project
WORKDIR /project

ENTRYPOINT ["launcher.sh"]