#!/usr/bin/env bash
# collect_lennox_outputs.sh
# Collects non-interactive outputs into a log file
# Usage: ./collect_lennox_outputs.sh
# Note: Some commands require sudo and will prompt for password if needed

OUTFILE="lennox-lab-outputs.txt"
rm -f "$OUTFILE"
exec > >(tee -a "$OUTFILE") 2>&1

echo "Lennox Lab outputs collected on: $(date)"

echo "\n=== Hostnamectl ==="
hostnamectl || true

echo "\n=== uname -a ==="
uname -a || true

echo "\n=== ip addr show ==="
ip addr show || true

echo "\n=== id serveradmin (if exists) ==="
if id serveradmin >/dev/null 2>&1; then
  id serveradmin
  groups serveradmin
else
  echo "serveradmin user not found"
fi

echo "\n=== SSH config summary ==="
sudo grep -E "PermitRootLogin|PasswordAuthentication|Port" /etc/ssh/sshd_config || true

echo "\n=== UFW status ==="
sudo ufw status verbose || true

echo "\n=== Apache status ==="
sudo systemctl status apache2 --no-pager || true

echo "\n=== curl localhost ==="
curl -I localhost || true

echo "\n=== df -h ==="
df -h || true

echo "\n=== free -h ==="
free -h || true

echo "\n=== ps aux (top 15) ==="
ps aux | head -15 || true

echo "\n=== journalctl (last 1 hour, top 30) ==="
sudo journalctl --since "1 hour ago" | head -30 || true

echo "\n=== /etc/server-info.txt ==="
cat /etc/server-info.txt 2>/dev/null || echo "/etc/server-info.txt not found"

echo "\n=== Active services matching apache2|ssh|ufw ==="
sudo systemctl list-units --type=service --state=active | grep -E "apache2|ssh|ufw" || true

echo "\n=== netstat (listening) ==="
sudo netstat -tlnp | head -20 || true

echo "\n=== ping (3 to google.com) ==="
ping -c 3 google.com || true

echo "\n=== Done. Outputs saved to $OUTFILE ==="

# End of script
