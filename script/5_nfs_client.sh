#!/bin/bash
#
# NFS setting script
# 

# Install NFS Package
print " Install NFS package..."
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install nfs-common -y

# Make directory with share
print " Input make directory with mount shared directory(ex./keti/csv): "
read sharepath
sudo mkdir $sharepath

# Edit NFS config
print " Input mount server IP(ex.10.0.6.1): "
read serverip
print " Input mount server directory(ex./keti/csv): "
read serverpath

print " Mount NFS directory..."
sudo mount $serverip:$serverpath $sharepath

print " NFS mount complete"



