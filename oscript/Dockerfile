ARG DOCKER_USERNAME
ARG ONEC_VERSION
FROM ${DOCKER_USERNAME}/onec-client:${ONEC_VERSION} as base

FROM mono:5.20-slim
LABEL maintainer="Anton Kvashenkin <anton.jugatsu@gmail.com> (@jugatsu)"

ARG onescript_ver=1.0.21

COPY --from=base /opt /opt

ADD https://github.com/just-containers/s6-overlay/releases/download/v1.21.8.0/s6-overlay-amd64.tar.gz /tmp/

SHELL ["/bin/bash", "-c"]
RUN echo "deb http://http.debian.net/debian/ stretch main contrib non-free" > /etc/apt/sources.list \
  && echo "deb http://http.debian.net/debian/ stretch-updates main contrib non-free" >> /etc/apt/sources.list \
  && echo "deb http://security.debian.org/ stretch/updates main contrib non-free" >> /etc/apt/sources.list \
  && echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections \
  && apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      ca-certificates \
      curl \
      locales \
      libwebkitgtk-3.0-0 \
      ttf-mscorefonts-installer \
      libfontconfig1 \
      libgsf-1-114 \
      libglib2.0-0 \
      libodbc1 \
      libmagickwand-6.q16-3 \
      dbus-x11 \
      at-spi2-core \
      procps \
      xvfb \
      x11vnc \
      libmono-i18n4.0-all \
  && rm -rf  \
    /var/lib/apt/lists/* \
    /var/cache/debconf \
  && curl -L http://oscript.io/downloads/${onescript_ver//./_}/onescript-engine_"$onescript_ver"_all.deb -o onescript-engine.deb \
  && dpkg -i onescript-engine.deb \
  && rm -f onescript-engine.deb \
  && localedef -i ru_RU -c -f UTF-8 -A /usr/share/locale/locale.alias ru_RU.UTF-8
ENV LANG ru_RU.UTF-8

RUN tar xzf /tmp/s6-overlay-amd64.tar.gz -C / \
  && rm -rf /tmp/s6-overlay-amd64.tar.gz

RUN groupadd -r usr1cv8 --gid=2001 \
  && useradd -r -g usr1cv8 --uid=2001 --home-dir=/home/usr1cv8 --shell=/sbin/nologin usr1cv8 \
  && mkdir -p /home/usr1cv8/.1cv8 \
  && mkdir -p /home/usr1cv8/.1C/1cestart \
  && chown -R usr1cv8:usr1cv8 /home/usr1cv8

COPY ./configs/client-vnc/rootfs/ /

ENV DISPLAY=:0
ENV DISPLAY_WIDTH=1440
ENV DISPLAY_HEIGHT=900

ENTRYPOINT ["/init"]
