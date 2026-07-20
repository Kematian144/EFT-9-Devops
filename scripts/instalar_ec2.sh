#!/usr/bin/env bash
set -e

# Actualiza Ubuntu e instala herramientas básicas.
sudo apt update
sudo apt upgrade -y
sudo apt install -y ca-certificates curl wget gnupg git fontconfig openjdk-21-jdk

# Instala Docker y Docker Compose desde el repositorio oficial.
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
sudo tee /etc/apt/sources.list.d/docker.sources > /dev/null <<DOCKER_REPO
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
DOCKER_REPO
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo usermod -aG docker "$USER"

# Instala Jenkins LTS.
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt update
sudo apt install -y jenkins
sudo systemctl enable --now docker
sudo systemctl enable --now jenkins

# Permite que Jenkins use Docker para levantar la API y MySQL.
sudo usermod -aG docker jenkins
sudo systemctl restart jenkins

echo "Instalación terminada. La base de datos se levantará con Docker Compose."
echo "Cierra y vuelve a abrir la sesión SSH."
echo "Clave inicial de Jenkins: sudo cat /var/lib/jenkins/secrets/initialAdminPassword"
