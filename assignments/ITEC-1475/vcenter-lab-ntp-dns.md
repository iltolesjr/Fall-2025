# vcenter lab: ntp and dns (one-file)

objective: set correct time sync and verify name resolution.

audience: debian/ubuntu.

## ntp (system time)
```bash
sudo timedatectl set-ntp true
sudo apt update
sudo apt install -y chrony
sudo systemctl enable --now chrony
chronyc tracking | sed -n '1,8p'
chronyc sources -v | sed -n '1,20p'
timedatectl
```
proof: screenshots of `chronyc tracking` and `timedatectl`.

## dns (name resolution)
```bash
getent hosts google.com
getent hosts example.com
resolvectl status | sed -n '1,80p' || cat /etc/resolv.conf
```
optional custom dns:
```bash
# create a test zone in /etc/hosts
echo "1.2.3.4 test.local" | sudo tee -a /etc/hosts
getent hosts test.local
```
proof: screenshot of getent outputs and resolver status.
