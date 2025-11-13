#!/usr/bin/env bash
set -euo pipefail

dnf -y install nfs-utils
mkdir -p /srv/nfs/share
chown nfsnobody:nfsnobody /srv/nfs/share
chmod 0777 /srv/nfs/share

# export to host-only network
if ! grep -q '^/srv/nfs/share' /etc/exports; then
  echo "/srv/nfs/share 192.168.56.0/24(rw,sync,no_subtree_check,no_root_squash)" >> /etc/exports
fi

systemctl enable --now nfs-server
exportfs -rav

# firewall
firewall-cmd --permanent --add-service=nfs || true
firewall-cmd --permanent --add-service=mountd || true
firewall-cmd --permanent --add-service=rpc-bind || true
firewall-cmd --reload || true

echo "nfs helper done"
