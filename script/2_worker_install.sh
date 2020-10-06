#!/bin/bash
#
# KETI CRD VERSION MIGRATION MANAGER WORKER INSTALL SCRIPT
# 
# 1. If you missing token
#  $ kubeadm token list
#
# 2. If you missing token-ca-cert-hash
#   $ openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt | openssl rsa -pubin -outform der 2>/dev/null | openssl dgst -sha256 -hex | sed 's/^.* //'
#
# 3. If token was expire
#   $ kubeadm token create
#

# combine worker to master (default api-server port : 6443), token: during 24h
printf "\n ======================================================================\n"
printf "             KETI CRD VERSION MIGRATION MANAGER WORKER SETTING\n"
printf "\n ======================================================================\n"
printf " Join to Master API-Server...\n"
printf " Input master IP: "
read masterip
printf " Input join TOKEN: "
read jointoken
printf " Input join HASH: "
read joinhas

kubeadm join $masterip:6443 --token $jointoken --discovery-token-ca-cert-hash sha256:$joinhash




