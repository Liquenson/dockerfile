#!/bin/bash

# Define los nombres de los archivos y directorios necesarios
COMPOSE_FILE="docker-compose.yml"
PHP_DOCKERFILE="Dockerfile.php"
NGINX_DOCKERFILE="Dockerfile.nginx"

# Crear archivo docker-compose.yml
cat <<EOF > $COMPOSE_FILE
version: '3.8'

services:
  nginx:
    build:
      context: .
      dockerfile: $NGINX_DOCKERFILE
    ports:
      - "80:80"
    volumes:
      - ./html:/usr/share/nginx/html
    depends_on:
      - php

  php:
    build:
      context: .
      dockerfile: $PHP_DOCKERFILE
    volumes:
      - ./html:/var/www/html
    expose:
      - "9000"

  mysql:
    image: mysql:8.0
    environment:
      MYSQL_ROOT_PASSWORD: rootpassword
      MYSQL_DATABASE: mydatabase
      MYSQL_USER: user
      MYSQL_PASSWORD: userpassword
    ports:
      - "3306:3306"
EOF

# Crear Dockerfile para Nginx
cat <<EOF > $NGINX_DOCKERFILE
FROM nginx:alpine
COPY ./nginx.conf /etc/nginx/nginx.conf
EOF

# Crear Dockerfile para PHP
cat <<EOF > $PHP_DOCKERFILE
FROM php:7.4-fpm
RUN docker-php-ext-install mysqli
EOF

# Crear archivo de configuración de Nginx
cat <<EOF > nginx.conf
server {
    listen 80;
    root /usr/share/nginx/html;
    index index.php index.html index.htm;

    server_name localhost;

    location / {
        try_files \$uri \$uri/ =404;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass php:9000;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
        include fastcgi_params;
    }
}
EOF

# Crear directorio para la aplicación web
mkdir -p html

# Informar al usuario
echo "Arquitectura de Docker y archivos de configuración creados."

# Iniciar los servicios
docker-compose up -d

echo "Servicios de Docker iniciados."
