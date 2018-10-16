FROM node:alpine
ENV SRC_DIR="/project/src" DIST_DIR="/project/dist"

RUN apk add make && npm install -g html-minifier csso-cli uglify-js

WORKDIR /
ADD Makefile /

VOLUME /project

ENTRYPOINT make