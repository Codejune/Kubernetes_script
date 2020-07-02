swapoff -a
strace -eopenat kubectl version
sudo systemctl restart kubelet.service
sudo systemctl start docker
sudo systemctl start kubelet
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
