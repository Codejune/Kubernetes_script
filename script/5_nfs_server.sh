#!/bin/bash
#
# NFS setting script
# 

# Install NFS Package
print " Install NFS package..."
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install nfs-common nfs-kernel-server rpcbind portmap -y

# Make directory with share
print " Input make directory with shared(ex./keti/csv): "
read sharepath
sudo mkdir $sharepath
sudo chmod -R 777 $sharepath

# Edit NFS config
print " Add shared path to NFS config..."
sudo echo "$sharepath *(rw,sync,no_subtree_check)" >> /etc/exports
sudo exportfs -a
sudo systemctl restart nfs-kernel-server

print " NFS install & setting complete"



