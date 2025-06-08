# Хэндлеры проекта

[![Ansible](https://img.shields.io/badge/Ansible-EE0000?style=for-the-badge&logo=ansible&logoColor=white)](https://www.ansible.com) [![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)](https://www.docker.com) [![NGINX](https://img.shields.io/badge/NGINX-009639?style=for-the-badge&logo=nginx&logoColor=white)](https://www.nginx.com) [![PHP](https://img.shields.io/badge/PHP-777BB4?style=for-the-badge&logo=php&logoColor=white)](https://www.php.net)

<!-- TOC tocDepth:2..3 chapterDepth:2..6 -->

- [Хэндлеры проекта](#хэндлеры-проекта)
  - [Описание](#описание)
  - [Список обработчиков](#список-обработчиков)
    - [role\_compose.yml](#role_composeyml)
    - [role\_nginx.yaml](#role_nginxyaml)
    - [role\_preconfig.yaml](#role_preconfigyaml)
  - [Особенности работы обработчиков](#особенности-работы-обработчиков)
  - [Интеграция с ролями](#интеграция-с-ролями)

<!-- /TOC -->

## Описание

Директория `handlers` содержит обработчики для ролей Ansible, которые выполняют специфические действия в ответ на изменения в системе.

## Список обработчиков

### role_compose.yml
Назначение: Перезапуск контейнера `web` в `docker-compose`
Используется в Роли: `docker_compose`
Действие: Перезапустить контейнер web

### role_nginx.yaml
Назначение: Перезапуск контейнера `nginx`
Используется в Роли: `nginx`
Действие: Перезапустить Nginx в контейнере

### role_preconfig.yaml
Назначение: Перезапуск службы SSH
Используется в Роли: `preconfig`
Действие: Перезапуск службы SSH

## Особенности работы обработчиков

* Обработчики выполняются только при наличии изменений (notify в задачах)
* Даже при нескольких уведомлениях, обработчик выполняется один раз в конце playbook

Зависимости от переменных:
* `role_preconfig.yaml` зависит от `user_add_result.changed`
* `role_compose.yml` использует переменную `app_dir`

## Интеграция с ролями

Каждый обработчик связан с соответствующей ролью через:
* Импорт в `meta/main.yml` роли
* Уведомления (notify) в задачах роли