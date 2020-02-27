FROM debian:stretch

LABEL maintainer="yannik@korzikowski.de"

VOLUME /config /input

ADD send-attachments.sh /opt/send-attachments.sh

# install packages
RUN apt-get update && apt-get install -y ssmtp sharutils cron mpack

RUN touch /var/log/send-attachments.log

ADD docker-entrypoint.sh /opt/docker-entrypoint.sh
ENTRYPOINT ["/opt/docker-entrypoint.sh"]
CMD ["cron"]

