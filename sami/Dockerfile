FROM php:7-cli-alpine
LABEL maintainer="Julien Mercier <julien@jeckel-lab.fr>"

RUN wget http://get.sensiolabs.org/sami.phar -O /usr/local/bin/sami && \
    chmod +x /usr/local/bin/sami

COPY php.ini /usr/local/etc/php/

ENTRYPOINT [ "sami" ]
WORKDIR /build