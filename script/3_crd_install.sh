#!/bin/bash
# copy command
sudo cp ../bin/* /usr/bin/

# copy service
sudo cp ../service/* /etc/systemd/system/

# service start
sudo systemctl daemon-reload
sudo systemctl start keti-kubelet
sudo systemctl start checkpoint-collector

sudo kubectl create -f ../crds
