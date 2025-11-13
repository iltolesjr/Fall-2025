#!/usr/bin/env bash
set -euo pipefail

# config
HOSTNAME_WANTED="fj3453rb"
HOSTONLY_IP="${HOSTONLY_IP:-192.168.56.53/24}"
HOSTONLY_GW=""
HOSTONLY_DNS="1.1.1.1"
ROOT_PASS="${ROOT_PASS:-1212}"
USER_NAME="${SUDO_USER:-${USER:-student}}"
USER_PASS="${USER_PASS:-1212}"

# require root
if [[ $EUID -ne 0 ]]; then
  echo "re-run with sudo: sudo bash $0" >&2
  exit 1
fi

# hostname
if [[ "$(hostnamectl --static)" != "$HOSTNAME_WANTED" ]]; then
  hostnamectl set-hostname "$HOSTNAME_WANTED"
fi

# passwords (lab only)
echo "root:${ROOT_PASS}" | chpasswd || true
if id -u "$USER_NAME" >/dev/null 2>&1; then
  echo "${USER_NAME}:${USER_PASS}" | chpasswd || true
else
  useradd -m -G wheel "$USER_NAME" || true
  echo "${USER_NAME}:${USER_PASS}" | chpasswd || true
fi

# updates and basic tools
dnf -y makecache
DNF_PKGS=(chrony bind-utils nfs-utils samba samba-client openldap-servers openldap-clients firewalld curl tar vim git)
dnf -y install "${DNF_PKGS[@]}" || true

# ensure services
enable_now() { systemctl enable --now "$1" 2>/dev/null || true; }
enable_now sshd
enable_now firewalld
enable_now chronyd

# network - set host-only static ip on the non-default route interface
# pick connection without default route or named like "Wired connection 2"
DEFAULT_CON=$(nmcli -t -f NAME,IP4.GATEWAY con show | awk -F: '$2!=""{print $1; exit}')
HOSTONLY_CON=$(nmcli -t -f NAME,DEVICE con show | awk -F: 'NR==2{print $1}')
if [[ -z "${HOSTONLY_CON:-}" || "$HOSTONLY_CON" == "$DEFAULT_CON" ]]; then
  # fallback: pick any other connection
  HOSTONLY_CON=$(nmcli -t -f NAME con show | awk -F: -v def="$DEFAULT_CON" '$1!=def{print $1; exit}')
fi
if [[ -n "${HOSTONLY_CON:-}" ]]; then
  nmcli con mod "$DEFAULT_CON" ipv4.route-metric 100 || true
  nmcli con mod "$HOSTONLY_CON" ipv4.method manual ipv4.addresses "$HOSTONLY_IP" ipv4.gateway "$HOSTONLY_GW" ipv4.dns "$HOSTONLY_DNS" ipv4.route-metric 200 connection.autoconnect yes || true
  nmcli con up "$HOSTONLY_CON" || true
fi

# firewall quick opens for later labs (safe if repeated)
firewall-cmd --permanent --add-service=nfs || true
firewall-cmd --permanent --add-service=mountd || true
firewall-cmd --permanent --add-service=rpc-bind || true
firewall-cmd --permanent --add-service=samba || true
firewall-cmd --permanent --add-service=ldap || true
firewall-cmd --reload || true

# summary
cat <<EOF
[bootstrap complete]
hostname: $(hostnamectl --static)
user: ${USER_NAME}
host-only ip: $(ip -4 -o addr show | awk '$2!="lo"{print $2,$4}')
selinux: $(getenforce 2>/dev/null || echo unknown)
services: sshd=$(systemctl is-active sshd) firewalld=$(systemctl is-active firewalld) chronyd=$(systemctl is-active chronyd)
EOF
