#!/bin/bash
kubeadm reset

systemctl stop kubelet

systemctl stop docker

rm -rf /var/lib/cni/

rm -rf /var/lib/kubelet/*

rm -rf /run/flannel

rm -rf /etc/cni/

rm -rf /etc/kubernetes

rm -rf /var/lib/etcd/



ip link delete cni0

ip link delete flannel.1



yum remove -y kubelet

yum remove -y kubectl

yum remove -y kubeadm



systemctl start docker



