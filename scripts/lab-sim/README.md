# local lab simulator (windows) — server + client VMs

purpose: spin up two ubuntu vms (server and client) on your windows pc so you can practice class labs (ssh, users, chrony, ldap, nfs, samba) without vcenter.

options
- option a (recommended): multipass (hyper-v/wsl2 backend)
- option b: vagrant + virtualbox (if you cannot enable hyper-v)

success criteria
- you can `ssh` into both vms
- `systemctl` works (real systemd)
- you can install and test services (chrony, ldap utils, nfs, samba)

## option a — multipass (fast path)

prereqs: windows 10/11 with admin rights; hyper-v or wsl2 enabled.

1) install and launch vms (powershell)
```
# from repo root
pwsh -File scripts/multipass/setup-class-lab.ps1
```
this will:
- install multipass (via winget) if missing
- start two vms: lab-srv and lab-cli
- print their ip addresses and connect commands

2) connect
```
multipass shell lab-srv
multipass shell lab-cli
```

3) reset or remove
```
multipass stop lab-srv lab-cli
multipass delete lab-srv lab-cli
multipass purge
```

notes
- packages preinstalled on both: openssh-server, vim, net-tools, ldap-utils
- server only: chrony, nfs-kernel-server, samba
- ldap server install is interactive — run it during the lab (see week4_to_now_all_in_one.md)

## option b — vagrant + virtualbox

prereqs: install virtualbox and vagrant.

1) bring the lab up
```
cd scripts/vagrant
vagrant up
```

2) connect
```
vagrant ssh lab-srv
vagrant ssh lab-cli
```

3) stop/destroy
```
vagrant halt
vagrant destroy -f
```

networks
- vagrant uses a private network (192.168.56.0/24) by default in this file
- multipass uses its own NAT; use `multipass info` to see ip

accounts
- username: student
- password: Password1!

## quick sanity tests inside a vm
```
hostnamectl
ip a | sed -n '1,80p'
systemctl status ssh --no-pager -l | sed -n '1,12p'
chronyc tracking | sed -n '1,8p' || true
ldapsearch -VVV || true
```

troubleshooting
- hyper-v vs virtualbox conflict: only one can control virtualization at a time. pick multipass (hyper-v) or vagrant (virtualbox).
- corporate antivirus or vpn may block vm networks. pause vpn or try at home.
- wsl2-based multipass backend works on many machines even if hyper-v is unavailable.
