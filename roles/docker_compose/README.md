# Роль docker_compose

[![Ansible](https://img.shields.io/badge/Ansible-EE0000?style=for-the-badge&logo=ansible&logoColor=white)](https://www.ansible.com) [![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)](https://www.docker.com) [![Compose](https://img.shields.io/badge/Docker_Compose-2496ED?style=for-the-badge&logo=docker&logoColor=white)](https://docs.docker.com/compose/)
[![NGINX](https://img.shields.io/badge/NGINX-009639?style=for-the-badge&logo=nginx&logoColor=white)](https://www.nginx.com) [![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white)](https://www.mysql.com) [![PHP](https://img.shields.io/badge/PHP-777BB4?style=for-the-badge&logo=php&logoColor=white)](https://www.php.net)

<!-- TOC tocDepth:2..3 chapterDepth:2..6 -->

- [Роль docker\_compose](#роль-docker_compose)
  - [Описание](#описание)
  - [Поддерживаемые платформы](#поддерживаемые-платформы)
  - [Требования](#требования)
  - [Переменные роли](#переменные-роли)
  - [Зависимости](#зависимости)
  - [Структура файлов](#структура-файлов)
  - [Основные задачи](#основные-задачи)
  - [Порты](#порты)
  - [Особенности](#особенности)

<!-- /TOC -->

## Описание

Роль `docker_compose` предназначена для развертывания веб-приложения с использованием Docker Compose. Она автоматизирует процесс копирования необходимых файлов на сервер и запуска контейнеров.

## Поддерживаемые платформы

* Linux (тестировалось на Ubuntu Server 24)

## Требования

* Ansible версии 2.9 или выше
* Docker и Docker Compose, установленные на целевом сервере
* Пользователь с правами на выполнение Docker-команд

## Переменные роли

Основные переменные роли можно найти в `defaults/main.yml`

Переменная | Значение по умолчанию | Описание
-----------|-----------------------|---------
docker_compose_service_name | web | Определяет имя основного сервиса в docker-compose, который: используется для уведомлений и перезапуска (например, при изменении файлов) и позволяет адаптировать роль для разных проектов без изменения задач


## Зависимости

Роль зависит от:
* `preconfig`
* `nginx`

## Структура файлов

```text
docker_compose/
├── defaults/                   # Файлы с переменными по умолчанию
│   └── main.yml
├── files/                      # Статические файлы для копирования
│   └── docker-compose.yml
├── handlers/                   # Обработчики
│   └── role_compose.yml
├── meta/                       # Метаданные роли
│   └── main.yml
├── src/                        # Исходный код приложения
│   └── index.php
└── tasks/                      # Основные задачи роли
    └── main.yml
```

## Основные задачи

Роль развертывает три сервиса:
* web - PHP-приложение (собирается из Dockerfile)
* db - MySQL 5.7
* nginx - Nginx 1.27.1 в качестве обратного прокси

## Порты

* Nginx доступен на порту 8080 хоста
* Внутренние порты:
  * PHP-FPM: 9000
  * MySQL: 3306

## Особенности
* Используются две раздельные Docker сети: `frontend-net` и `backend-net`
* Для MySQL настроен healthcheck
* Исходный код PHP-приложения монтируется как volume
* Приложение автоматически перезагружается при изменении исходного кода
* База данных инициализируется скриптом `init.sql`
