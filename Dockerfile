FROM debian:buster-slim

RUN mkdir -p /debs && mkdir -p /iso-dir
WORKDIR /debs
ENV DEBIAN_FRONTEND=noninteractive
ENV PACKAGES_TO_INSTALL="lldpd ifenslave net-tools"

RUN apt update && \
    apt install -y genisoimage && \
    rm -rf /var/lib/apt/lists/*

# RUN apt update && \
#     # chown -Rv _apt:root ./ &&  \
#     apt-get download \
#       $(apt-cache depends --recurse --no-recommends --no-suggests --no-conflicts \
#         --no-breaks --no-replaces --no-enhances --no-pre-depends ${PACKAGES_TO_INSTALL} |grep "^\w") && \
#     apt install -y genisoimage     

# RUN ls -alh

COPY runme.sh /runme.sh
VOLUME /iso-dir

CMD ["/runme.sh"]
