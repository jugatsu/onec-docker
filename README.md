# Описание

[![forthebadge](http://forthebadge.com/images/badges/built-with-love.svg)](http://forthebadge.com)

В данном репозитории находятся файлы для сборки образов [1С:Преприятия 8.3](http://v8.1c.ru) для [Docker](https://www.docker.com).

> Скрипт скачивания платформы позаимствован отсюда https://github.com/Infactum/onec_dock/blob/master/download.sh :+1:

# Использование

В терминале введите:

```bash
$ cp .onec.env.example .onec.env
```

Скорректируйте файл `.onec.env` в соответствии со своим окружение.

* ONEC_USERNAME - учётная запись на http://releases.1c.ru
* ONEC_PASSWORD - пароль для учётной записи на http://releases.1c.ru
* ONEC_VERSION - версия платформы 1С:Преприятия 8.3, которая будет в образе
* DOCKER_USERNAME - учетная запись на [Docker Hub](https://hub.docker.com)

Затем экспортируйте все необходимые переменные:

```bash
$ eval $(cat .onec.env)
```

# Оглавление

- [Сервер](#сервер)
- [Сервер с дополнительными языками](#Сервер-с-дополнительными-языками)
- [Клиент](#support)
- [Клиент с дополнительными языками](#support)
- [Тонкий клиент](#support)
- [Тонкий клиент с дополнительными языками](#support)
- [Хранилище конфигурации](#contributing)
- [rac-gui](#license)
- [gitsync](#license)

:point_up: Введите в терминале команду `docker build` из соответствующего параграфа

## Сервер
[(Back to top)](#Оглавление)

```bash
docker build --build-arg ONEC_USERNAME=${ONEC_USERNAME} \
  --build-arg ONEC_PASSWORD=${ONEC_PASSWORD} \
  --build-arg ONEC_VERSION=${ONEC_VERSION} \
  -t ${DOCKER_USERNAME}/onec:${ONEC_VERSION}-server \
  -f server/Dockerfile .
```

## Сервер с дополнительными языками
[(Back to top)](#Оглавление)

```bash
docker build --build-arg ONEC_USERNAME=${ONEC_USERNAME} \
  --build-arg ONEC_PASSWORD=${ONEC_PASSWORD} \
  --build-arg ONEC_VERSION=${ONEC_VERSION} \
  --build-arg nls_enabled=true
  -t ${DOCKER_USERNAME}/onec:${ONEC_VERSION}-server \
  -f server/Dockerfile .
```

## Клиент
[(Back to top)](#Оглавление)

```bash
docker build --build-arg ONEC_USERNAME=${ONEC_USERNAME} \
  --build-arg ONEC_PASSWORD=${ONEC_PASSWORD} \
  --build-arg ONEC_VERSION=${ONEC_VERSION} \
  -t ${DOCKER_USERNAME}/onec:${ONEC_VERSION}-client \
  -f client/Dockerfile .
```

## Клиент с дополнительными языками
[(Back to top)](#Оглавление)

```bash
docker build --build-arg ONEC_USERNAME=${ONEC_USERNAME} \
  --build-arg ONEC_PASSWORD=${ONEC_PASSWORD} \
  --build-arg ONEC_VERSION=${ONEC_VERSION} \
  --build-arg nls_enabled=true \
  -t ${DOCKER_USERNAME}/onec:${ONEC_VERSION}-client \
  -f client/Dockerfile .
```

## Тонкий клиент
[(Back to top)](#Оглавление)

```bash
docker build --build-arg ONEC_USERNAME=${ONEC_USERNAME} \
  --build-arg ONEC_PASSWORD=${ONEC_PASSWORD} \
  --build-arg ONEC_VERSION=${ONEC_VERSION} \
  -t ${DOCKER_USERNAME}/onec:${ONEC_VERSION}-thin-client \
  -f thin-client/Dockerfile .
```

## Тонкий клиент с дополнительными языками
[(Back to top)](#Оглавление)

```bash
docker build --build-arg ONEC_USERNAME=${ONEC_USERNAME} \
  --build-arg ONEC_PASSWORD=${ONEC_PASSWORD} \
  --build-arg ONEC_VERSION=${ONEC_VERSION} \
  --build-arg nls_enabled=true \
  -t ${DOCKER_USERNAME}/onec:${ONEC_VERSION}-thin-client \
  -f thin-client/Dockerfile .
```

## Хранилище конфигурации
[(Back to top)](#Оглавление)

```bash
docker build --build-arg ONEC_USERNAME=${ONEC_USERNAME} \
  --build-arg ONEC_PASSWORD=${ONEC_PASSWORD} \
  --build-arg ONEC_VERSION=${ONEC_VERSION} \
  -t ${DOCKER_USERNAME}/onec:${ONEC_VERSION}-crs \
  -f crs/Dockerfile .
```

## rac-gui
[(Back to top)](#Оглавление)

```bash
docker build --build-arg DOCKER_USERNAME=${DOCKER_USERNAME} \
  --build-arg ONEC_VERSION=${ONEC_VERSION} \
  -t ${DOCKER_USERNAME}/onec:${ONEC_VERSION}-rac-gui \
  -f rac-gui/Dockerfile .
```

## gitsync
[(Back to top)](#Оглавление)

```bash
docker build --build-arg DOCKER_USERNAME=${DOCKER_USERNAME} \
  --build-arg ONEC_VERSION=${ONEC_VERSION} \
  -t ${DOCKER_USERNAME}/gitsync:3.0.0 \
  -f gitsync/Dockerfile .
```
