#!/bin/bash

sudo echo 1 > /proc/sys/net/ipv4/ip_forward

# Vertualbox
#iptables -t nat -A POSTROUTING -o enp3s0 -j MASQUERADE
#iptables -A FORWARD -o enp3s0 -j ACCEPT
#iptables -A FORWARD -i enp3s0 -j ACCEPT

# init pod network & set api-server address
#sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address=192.168.56.100
sudo kubeadm init --pod-network-cidr 192.168.0.0/16

# save config
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
sudo export KUBECONFIG=$HOME/.kube/config

# share pod network
sudo kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

# Virtual box
KUBECONFIG=/etc/kubernetes/admin.conf kubectl apply -f https://raw.githubusercontent.com/cloudnativelabs/kube-router/master/daemonset/kubeadm-kuberouter.yaml
KUBECONFIG=/etc/kubernetes/admin.conf kubectl apply -f https://raw.githubusercontent.com/cloudnativelabs/kube-router/master/daemonset/kubeadm-kuberouter-all-features.yaml
#kubeadm join 10.0.2.15:6443 --token ksn2ky.k1blryrj10cstcnh \dd
#	    --discovery-token-ca-cert-hash sha256:051555daa0de8aad7a2cb32eb6975818bac0d26e4556638f62d30b059bbbc867

# show cluster node stat
kubectl get nodes

# show container with namespace
kubectl get pod --all-namespaces