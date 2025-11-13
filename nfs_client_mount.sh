#!/usr/bin/env bash
set -e
read -p "enter server ip: " SIP
sudo apt update
sudo apt install -y nfs-common
sudo mkdir -p /mnt/nfs_shared
sudo mount -t nfs ${SIP}:/srv/nfs/shared /mnt/nfs_shared
echo "mounted from ${SIP}"
ls -l /mnt/nfs_shared
echo "${SIP}:/srv/nfs/shared /mnt/nfs_shared nfs defaults 0 0" | sudo tee -a /etc/fstab >/dev/null
