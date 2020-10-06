#!/bin/bash
#
# KETI CRD VERSION MIGRATION MANAGER INSTALL SCRIPT
# 

printf "\n ======================================================================\n"
printf "                KETI CRD VERSION MIGRATION MANAGER INSTALL\n"
printf "\n ======================================================================\n"

# Move temp directory
cd /tmp

# Set host name
printf " Set hostname: "
read hostname
echo "$hostname" > /etc/hostname

# set swap memory off
printf " Set swap memory off...\n"
swapoff -a

# package manage tool update
printf " Package manage tool updating...\n"
sudo apt update 

# prev docker version remove
printf " Remove previous docker installation...\n"
sudo apt-get -y remove docker docker-engine docker.io 

# docker support library install
printf " Install docker support library...\n"
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common -y 

# get gpg key
printf " Add docker gpg key...\n"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - 

# confirm gpg key
sudo apt-key fingerprint 0EBFCD88

# add docker download link to /etc/apt/source.list
printf " Add docker package download link in sources.list...\n"
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update 

# install docker validate version ~v18.09
printf " Installing docker...\n"
sudo apt-get install docker-ce=18.06.2~ce~3-0~ubuntu -y

# change docker daemon driver
printf " Change docker daemon driver...\n"
sudo cat > /etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "experimental": true,
  "storage-driver": "overlay2"
}
EOF

printf " Docker service restarting...\n"
sudo mkdir -p /etc/systemd/system/docker.service.d
sudo systemctl daemon-reload
sudo systemctl restart docker

# CRIU installation
#printf " Install CRIU...\n"
#printf " Select CRIU version\n"
#CRIU_VERSION="3.10"
#printf " 1. $CRIU_VERSION [Recommend]\n"
#printf " 2. Currently\n"
#printf " > "
#read selection
sudo apt-get update -q 
sudo apt install -qy --no-install-recommends build-essential pkg-config libnet-dev python-yaml libaio-dev libprotobuf-dev libprotobuf-c0-dev protobuf-c-compiler protobuf-compiler python-protobuf libnl-3-dev libcap-dev python-future
curl -O -sSL http://download.openvz.org/criu/criu-3.13.tar.bz2
tar xjf criu-3.13.tar.bz2 
cd criu-3.13
make
cp ./criu/criu /usr/local/bin
cd ..
sudo rm -rf criu-*
criu check


# kube installation
printf " Add google gpg key...\n"
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF

printf " Check additional package update...\n"
sudo apt update -y

K8S_VERSION="1.17.3"
printf " Install kubernetes...\n"
printf " Select kubernetes version\n"
printf " 1. $K8S_VERSION [Recommend]\n"
printf " 2. Currently\n"
printf " > "
read selection

if [ ${selection} == 1 ];then
	sudo apt-get install -y kubelet=1.17.3-00 kubeadm=1.17.3-00 kubectl=1.17.3-00 
elif [ ${selection} == 2 ];then
	sudo apt-get install -y kubelet kubeadm kubectl 
else
	printf " Invalid selection\n"
fi
sudo apt-mark hold kubelet kubeadm kubectl

# Add external IP to kubelet environment
printf " Add external IP to kubelet environment...\n"
printf " Input external IP address: "
read exipaddr
sudo echo "Environment=\"KUBELET_EXTRA_ARGS=--node-ip=$exipaddr\"" >> /etc/systemd/system/kubelet.service.d/10-kubeadm.conf

# Shutdown firewall
printf " Shutdown firewall...\n"
sudo ufw status verbose 
sudo ufw disable 

printf " Installation Success\n"
# check kube version
kubeadm version
kubelet --version
kubectl version
