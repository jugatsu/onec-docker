ARG DOCKER_USERNAME
ARG ONEC_VERSION
FROM ${DOCKER_USERNAME}/onec:${ONEC_VERSION}-server
LABEL maintainer="Anton Kvashenkin <anton.jugatsu@gmail.com> (@jugatsu)"

ARG gui_ver=1.0.1
ARG gui_url=https://nuk-svk.ru/uploads/rac-gui

RUN set -xe \
  && apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      tk8.6 \
      tcl8.6 \
      tk \
      ca-certificates \
      wget \
  && rm -rf  \
    /var/lib/apt/lists/* \
    /var/cache/debconf \
  && wget $gui_url/rac_gui-"$gui_ver".deb \
  && dpkg -x rac_gui-$gui_ver.deb /tmp \
  && mv /tmp/usr/share/rac_gui /usr/share \
  && mv /tmp/usr/bin/racgui /usr/bin \
  && rm -f rac_gui-$gui_ver.deb

CMD ["racgui"]
