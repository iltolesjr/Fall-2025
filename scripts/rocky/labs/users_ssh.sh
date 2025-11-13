#!/usr/bin/env bash
set -euo pipefail

# create a couple of users and ensure sshd is active
USERS=(alice bob)
for u in "${USERS[@]}"; do
  id -u "$u" >/dev/null 2>&1 || useradd -m "$u"
  echo "$u:1212" | chpasswd || true
done
systemctl enable --now sshd

echo "users+ssh helper done"
