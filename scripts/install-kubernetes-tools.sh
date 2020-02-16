#!/usr/bin/env bash

set -o errexit
set -o nounset

echo "--> Install prerequisites"

sudo apt-get -y install \
  apt-transport-https \
  ca-certificates \
  curl \
  software-properties-common

echo "--> Add an apt signing key for Docker"

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

echo "--> Add apt repository for stable version"

sudo add-apt-repository \
  "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update -y

echo "--> Install docker and its dependecies"

sudo apt-get -y install \
  docker-ce \
  docker-ce-cli \
  containerd.io

echo "--> Setup Docker Daemon"

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

echo "--> Restart Docker"

sudo systemctl daemon-reload
sudo systemctl restart docker

echo "--> Add vagrant user to docker group"

sudo usermod -aG docker vagrant

echo "--> Add an apt signing key for Kubernetes"

curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

echo "--> Adding apt repository for Kubernetes"

sudo add-apt-repository \
  "deb https://apt.kubernetes.io/ kubernetes-$(lsb_release -cs) main"
sudo apt-get update

echo "--> Install Kubernetes binaries"

sudo apt-get -y install kubectl

echo "--> Install Skaffold"

curl -Lo skaffold https://storage.googleapis.com/skaffold/releases/latest/skaffold-linux-amd64
chmod +x skaffold
sudo mv skaffold /usr/local/bin

echo "--> Install Terraform"

sudo apt-get install unzip
wget https://releases.hashicorp.com/terraform/0.12.18/terraform_0.12.18_linux_amd64.zip
unzip terraform_0.12.18_linux_amd64.zip
rm -f terraform_0.12.18_linux_amd64.zip
sudo mv terraform /usr/local/bin/

echo "--> Install Helm"

curl -fsSL https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash