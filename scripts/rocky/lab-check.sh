#!/usr/bin/env bash
set -euo pipefail

ok() { echo "[ok] $*"; }
warn() { echo "[warn] $*"; }

# hostname
H=$(hostnamectl --static)
[[ "$H" == "fj3453rb" ]] && ok "hostname fj3453rb" || warn "hostname is $H (expected fj3453rb)"

# ip on host-only
if ip -4 -o addr show | grep -q "192\.168\.56\."; then
  ok "host-only ip present"
else
  warn "no 192.168.56.x ip found"
fi

# default route via nat should exist
if ip route | grep -q default; then ok "default route present"; else warn "no default route"; fi

# selinux
S=$(getenforce 2>/dev/null || echo unknown)
[[ "$S" == "Enforcing" ]] && ok "selinux enforcing" || warn "selinux $S (enforcing recommended)"

# services
for s in sshd firewalld chronyd; do
  systemctl is-active --quiet "$s" && ok "$s active" || warn "$s not active"
  systemctl is-enabled --quiet "$s" && ok "$s enabled" || warn "$s not enabled"
done

# packages
for p in nfs-utils samba openldap-servers openldap-clients; do
  rpm -q "$p" >/dev/null 2>&1 && ok "$p installed" || warn "$p not installed"
done

# firewall preview
ok "firewall services: $(firewall-cmd --list-services 2>/dev/null || echo n/a)"

# final
ok "precheck done"
