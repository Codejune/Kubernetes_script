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

ifconfig cni0 down
ifconfig flannel.1 down
ifconfig docker0 down

systemctl start kubelet
systemctl start docker



