FROM debian:buster-slim

RUN mkdir -p /debs && mkdir -p /iso-dir
WORKDIR /debs
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && \
    apt install -y genisoimage && \
    rm -rf /var/lib/apt/lists/*

COPY runme.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
