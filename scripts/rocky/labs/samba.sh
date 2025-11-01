#!/usr/bin/env bash
set -euo pipefail

dnf -y install samba samba-client
mkdir -p /srv/samba/share
chmod 0777 /srv/samba/share

# minimal smb.conf append if share not present
if ! grep -q '^\[labshare\]' /etc/samba/smb.conf; then
  cat >>/etc/samba/smb.conf <<'EOF'
[labshare]
   path = /srv/samba/share
   browsable = yes
   read only = no
   guest ok = yes
EOF
fi

# start services
systemctl enable --now smb nmb

# firewall
firewall-cmd --permanent --add-service=samba || true
firewall-cmd --reload || true

echo "samba helper done"
