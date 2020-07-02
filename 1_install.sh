#!/bin/bash

# set swap memory off
swapoff -a

# package manage tool update
sudo apt update
sudo apt-get update

# prev docker version remove
sudo apt-get remove docker docker-engine docker.io

# docker support library install
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common -y

# get gpg key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# confirm gpg key
sudo apt-key fingerprint 0EBFCD88

# add docker download link to /etc/apt/source.list
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update

# install docker validate version ~v18.09
sudo apt-get install docker-ce=18.06.2~ce~3-0~ubuntu -y

# test docker container run
#sudo docker run hello-world

# change docker daemon driver
sudo cat > /etc/docker/daemon.json <<EOF
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
sudo systemctl daemon-reload
sudo systemctl restart docker

# kube installation
sudo apt-get update
sudo apt-get upgrade
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

# check kube version
kubeadm version
kubelet --version
kubectl version

# shutdown firewall
sudo ufw status verbose
sudo ufw disable
