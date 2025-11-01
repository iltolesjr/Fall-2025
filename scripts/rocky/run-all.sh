#!/usr/bin/env bash
set -euo pipefail

# run from Rocky server as root
BASEDIR="$(cd "$(dirname "$0")" && pwd)"

bash "$BASEDIR/bootstrap.sh"
bash "$BASEDIR/labs/users_ssh.sh"
bash "$BASEDIR/labs/ntp_dns.sh"
bash "$BASEDIR/labs/nfs.sh"
bash "$BASEDIR/labs/samba.sh"
bash "$BASEDIR/labs/ldap.sh"

bash "$BASEDIR/lab-check.sh"

echo "all tasks complete"
