FROM debian:stretch

LABEL maintainer="yannik@korzikowski.de"

ARG UID=1000

RUN apt-get update && apt-get install -y ssmtp sharutils cron mpack

RUN adduser --uid $UID --disabled-password --disabled-login --gecos "" --home /app pdf

VOLUME /config /input

RUN mkdir /log && chown -R pdf:pdf /log
ADD docker-entrypoint.sh /app/docker-entrypoint.sh
ADD send-attachments.sh /app/send-attachments.sh

WORKDIR /app

RUN chown -R pdf:pdf .

USER pdf

ENTRYPOINT ["/app/docker-entrypoint.sh"]
CMD ["cron"]

