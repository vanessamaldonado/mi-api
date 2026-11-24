#!/bin/bash
# Script de despliegue de mi-api
set -e

echo "==> Construyendo la imagen..."
docker build -t mi-api .

echo "==> Eliminando los contenedores anteriores..."
docker rm -f api1 api2 2>/dev/null || true

echo "==> Arrancando los contenedores..."
docker run -d --name api1 --restart unless-stopped \
    -e NOMBRE_SERVIDOR=api1 -p 127.0.0.1:5000:3000 mi-api

docker run -d --name api2 --restart unless-stopped \
    -e NOMBRE_SERVIDOR=api2 -p 127.0.0.1:5001:3000 mi-api

echo "==> Publicando el frontend..."
sudo mkdir -p /var/www/mi-api
sudo cp -r public/* /var/www/mi-api/

echo "==> Despliegue completado"
docker ps
