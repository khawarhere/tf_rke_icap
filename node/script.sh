#!/bin/sh

#curl ${var.docker_install_url} | sh

#sudo apt-get remove docker docker-engine docker.io

sudo apt install docker.io

sudo systemctl start docker

sudo systemctl enable docker

docker --version

sudo usermod -a -G docker ubuntu

sudo chown ubuntu:docker /var/run/docker.sock

sudo newgrp docker

docker rm -f $(docker ps -qa)
docker volume rm $(docker volume ls -q)
cleanupdirs="/var/lib/etcd /etc/kubernetes /etc/cni /opt/cni /var/lib/cni /var/run/calico /opt/rke"
for dir in $cleanupdirs; do
  echo "Removing $dir"
  rm -rf $dir
done