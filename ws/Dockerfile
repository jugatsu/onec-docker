FROM alpine:latest as downloader

ARG ONEC_USERNAME
ARG ONEC_PASSWORD
ARG ONEC_VERSION
ENV installer_type=server

COPY ./scripts/download.sh /download.sh

WORKDIR /tmp

RUN apk --no-cache add bash curl grep \
  && chmod +x /download.sh \
  && sync; /download.sh \
  && for file in *.tar.gz; do tar -zxf "$file"; done \
  && rm -rf *.tar.gz

FROM debian:stretch-slim as base

ARG gosu_ver=1.11
ARG nls_enabled=false
ENV nls=$nls_enabled

COPY --from=downloader /tmp/*.deb /tmp/

WORKDIR /tmp

SHELL ["/bin/bash", "-c"]
RUN set -xe; \
  if [ "$nls" = true ]; then \
    dpkg -i 1c-enterprise83-{common,server,ws}*.deb; \
  else \
    dpkg -i 1c-enterprise83-{common,server,ws}_*.deb; \
  fi

ADD https://github.com/tianon/gosu/releases/download/$gosu_ver/gosu-amd64 /bin/gosu

RUN chmod +x /bin/gosu

FROM debian:stretch-slim
LABEL maintainers="Anton Kvashenkin <anton.jugatsu@gmail.com>, Alexander Strizhachuk <a.strizhachuk@yandex.ru>"

ARG onec_uid="999"
ARG onec_gid="999"

COPY --from=base /opt /opt
COPY --from=base /bin/gosu /bin/gosu

RUN set -xe \
  && apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      locales \
      imagemagick \
      fontconfig \
      apache2 \
  && rm -rf \
    /var/lib/apt/lists/* \
    /var/cache/debconf \
  && localedef -i ru_RU -c -f UTF-8 -A /usr/share/locale/locale.alias ru_RU.UTF-8
ENV LANG ru_RU.UTF-8

RUN groupadd -r grp1cv8 --gid=$onec_gid \
  && useradd -r -g grp1cv8 --uid=$onec_uid --home-dir=/home/usr1cv8 --shell=/bin/bash usr1cv8 \
  && mkdir -p /var/log/1C /home/usr1cv8/.1cv8/1C/1cv8/conf \
  && chown -R usr1cv8:grp1cv8 /var/log/1C /home/usr1cv8

VOLUME /home/usr1cv8/.1cv8/ /var/log/1C

COPY ./server/logcfg.xml /home/usr1cv8/.1cv8/1C/1cv8/conf

STOPSIGNAL SIGWINCH

COPY ./ws/apache2-foreground /usr/local/bin/
WORKDIR /var/www/html

EXPOSE 80
CMD ["apache2-foreground"]
