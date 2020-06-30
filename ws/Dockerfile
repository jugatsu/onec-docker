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

ARG onec_uid="2001"
ARG onec_gid="2001"

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

RUN sed -i 's/export APACHE_RUN_USER=www-data/export APACHE_RUN_USER=usr1cv8/g' /etc/apache2/envvars \
  && sed -i 's/export APACHE_RUN_GROUP=www-data/export APACHE_RUN_GROUP=grp1cv8/g' /etc/apache2/envvars

RUN groupadd -r grp1cv8 --gid=$onec_gid \
  && useradd -r -g grp1cv8 --uid=$onec_uid --home-dir=/home/usr1cv8 --shell=/bin/bash usr1cv8 \
  && mkdir -p /opt/1C/v8.3/x86_64/conf /home/usr1cv8/.1cv8 /var/log/1C \
  && chown -R usr1cv8:grp1cv8 /opt/1C /home/usr1cv8 /var/log/1C \
  && chmod g+rw /var/log/1C

VOLUME /home/usr1cv8/.1cv8/ /var/log/1C

COPY ./configs/server/rootfs/ /

STOPSIGNAL SIGWINCH

COPY ./ws/apache2-foreground /usr/local/bin/

RUN chmod 755 /usr/local/bin/apache2-foreground \
  && chmod +x /usr/local/bin/apache2-foreground

WORKDIR /var/www

EXPOSE 80

CMD ["apache2-foreground"]
