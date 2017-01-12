FROM node:4.4.3
MAINTAINER Jeckel <jeckel@jeckel.fr>


COPY app /usr/src/app

WORKDIR /usr/src/app
RUN npm install

EXPOSE 1883
ENTRYPOINT node
CMD ["server.js"]