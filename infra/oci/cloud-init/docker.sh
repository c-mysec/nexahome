#!/bin/bash
set -eux

dnf update -y
dnf install -y dnf-utils git

# Use the Docker CE repo for CentOS/RHEL which is compatible with Oracle Linux 9
dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
dnf install -y docker-ce docker-ce-cli containerd.io

systemctl enable docker
systemctl start docker

usermod -aG docker opc

curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-linux-aarch64 \
  -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
