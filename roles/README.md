# Роли проекта

[![Ansible](https://img.shields.io/badge/Ansible-EE0000?style=for-the-badge&logo=ansible&logoColor=white)](https://www.ansible.com) [![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)](https://www.docker.com) [![NGINX](https://img.shields.io/badge/NGINX-009639?style=for-the-badge&logo=nginx&logoColor=white)](https://www.nginx.com) [![PHP](https://img.shields.io/badge/PHP-777BB4?style=for-the-badge&logo=php&logoColor=white)](https://www.php.net)

<!-- TOC tocDepth:2..3 chapterDepth:2..6 -->

- [Роли проекта](#роли-проекта)
  - [Описание](#описание)
  - [Структура ролей](#структура-ролей)
  - [Взаимосвязь ролей](#взаимосвязь-ролей)
  - [Подробная документация](#подробная-документация)
  - [Требования](#требования)

<!-- /TOC -->

## Описание

Эта директория содержит набор ролей Ansible для развертывания веб-приложения с использованием Docker, Nginx и PHP. Роли предназначены для автоматизации процесса настройки сервера и развертывания приложения.

## Структура ролей

```text
roles/
├── docker_compose/        # Роль для развертывания приложения через Docker Compose
├── nginx/                 # Роль для настройки Nginx в контейнере
└── preconfig/             # Роль для первоначальной настройки сервера
```

## Взаимосвязь ролей

Роли используются в следующем порядке:
1. `preconfig` - подготовка сервера (установка Docker, Nginx, PHP)
2. `nginx` - настройка веб-сервера
3. `docker_compose` - развертывание приложения

## Подробная документация

Для получения подробной информации о каждой роли перейдите по ссылкам:
* Роль [preconfig](./preconfig/) - начальная настройка сервера
* Роль [nginx](./nginx/) - конфигурация Nginx
* Роль [docker_compose](./docker_compose/) - развертывание приложения

## Требования

* Ansible версии 2.9 или выше
* Ubuntu Server (тестировалось на версии 24.04)
* Доступ к интернету или прокси-репозиториям для загрузки пакетов