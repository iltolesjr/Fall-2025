# vcenter lab: change the hostname (fast resubmit)

objective: fix submission issues and show correct vcenter vm, ip, and hosts.

## steps
1) confirm vm and ip
```bash
hostnamectl
ip a | sed -n '1,120p' | sed -n '1,80p'
```
2) set hostname
```bash
sudo hostnamectl set-hostname your-hostname
hostnamectl
```
3) add hosts and test
```bash
echo "127.0.0.1  localhost" | sudo tee /etc/hosts >/dev/null
# add class hosts if required by sheet (example format)
# 10.99.0.23  your-hostname
# 10.99.0.10  instructor-hostname
getent hosts your-hostname || true
ping -c 2 your-hostname || true
```
4) proof shots
- vcenter console with terminal showing hostnamectl
- `ip a` with vcenter network ip (not a local vm ip)
- `/etc/hosts` lines and a successful ping or getent

notes: use only the one screenshot the sheet requests plus one IP proof if needed.
