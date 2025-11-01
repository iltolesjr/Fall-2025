# vcenter lab: create user accounts and ssh (one-file)

objective: add users, set passwords, configure ssh login, and prove access.

audience: debian/ubuntu vm in vcenter.

## steps
1) add users and groups
```bash
sudo groupadd project || true
sudo useradd -m -s /bin/bash alice || true
sudo useradd -m -s /bin/bash bob || true
sudo usermod -aG project alice
sudo usermod -aG project bob
echo 'alice:Password1!' | sudo chpasswd
echo 'bob:Password1!' | sudo chpasswd
getent passwd alice
id alice
getent group project
```
2) configure ssh
```bash
sudo apt update
sudo apt install -y openssh-server
sudo systemctl enable --now ssh
sudo systemctl status ssh --no-pager -l | sed -n '1,12p'
ss -tlnp | grep :22 || sudo ss -tlnp | head -n 5
ip a | sed -n '1,120p' | sed -n '1,80p'
```
3) test local ssh
```bash
ssh -o StrictHostKeyChecking=no alice@localhost 'whoami && groups && hostname'
```
4) proof shots
- `id alice` and `getent group project`
- `systemctl status ssh` top lines
- `ssh alice@localhost` showing whoami/groups/hostname

notes: if remote test is required, ssh from another vm to your vm ip.
