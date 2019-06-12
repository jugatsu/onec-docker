# Описание

[![forthebadge](http://forthebadge.com/images/badges/built-with-love.svg)](http://forthebadge.com)

В данном репозитории находятся файлы для сборки образов [Docker](https://www.docker.com) с платформой [1С:Предприятие](http://v8.1c.ru) 8.3.

> Скрипт скачивания платформы позаимствован отсюда https://github.com/Infactum/onec_dock/blob/master/download.sh :+1:

# Использование

В терминале введите:

```bash
$ cp .onec.env.example .onec.env
```

Скорректируйте файл `.onec.env` в соответствии со своим окружением:

* ONEC_USERNAME - учётная запись на http://releases.1c.ru
* ONEC_PASSWORD - пароль для учётной записи на http://releases.1c.ru
* ONEC_VERSION - версия платформы 1С:Преприятия 8.3, которая будет в образе
* DOCKER_USERNAME - учётная запись на [Docker Hub](https://hub.docker.com)

Затем экспортируйте все необходимые переменные:

```bash
$ eval $(cat .onec.env)
```

## Как сбилдить образы

:point_up: Введите в терминале команду `docker build` из соответствующей секции.

:tada: Или, если установлен `make`, досточно команды `make all`.

## Как запустить в docker-compose
:exclamation: тестировалось только на macOS Mojave и Ubuntu 16.04/18.04

```bash
$ cp .env.example .env
# подправьте файл .env под себя
$ docker-compose up -d
```

# Оглавление

- [Сервер](#сервер)
- [Сервер с дополнительными языками](#Сервер-с-дополнительными-языками)
- [Клиент](#support)
- [Клиент с поддержкой VNC](#support)
- [Клиент с дополнительными языками](#support)
- [Тонкий клиент](#support)
- [Тонкий клиент с дополнительными языками](#support)
- [Хранилище конфигурации](#contributing)
- [rac-gui](#license)
- [gitsync](#license)
- [oscript](#license)
- [vanessa-runner](#license)

## Сервер
[(Наверх)](#Оглавление)

```bash
docker build --build-arg ONEC_USERNAME=${ONEC_USERNAME} \
  --build-arg ONEC_PASSWORD=${ONEC_PASSWORD} \
  --build-arg ONEC_VERSION=${ONEC_VERSION} \
  -t ${DOCKER_USERNAME}/onec-server:${ONEC_VERSION} \
  -f server/Dockerfile .
```

## Сервер с дополнительными языками
[(Наверх)](#Оглавление)

```bash
docker build --build-arg ONEC_USERNAME=${ONEC_USERNAME} \
  --build-arg ONEC_PASSWORD=${ONEC_PASSWORD} \
  --build-arg ONEC_VERSION=${ONEC_VERSION} \
  --build-arg nls_enabled=true \
  -t ${DOCKER_USERNAME}/onec-server-nls:${ONEC_VERSION} \
  -f server/Dockerfile .
```

## Клиент
[(Наверх)](#Оглавление)

```bash
docker build --build-arg ONEC_USERNAME=${ONEC_USERNAME} \
  --build-arg ONEC_PASSWORD=${ONEC_PASSWORD} \
  --build-arg ONEC_VERSION=${ONEC_VERSION} \
  -t ${DOCKER_USERNAME}/onec-client:${ONEC_VERSION} \
  -f client/Dockerfile .
```

## Клиент с поддержкой VNC
[(Наверх)](#Оглавление)

```bash
docker build --build-arg DOCKER_USERNAME=${DOCKER_USERNAME} \
  --build-arg ONEC_VERSION=${ONEC_VERSION} \
  -t ${DOCKER_USERNAME}/onec-client-vnc:${ONEC_VERSION} \
  -f client-vnc/Dockerfile .
```

## Клиент с дополнительными языками
[(Наверх)](#Оглавление)

```bash
docker build --build-arg ONEC_USERNAME=${ONEC_USERNAME} \
  --build-arg ONEC_PASSWORD=${ONEC_PASSWORD} \
  --build-arg ONEC_VERSION=${ONEC_VERSION} \
  --build-arg nls_enabled=true \
  -t ${DOCKER_USERNAME}/onec-client-nls:${ONEC_VERSION} \
  -f client/Dockerfile .
```

## Тонкий клиент
[(Наверх)](#Оглавление)

```bash
docker build --build-arg ONEC_USERNAME=${ONEC_USERNAME} \
  --build-arg ONEC_PASSWORD=${ONEC_PASSWORD} \
  --build-arg ONEC_VERSION=${ONEC_VERSION} \
  -t ${DOCKER_USERNAME}/onec-thin-client:${ONEC_VERSION} \
  -f thin-client/Dockerfile .
```

## Тонкий клиент с дополнительными языками
[(Наверх)](#Оглавление)

```bash
docker build --build-arg ONEC_USERNAME=${ONEC_USERNAME} \
  --build-arg ONEC_PASSWORD=${ONEC_PASSWORD} \
  --build-arg ONEC_VERSION=${ONEC_VERSION} \
  --build-arg nls_enabled=true \
  -t ${DOCKER_USERNAME}/onec-thin-client-nls:${ONEC_VERSION} \
  -f thin-client/Dockerfile .
```

## Хранилище конфигурации
[(Наверх)](#Оглавление)

```bash
docker build --build-arg ONEC_USERNAME=${ONEC_USERNAME} \
  --build-arg ONEC_PASSWORD=${ONEC_PASSWORD} \
  --build-arg ONEC_VERSION=${ONEC_VERSION} \
  -t ${DOCKER_USERNAME}/onec-crs:${ONEC_VERSION} \
  -f crs/Dockerfile .
```

## rac-gui
[(Наверх)](#Оглавление)

```bash
docker build --build-arg DOCKER_USERNAME=${DOCKER_USERNAME} \
  --build-arg ONEC_VERSION=${ONEC_VERSION} \
  -t ${DOCKER_USERNAME}/onec-rac-gui:${ONEC_VERSION}-1.0.1 \
  -f rac-gui/Dockerfile .
```

## gitsync
[(Наверх)](#Оглавление)

```bash
docker build --build-arg DOCKER_USERNAME=${DOCKER_USERNAME} \
  --build-arg ONEC_VERSION=${ONEC_VERSION} \
  -t ${DOCKER_USERNAME}/gitsync:3.0.0 \
  -f gitsync/Dockerfile .
```

## oscript
[(Наверх)](#Оглавление)

```bash
docker build --build-arg DOCKER_USERNAME=${DOCKER_USERNAME} \
  --build-arg ONEC_VERSION=${ONEC_VERSION} \
  -t ${DOCKER_USERNAME}/oscript:1.0.21 \
  -f oscript/Dockerfile .
```

## vanessa-runner
[(Наверх)](#Оглавление)

```bash
docker build --build-arg DOCKER_USERNAME=${DOCKER_USERNAME} \
  -t ${DOCKER_USERNAME}/runner:1.7.0 \
  -f vanessa-runner/Dockerfile .
```
