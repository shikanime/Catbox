#!/usr/bin/env bash

set -o errexit
set -o nounset

echo "==> Install prerequisites"

sudo apt-get install -y \
  apt-transport-https \
  ca-certificates

echo "==> Add an APT signing key for Docker"

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

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

echo "==> Install Terraform"

sudo apt-get install -y unzip
wget https://releases.hashicorp.com/terraform/0.12.21/terraform_0.12.21_linux_amd64.zip
unzip terraform_0.12.21_linux_amd64.zip
rm -f terraform_0.12.21_linux_amd64.zip
sudo mv terraform /usr/local/bin/

echo "==> Install Helm"

curl -fsSL https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

echo "==> Install Kustomize"

curl -fsSL https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh | bash

echo "==> Install Google Cloud SDK"

echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
sudo apt-get update && sudo apt-get install google-cloud-sdk

sudo apt-get install -y \
  kubectl \
  google-cloud-sdk-skaffold
  google-cloud-sdk-cloud-build-local
