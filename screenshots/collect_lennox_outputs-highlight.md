# Where to screenshot for `collect_lennox_outputs.sh`

Below is a copy of the important excerpt with the exact lines to capture wrapped in <mark> so they render with yellow background on GitHub. Take screenshots that include the surrounding context (1–2 lines above/below).

```bash
ira@fj3453rb-mint:~$ <mark>assignments/ITEC-1475/scripts/collect_lennox_outputs.sh</mark>
<mark>bash: assignments/ITEC-1475/scripts/collect_lennox_outputs.sh: No such file or directory</mark>
ira@fj3453rb-mint:~$ #!/usr/bin/env bash
# collect_lennox_outputs.sh
# Run this as root (sudo) from the server. It collects non-interactive outputs into a log file
# Usage: sudo ./collect_lennox_outputs.sh

OUTFILE="lennox-lab-outputs.txt"
rm -f "$OUTFILE"
exec > >(tee -a "$OUTFILE") 2>&1

<mark>echo "Lennox Lab outputs collected on: $(date)"</mark>

echo "\n=== Hostnamectl ==="
hostnamectl || true

echo "\n=== uname -a ==="
uname -a || true

echo "\n=== ip addr show ==="
ip addr show || true

echo "\n=== id serveradmin (if exists) ==="
if id serveradmin >/dev/null 2>&1; then
  id serveradmin
<mark># End of scripte. Outputs saved to $OUTFILE ==="ve | grep -E "apache2|ssh|ufw" |</mark>
```

Other areas to capture from the output file (highlighted below):

```text
<mark>Lennox Lab outputs collected on: Tue Oct 28 07:38:47 AM CDT 2025</mark>
\n=== Hostnamectl ===
 Static hostname: fj3453rb-mint
 ...
\n=== id serveradmin (if exists) ===
<mark>serveradmin user not found</mark>
\n=== SSH config summary ===
<mark>grep: /etc/ssh/sshd_config: No such file or directory</mark>
\n=== UFW status ===
<mark>ERROR: You need to be root to run this script</mark>
\n=== Done. Outputs saved to lennox-lab-outputs.txt ===
```

Take separate screenshots for the "missing script" terminal, the edited script in your editor, the sudo run, and the output file showing the Hostnamectl, UFW error, and "Done" line.
