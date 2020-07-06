#!/bin/bash
# copy command
sudo cp ../bin/* /usr/bin/

# copy service
sudo cp ../service/* /etc/systemd/system/

# service start
sudo systemctl daemon-reload
sudo systemctl start keti-kubelet
sudo systemctl start checkpoint-collector

sudo kubectl create -f ../migrationmanager/crds/keti.migration_controllerrevisions_crd.yaml
sudo kubectl create -f ../migrationmanager/crds/keti.migration_deployments_crd.yaml
sudo kubectl create -f ../migrationmanager/crds/keti.migration_pods_crd.yaml
sudo kubectl create -f ../migrationmanager/crds/keti.migration_replicasets_crd.yaml
sudo kubectl create -f ../migrationmanager/crds/keti.migration_statefulsets_crd.yaml
sudo kubectl create -f ../migrationmanager/crds/keti.migration_daemonsets_crd.yaml
