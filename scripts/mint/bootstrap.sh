#!/usr/bin/env bash
set -euo pipefail

HOSTNAME_WANTED="fj3453rb-cli"
HOSTONLY_IP="${HOSTONLY_IP:-192.168.56.54/24}"
HOSTONLY_GW=""
HOSTONLY_DNS="1.1.1.1"
USER_NAME="${SUDO_USER:-${USER:-student}}"
USER_PASS="${USER_PASS:-1212}"

if [[ $EUID -ne 0 ]]; then
  echo "re-run with sudo: sudo bash $0" >&2
  exit 1
fi

# hostname
if [[ "$(hostnamectl --static)" != "$HOSTNAME_WANTED" ]]; then
  hostnamectl set-hostname "$HOSTNAME_WANTED"
fi

# packages
apt update
apt -y install net-tools curl nfs-common cifs-utils ldap-utils openssh-client

# password for user (lab only)
if id -u "$USER_NAME" >/dev/null 2>&1; then
  echo "${USER_NAME}:${USER_PASS}" | chpasswd || true
fi

# network config
DEFAULT_CON=$(nmcli -t -f NAME,IP4.GATEWAY con show | awk -F: '$2!=""{print $1; exit}')
HOSTONLY_CON=$(nmcli -t -f NAME con show | awk -F: -v def="$DEFAULT_CON" '$1!=def{print $1; exit}')
if [[ -n "${HOSTONLY_CON:-}" ]]; then
  nmcli con mod "$DEFAULT_CON" ipv4.route-metric 100 || true
  nmcli con mod "$HOSTONLY_CON" ipv4.method manual ipv4.addresses "$HOSTONLY_IP" ipv4.gateway "$HOSTONLY_GW" ipv4.dns "$HOSTONLY_DNS" ipv4.route-metric 200 connection.autoconnect yes || true
  nmcli con up "$HOSTONLY_CON" || true
fi

# summary
cat <<EOF
[bootstrap complete]
hostname: $(hostnamectl --static)
user: ${USER_NAME}
host-only ip: $(ip -4 -o addr show | awk '$2!="lo"{print $2,$4}')
EOF
