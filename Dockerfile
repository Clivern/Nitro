FROM ubuntu:22.04

ARG APP_VERSION=1.0.0

RUN mkdir -p /app/configs
RUN mkdir -p /app/var/logs
RUN apt-get update
RUN apt-get install curl -y

WORKDIR /app

RUN curl -sL https://github.com/Clivern/copper/releases/download/v${APP_VERSION}/copper_${APP_VERSION}_Linux_x86_64.tar.gz | tar xz
RUN rm LICENSE
RUN rm README.md

COPY ./config.dist.yml /app/configs/

EXPOSE 8000

VOLUME /app/configs
VOLUME /app/var

RUN ./copper version

CMD ["./copper", "server", "-c", "/app/configs/config.dist.yml"]
