FROM codeception/codeception
MAINTAINER Jeckel <jeckel@jeckel.fr>

RUN apt-get update && \
    apt-get install --no-install-recommends -y sudo && \
    apt-get clean && rm -rf /var/{lib,cache}/apt

COPY codecept.sh /usr/local/bin/codecept.sh
RUN chmod +x /usr/local/bin/codecept.sh

ENTRYPOINT ["codecept.sh"]