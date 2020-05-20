#!/usr/bin/env bash

set -o errexit
set -o nounset

echo "==> Install prerequisites"

sudo apt-get install -y \
  apt-transport-https \
  ca-certificates

echo "==> Add an APT signing key for Docker"

curl -sSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

echo "==> Add APT repository for stable version"

sudo add-apt-repository \
  "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update -y

echo "==> Install docker and its dependecies"

sudo apt-get install -y \
  docker-ce \
  docker-ce-cli \
  containerd.io

echo "==> Setup Docker Daemon"

cat <<EOF | sudo tee -a /etc/docker/daemon.json
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF
sudo mkdir -p /etc/systemd/system/docker.service.d

echo "==> Restart Docker"

sudo systemctl daemon-reload
sudo systemctl restart docker

echo "==> Add vagrant user to docker group"

sudo usermod -aG docker $USER

echo "==> Add ASDF plugins"

asdf plugin add terraform
asdf plugin add helm
asdf plugin add kustomize
asdf install

echo "==> Install gcloud components"

curl https://sdk.cloud.google.com | bash
gcloud components install \
  beta \
  alpha \
  kubectl \
  skaffold \
  cloud-build-local \
  app-engine-python
