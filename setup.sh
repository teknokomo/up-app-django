#!/usr/bin/env bash

echo "=== Setting up Django 5.x ==="

# Активируем виртуальное окружение (опционально) или просто ставим глобально
# python3 -m venv venv
# source venv/bin/activate

echo "Устанавливаем Django 5.x (предполагается, что пакет доступен в PyPI)"
pip install --upgrade pip
pip install "Django==5.*"

echo "Создаём проект Django в текущей папке..."
django-admin startproject main .

echo "=== Django setup completed! ==="
