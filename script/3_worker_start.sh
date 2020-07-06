# combine worker to master (default api-server port : 6443), token: during 24h
echo -n "마스터IP: "
read masterip
echo -n "토큰: "
read jointoken
echo -n "해시: "
read joinhas

kubeadm join $masterip:6443 --token $jointoken --discovery-token-ca-cert-hash sha256:$joinhash

# if you missing token
#kubeadm token list

# if you missing token-ca-cert-hash
#openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt | openssl rsa -pubin -outform der 2>/dev/null | openssl dgst -sha256 -hex | sed 's/^.* //'

# if token is expire
#kubeadm token create

# add this line under Environment line /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
#Environment="KUBELET_EXTRA_ARGS=--node-ip=192.168.56.102"

# confirm
kubectl get nodes




