#!/usr/bin/env bash
# collect-lennox-outputs.sh
# Collects all Lennox lab outputs into a single file for easy submission
# 
# This script gathers system information and service statuses
# to help with lab documentation and submission.
#
# USAGE: 
#   sudo ./collect-lennox-outputs.sh
#
# OUTPUT: Creates lennox-lab-outputs.txt in current directory

# Color codes for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}Collecting Lennox Lab outputs...${NC}"
echo ""

OUTFILE="lennox-lab-outputs.txt"
rm -f "$OUTFILE"
exec > >(tee -a "$OUTFILE") 2>&1

echo "Lennox Lab outputs collected on: $(date)"
echo "Server: fj3453rb-mint"
echo "IP Address: 10.14.75.235"

echo ""
echo "═══════════════════════════════════════════════════════════════"
echo "                    SYSTEM INFORMATION"
echo "═══════════════════════════════════════════════════════════════"

echo ""
echo "=== Hostnamectl ==="
hostnamectl || true

echo ""
echo "=== uname -a ==="
uname -a || true

echo ""
echo "=== Operating System Details ==="
lsb_release -a 2>/dev/null || cat /etc/os-release || true

echo ""
echo "═══════════════════════════════════════════════════════════════"
echo "                    NETWORK CONFIGURATION"
echo "═══════════════════════════════════════════════════════════════"

echo ""
echo "=== IP Address Configuration ==="
ip addr show || true

echo ""
echo "=== Routing Table ==="
ip route show || true

echo ""
echo "=== DNS Configuration ==="
cat /etc/resolv.conf 2>/dev/null || true

echo ""
echo "═══════════════════════════════════════════════════════════════"
echo "                    USER ACCOUNTS"
echo "═══════════════════════════════════════════════════════════════"

echo ""
echo "=== Current User ==="
whoami || true
echo ""
id || true

echo ""
echo "=== serveradmin User (if exists) ==="
if id serveradmin >/dev/null 2>&1; then
  id serveradmin
  groups serveradmin
else
  echo "serveradmin user not found"
fi

echo ""
echo "═══════════════════════════════════════════════════════════════"
echo "                    SECURITY CONFIGURATION"
echo "═══════════════════════════════════════════════════════════════"

echo ""
echo "=== SSH Configuration Summary ==="
if [ -f /etc/ssh/sshd_config ]; then
    grep -E "PermitRootLogin|PasswordAuthentication|Port" /etc/ssh/sshd_config || true
else
    echo "SSH config file not found"
fi

echo ""
echo "=== UFW Firewall Status ==="
ufw status verbose 2>/dev/null || echo "UFW not installed or permission denied"

echo ""
echo "═══════════════════════════════════════════════════════════════"
echo "                    INSTALLED SERVICES"
echo "═══════════════════════════════════════════════════════════════"

echo ""
echo "=== Apache Web Server Status ==="
systemctl status apache2 --no-pager 2>/dev/null || echo "Apache2 not installed or not running"

echo ""
echo "=== Testing Web Server (curl localhost) ==="
curl -I localhost 2>/dev/null || echo "Web server not responding on localhost:80"

echo ""
echo "=== Active Services Matching apache2|ssh|ufw ==="
systemctl list-units --type=service --state=active 2>/dev/null | grep -E "apache2|ssh|ufw" || echo "No matching services found"

echo ""
echo "═══════════════════════════════════════════════════════════════"
echo "                    SYSTEM RESOURCES"
echo "═══════════════════════════════════════════════════════════════"

echo ""
echo "=== Disk Usage (df -h) ==="
df -h || true

echo ""
echo "=== Memory Usage (free -h) ==="
free -h || true

echo ""
echo "=== CPU Information ==="
lscpu 2>/dev/null | grep -E "Model name|CPU\(s\)|Thread|Core" || true

echo ""
echo "=== Top 15 Processes (ps aux) ==="
ps aux | head -15 || true

echo ""
echo "═══════════════════════════════════════════════════════════════"
echo "                    NETWORK CONNECTIVITY"
echo "═══════════════════════════════════════════════════════════════"

echo ""
echo "=== Listening Ports (netstat -tlnp) ==="
netstat -tlnp 2>/dev/null | head -20 || ss -tlnp 2>/dev/null | head -20 || echo "Unable to list listening ports"

echo ""
echo "=== Ping Test to Google (3 packets) ==="
ping -c 3 google.com 2>/dev/null || echo "Unable to ping google.com"

echo ""
echo "═══════════════════════════════════════════════════════════════"
echo "                    SYSTEM LOGS"
echo "═══════════════════════════════════════════════════════════════"

echo ""
echo "=== Recent System Logs (last 1 hour, top 30) ==="
journalctl --since "1 hour ago" 2>/dev/null | head -30 || echo "Unable to access system logs"

echo ""
echo "═══════════════════════════════════════════════════════════════"
echo "                    SERVER DOCUMENTATION"
echo "═══════════════════════════════════════════════════════════════"

echo ""
echo "=== /etc/server-info.txt ==="
if [ -f /etc/server-info.txt ]; then
    cat /etc/server-info.txt
else
    echo "/etc/server-info.txt not found"
fi

echo ""
echo "═══════════════════════════════════════════════════════════════"
echo "                    COMPLETION"
echo "═══════════════════════════════════════════════════════════════"
echo ""
echo "✓ All outputs collected successfully!"
echo "✓ Output saved to: $OUTFILE"
echo ""
echo "You can now review the file and include it in your lab submission."
echo ""

# End of script
