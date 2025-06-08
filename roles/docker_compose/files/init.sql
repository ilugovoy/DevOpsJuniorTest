USE database; -- Попытка выбрать базу данных. Если её нет, возникнет ошибка, но следующая инструкция это обработает.
CREATE TABLE IF NOT EXISTS app_table ( -- IF NOT EXISTS предотвратит ошибку, если таблица уже существует.
    id SERIAL PRIMARY KEY,
    content TEXT NOT NULL,
    status TEXT NOT NULL
);
