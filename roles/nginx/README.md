# Роль nginx

[![Ansible](https://img.shields.io/badge/Ansible-EE0000?style=for-the-badge&logo=ansible&logoColor=white)](https://www.ansible.com) [![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)](https://www.docker.com) [![NGINX](https://img.shields.io/badge/NGINX-009639?style=for-the-badge&logo=nginx&logoColor=white)](https://www.nginx.com)

<!-- TOC tocDepth:2..3 chapterDepth:2..6 -->

- [Роль nginx](#роль-nginx)
  - [Описание](#описание)
  - [Поддерживаемые платформы](#поддерживаемые-платформы)
  - [Требования](#требования)
  - [Переменные роли](#переменные-роли)
  - [Зависимости](#зависимости)
  - [Структура файлов](#структура-файлов)
  - [Основные задачи](#основные-задачи)
  - [Обработчики](#обработчики)
  - [Порты](#порты)
  - [Особенности](#особенности)

<!-- /TOC -->

## Описание

Роль `nginx` предназначена для настройки и обслуживания веб-сервера Nginx в контейнере Docker. Она автоматизирует процесс конфигурации Nginx и интеграции с PHP-FPM.

## Поддерживаемые платформы

* Linux (тестировалось на Ubuntu Server 24)

## Требования

* Ansible версии 2.9 или выше
* Docker и Docker Compose, установленные на целевом сервере
* Пользователь с правами на выполнение Docker-команд
* Роль preconfig (указана как зависимость)

## Переменные роли

Основные переменные роли можно найти в `defaults/main.yml`

Переменная | Значение по умолчанию | Описание
-----------|-----------------------|---------
nginx_user | nginx | Пользователь, от имени которого работает Nginx
nginx_worker_processes | auto | Количество worker-процессов Nginx
nginx_error_log | /var/log/nginx/error.log | Путь к файлу логов ошибок
nginx_error_log_level | notice | Уровень логирования ошибок
nginx_worker_connections | 1024 | Максимальное количество соединений на worker
nginx_log_format | Расширенный формат логов | Формат строк логов access.log
nginx_access_log | /var/log/nginx/access.log | Путь к файлу логов доступа
nginx_keepalive_timeout | 65 | Таймаут keepalive-соединений в секундах
nginx_listen_port | 80 | Порт, который слушает Nginx
nginx_server_name | localhost | Имя сервера (server_name)
nginx_document_root | /var/www/html | Корневая директория веб-сервера
nginx_index_files | index.php index.html index.htm | Файлы индекса по умолчанию
nginx_php_socket | web:9000 | Адрес сокета PHP-FPM (сервис:порт)

## Зависимости

Роль зависит от:
* `preconfig`

## Структура файлов

```text
nginx/
├── defaults/             # Файлы с переменными по умолчанию
│   └── main.yml
├── handlers/             # Обработчики
│   └── role_nginx.yml
├── meta/                 # Метаданные роли
│   └── main.yml
└── tasks/                # Основные задачи роли
    └── main.yml
```

## Основные задачи

* Копирование конфигурации Nginx
* Уведомление обработчика о необходимости перезапуска Nginx при изменении конфигурации

## Обработчики

Роль включает обработчик для перезапуска Nginx в контейнере при изменении конфигурации.

## Порты

**Основной порт Nginx**
* Управляется переменной: `nginx_listen_port`
* Nginx внутри контейнера слушает `80` порт (стандартный HTTP)
* На хосте он доступен через `8080`

**PHP-FPM**
* Управляется переменной: `nginx_php_socket` (по умолчанию `web:9000`)
* Nginx соединяется с PHP-FPM через сокет (контейнер web на порту `9000`)

## Особенности

* Настроены worker-процессы (auto) и соединения (1024) для эффективной работы под нагрузкой
* Реализован расширенный формат логов (`nginx_log_format`) с поддержкой `X-Forwarded-For`
* Роль предназначена для работы в контейнерах (использует сокет `PHP-FPM web:9000`)
* Все критичные параметры (порты, пути, логи) вынесены в переменные (`defaults/main.yml`)
* Поддерживается кастомный `server_name`, корневая директория и файлы индекса
* Nginx работает от пользователя nginx (изолированно)
* Логи ошибок и доступа разделены (`error.log` и `access.log`)
* При изменении конфига Nginx автоматически перезапускается через `handler`
* Зависит от роли `preconfig` (подготовка окружения)
* Готовая конфигурация для работы с PHP-FPM (FastCGI)
* Указание сокета через переменную `nginx_php_socket`
* Тестировалось с `Nginx 1.27.1` в Docker-контейнере
