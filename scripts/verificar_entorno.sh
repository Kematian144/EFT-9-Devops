#!/usr/bin/env bash

echo "Java:"
java -version

echo "Docker:"
docker --version
docker compose version

echo "Jenkins:"
systemctl is-active jenkins

echo "Contenedores:"
docker compose ps

echo "Puertos principales:"
sudo ss -lntp | grep -E ':8080|:8081|:3306' || true
