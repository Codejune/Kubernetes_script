# combine worker to master (default api-server port : 6443), token: during 24h
kubeadm join 192.168.56.100:6443 --token 1ckgu8.qd6vpx3z1wg7fj81 --discovery-token-ca-cert-hash sha256:5740524e514db8566a1e065e5bd330c0a25d3c72583a1852eb7e93fab5d836d0

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




