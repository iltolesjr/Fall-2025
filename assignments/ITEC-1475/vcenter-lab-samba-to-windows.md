# on-campus lab: samba server to windows (one-file)

objective: share a folder from linux and access it from windows.

audience: debian/ubuntu server; windows client on campus.

## server (linux)
```bash
sudo apt update
sudo apt install -y samba
sudo mkdir -p /srv/samba/public
sudo chown nobody:nogroup /srv/samba/public
sudo chmod 0775 /srv/samba/public

sudo tee -a /etc/samba/smb.conf >/dev/null <<'CONF'
[public]
   path = /srv/samba/public
   browseable = yes
   read only = no
   guest ok = yes
   create mask = 0664
   directory mask = 0775
CONF

sudo systemctl restart smbd nmbd || sudo systemctl restart smbd
sudo systemctl enable smbd --now
sudo smbstatus | sed -n '1,12p'
ip a | sed -n '1,80p'
```
optional user share (if guest not allowed):
```bash
sudo useradd -m sambauser || true
echo 'sambauser:Password1!' | sudo chpasswd
echo -e "Password1!\nPassword1!" | sudo smbpasswd -a -s sambauser
```

## client (windows)
- open file explorer, in address bar type: `\\<server-ip>\public`
- create a new folder and a text file

## proof
- linux: `testparm -s` top output, `smbstatus` top output
- windows: explorer window showing `\\<server-ip>\public` and your test file
