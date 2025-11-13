#!/usr/bin/env bash
set -euo pipefail
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y openssh-server vim net-tools ldap-utils chrony nfs-kernel-server samba
systemctl enable --now ssh || true
