#!/usr/bin/env bash
set -euo pipefail

dnf -y install chrony bind-utils
systemctl enable --now chronyd
# ensure pool iburst present (idempotent)
grep -q '^pool .*iburst' /etc/chrony.conf || echo 'pool pool.ntp.org iburst' >> /etc/chrony.conf
systemctl restart chronyd

# simple hosts entries (example peers)
addhost() { grep -q "^$1\s" /etc/hosts || echo -e "$1\t$2" >> /etc/hosts; }
addhost 192.168.56.10 rocky-srv
addhost 192.168.56.11 mint-desktop

chronyc -n sources || true

echo "ntp+dns helper done"
