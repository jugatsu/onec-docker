ARG DOCKER_USERNAME=library
ARG BASE_IMAGE=adoptopenjdk
ARG DOCKER_TAG=14-hotspot

FROM ${DOCKER_USERNAME}/${BASE_IMAGE}:${DOCKER_TAG}

ARG ONEC_USERNAME
ARG ONEC_PASSWORD
ARG ONEC_VERSION=2020.2

ENV installer_type=edt

COPY ./scripts/download.sh /download.sh

WORKDIR /tmp

RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
    curl \
  && rm -rf  \
    /var/lib/apt/lists/* \
    /var/cache/debconf \
    /tmp/*

RUN chmod +x /download.sh \
  && sync; /download.sh \
  && for file in *.tar.gz; do tar -zxf "$file"; done \
  && rm -rf *.tar.gz \
  && ./1ce-installer-cli install all --ignore-hardware-checks \
  && rm -rf /tmp \
  && mv $(dirname $(find /opt/1C/1CE -name ring)) /opt/1C/1CE/components/1c-enterprise-ring

ENV PATH="/opt/1C/1CE/components/1c-enterprise-ring:$PATH"
