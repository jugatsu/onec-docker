# Веб-сервер

## Сборка

```bash
docker build \
  --build-arg ONEC_USERNAME=${ONEC_USERNAME} \
  --build-arg ONEC_PASSWORD=${ONEC_PASSWORD} \
  --build-arg ONEC_VERSION=${ONEC_VERSION} \
  -t ${DOCKER_USERNAME}/ws:%ONEC_VERSION% \
  -f ws/Dockerfile .
```

## Запуск

```bash
docker run --rm -it \
  -p 80:80/tcp \
  --domainname host.docker.internal \
  ${DOCKER_USERNAME}/ws:${ONEC_VERSION}
```

## Docker-compose

Пример запуска сразу с двумя публикациями: клиента и веб-сервиса.

```bash
  web:
    image: ${DOCKER_USERNAME}/ws:${ONEC_VERSION}
    domainname: host.docker.internal
    depends_on:
      - srv
    command: >
      bash -c "/opt/1C/v8.3/x86_64/webinst -apache24 -wsdir client -dir /var/www/client -descriptor /tmp/web/client/default.vrd -connstr 'Srvr=srv;Ref=gitlabServices;'
      && /opt/1C/v8.3/x86_64/webinst -apache24 -wsdir api -dir /var/www/api -descriptor /tmp/web/api/default.vrd -connstr 'Srvr=srv;Ref=gitlabServices;usr=site;pwd=12345'
      && /usr/sbin/apache2ctl -DFOREGROUND"
    ports:
      - "80:80"
    volumes:
      - srv_data:/home/usr1cv8/.1cv8
      - srv_log:/var/log/1C
      - ./web:/tmp/web
    networks:
      - back_net
```
