swapoff -a
strace -eopenat kubectl version
sudo systemctl restart kubelet
sudo systemctl restart docker
