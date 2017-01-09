FROM alpine:latest
MAINTAINER Jeckel <jeckel@jeckel.fr>

ENV PHPCS_CODING_STANDARD=PSR2
ENV PHPCS_IGNORE=vendor/,tests/_support/
ENV PHPCS_FILE_PATTERN="\.(php)$"
ENV PHPCS_IGNORE_WARNINGS=1
ENV PHPCS_ENCODING=utf-8

RUN	apk update && \
    apk upgrade && \
    apk add --update --no-cache \
        curl \
        php7 \
        php7-phar \
        php7-ctype \
        php7-zlib && \
    ln -s /usr/bin/php7 /usr/bin/php && \
    curl -OL https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar && \
    mv phpcs.phar /usr/local/bin/phpcs && \
    chmod +x /usr/local/bin/phpcs && \
    apk del --purge curl

COPY phpcs.sh /usr/local/bin/phpcs.sh
RUN chmod +x /usr/local/bin/phpcs.sh

VOLUME /project
WORKDIR /project

ENTRYPOINT ["phpcs.sh"]