ARG DEFAULT_TAG=bullseye-slim
FROM debian:${DEFAULT_TAG}

RUN mkdir -p /debs && mkdir -p /iso-dir
WORKDIR /debs
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && \
    apt install -y genisoimage wget && \
    rm -rf /var/lib/apt/lists/*

RUN echo 'deb http://download.proxmox.com/debian/pve bullseye pve-no-subscription' > /etc/apt/sources.list.d/pve-no-subscription.list && \
    wget https://enterprise.proxmox.com/debian/proxmox-release-bullseye.gpg -O /etc/apt/trusted.gpg.d/proxmox-release-bullseye.gpg

COPY runme.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
