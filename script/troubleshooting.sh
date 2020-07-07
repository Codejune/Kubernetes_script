swapoff -a
strace -eopenat kubectl version
sudo systemctl restart kubelet.service
sudo systemctl start docker
sudo systemctl start kubelet
