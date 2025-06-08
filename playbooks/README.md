# Плейбуки проекта

[![Ansible](https://img.shields.io/badge/Ansible-EE0000?style=for-the-badge&logo=ansible&logoColor=white)](https://www.ansible.com) [![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)](https://www.docker.com) [![NGINX](https://img.shields.io/badge/NGINX-009639?style=for-the-badge&logo=nginx&logoColor=white)](https://www.nginx.com) [![PHP](https://img.shields.io/badge/PHP-777BB4?style=for-the-badge&logo=php&logoColor=white)](https://www.php.net)

<!-- TOC tocDepth:2..3 chapterDepth:2..6 -->

- [Плейбуки проекта](#плейбуки-проекта)
  - [Описание](#описание)
  - [Структура развертывания](#структура-развертывания)
  - [Использование](#использование)
  - [Требования](#требования)
  - [Особенности работы](#особенности-работы)
  - [Дополнительная документация](#дополнительная-документация)

<!-- /TOC -->

## Описание

Основной playbook для развертывания веб-приложения с использованием стека технологий:
* `Docker` - контейнеризация сервисов
* `Nginx` - веб-сервер и reverse proxy
* `MySQL` - база данных
* `PHP` - выполнение PHP-кода

## Структура развертывания
Playbook последовательно выполняет три роли:
1. `preconfig`
  * Установка Docker и зависимостей
  * Настройка окружения
  * Подготовка пользователя
2. `nginx`
  * Конфигурация Nginx
  * Настройка работы с PHP-FPM
  * Подготовка proxy-правил
3. `docker_compose`
  * Развертывание контейнеров
  * Настройка сетей
  * Запуск приложения

## Использование

Для запуска playbook выполните команду: `ansible-playbook -i inventory playbook.yml`

## Требования

На управляемых узлах:
* Ubuntu/Debian
* Доступ в интернет или к прокси репозиториям для загрузки пакетов

На control node:
* Ansible 2.9+
* Настроенный inventory-файл
* SSH-доступ к целевым хостам

## Особенности работы

* Playbook выполняется последовательно (role-by-role)
* После добавления пользователя в группу docker требуется:
  * Перезапуск SSH-сессии
  * Повторный запуск playbook при необходимости

## Дополнительная документация

Подробнее о каждой роли:
* Роль [preconfig](./preconfig/) - начальная настройка сервера
* Роль [nginx](./nginx/) - конфигурация Nginx
* Роль [docker_compose](./docker_compose/) - развертывание приложения
