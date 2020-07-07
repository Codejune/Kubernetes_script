#!/bin/bash
#
# KETI CRD VERSION MIGRATION MANAGER MASTER INSTALL SCRIPT
# 

printf "\n ======================================================================\n"
printf "              KETI CRD VERSION MIGRATION MANAGER MASTER SETTING\n"
printf "\n ======================================================================\n"

# Regist CNI to IP table
printf " Regist CNI to IP table...\n"
sudo sysctl net.bridge.bridge-nf-call-iptables=1
#sudo echo 1 > /proc/sys/net/ipv4/ip_forward

# init pod network & set api-server address
printf " Input network CIDR [ex. 192.168.0.0/16]: "
read networkcidr
sudo kubeadm init --pod-network-cidr=$networkcidr --ignore-preflight-errors=NumCPU

# save config
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
sudo export KUBECONFIG=$HOME/.kube/config

# share pod network
printf " Apply flannel...\n"
sudo kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

# Virtual box
#printf " Apply kuberouter...\n"
#sudo kubectl apply -f https://raw.githubusercontent.com/cloudnativelabs/kube-router/master/daemonset/kubeadm-kuberouter.yaml
#sudo kubectl apply -f https://raw.githubusercontent.com/cloudnativelabs/kube-router/master/daemonset/kubeadm-kuberouter-all-features.yaml

printf " Master setting complete\n"

