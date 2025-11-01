# vmware local setup - rocky + mint (windows host)

purpose: use vmware workstation (player or pro) already installed on windows to create two vms for local practice. final grading screenshots still must come from vcenter.

## prerequisites
- vmware workstation player or pro (run as administrator when opening the virtual network editor)
- rocky linux 9 minimal iso (x86_64): https://rockylinux.org/download
- linux mint 22 cinnamon 64 bit iso: https://www.linuxmint.com/download.php

optional: verify iso checksums in powershell
```powershell
Get-FileHash .\Rocky-9-*.iso -Algorithm SHA256
Get-FileHash .\linuxmint-22-*.iso -Algorithm SHA256
```
compare the values with the vendor pages.

## step 1 - configure vmware networks
1. open "virtual network editor" as administrator.
2. ensure you have:
   - vmnet8: nat network (keep defaults; provides internet)
   - vmnet1: host-only network
3. set vmnet1 subnet to a clean /24, e.g. 192.168.56.0/24. apply.

note: if your vmnet1 is already a different subnet, keep it. you will detect it below with ipconfig.

quick check on windows host
```powershell
ipconfig | Select-String -Pattern "VMware Network Adapter VMnet1|IPv4"
# example output shows the host adapter IP, e.g. 192.168.56.1
```

## step 2 - create rocky server vm
- name: rocky-srv-local
- iso: rocky 9 minimal
- processors: 2
- memory: 2048 mb
- disk: 20 gb (split into multiple files is fine)
- network adapters:
  - network adapter 1: nat (vmnet8)
  - add network adapter 2: host-only (vmnet1)
- install "minimal install". set hostname: rocky-srv. enable network during install. create an admin user in wheel.

## step 3 - create mint desktop vm
- name: mint-desktop-local
- iso: linux mint 22 cinnamon
- processors: 2
- memory: 4096 mb
- disk: 20 gb
- network adapters:
  - network adapter 1: nat (vmnet8)
  - add network adapter 2: host-only (vmnet1)
- install normally. user: student.

## step 4 - set static ip on host-only nics (keep nat as default route)
first, discover the vmnet1 subnet from the host (example shows 192.168.56.0/24; adjust addresses if yours differs):
- if host ip is 192.168.56.1, use 192.168.56.10 for rocky and 192.168.56.11 for mint.

rocky post-install
```bash
sudo -i
# updates and confirm network manager is active
dnf -y update
nmcli con show
# identify which connection is the host-only nic (usually the one without internet after install)
# set static ip on host-only, no gateway, set higher route-metric than nat so nat stays default
nmcli con mod "Wired connection 2" ipv4.method manual ipv4.addresses 192.168.56.10/24 ipv4.gateway "" ipv4.dns "1.1.1.1" connection.autoconnect yes
nmcli con mod "Wired connection 1" ipv4.route-metric 100
nmcli con mod "Wired connection 2" ipv4.route-metric 200
nmcli con up "Wired connection 2"
# verify
ip -4 a
ip r
```

mint post-install
```bash
# update packages
sudo apt update && sudo apt -y upgrade
# optional: tools
sudo apt -y install openssh-client net-tools
nmcli con show
# set static ip on host-only, no gateway
sudo nmcli con mod "Wired connection 2" ipv4.method manual ipv4.addresses 192.168.56.11/24 ipv4.gateway "" ipv4.dns "1.1.1.1" connection.autoconnect yes
sudo nmcli con up "Wired connection 2"
```

notes
- if your vmnet1 subnet is not 192.168.56.0/24, replace the .10 and .11 addresses with ones inside your actual vmnet1 subnet. keep the gateway empty on host-only.
- if connection names differ (ens33/ens34), use `nmcli dev status` and `nmcli con show` to find the right profile, then substitute the profile name above.

## step 5 - connectivity checks
```bash
# from mint to rocky
ping -c 3 192.168.56.10
ssh <your-user>@192.168.56.10
# from rocky to mint
ping -c 3 192.168.56.11
```

## step 6 - snapshots
- after post-install and networking, take a snapshot named clean-base on both vms.
- take a snapshot before each lab; revert if needed.

## which vm for which lab (local practice)
- users and ssh: rocky
- ntp and dns: rocky
- ldap server: rocky
- network filesystems: rocky (server) + mint (client) or a second rocky
- samba to windows: rocky (server) + your windows host (client)
- log server: rocky
- web server: rocky
- different desktops: mint (optionally add mate/xfce for comparison)

## troubleshooting
- virtual network editor requires administrator; changes may not apply otherwise.
- if vms cannot see each other, ensure both have a second adapter on vmnet1 and matching subnet ips.
- if internet breaks after setting host-only static ip, confirm the nat adapter has lower route-metric (smaller number) than host-only.
- leave selinux enforcing on rocky; open ports with firewall-cmd when needed during labs.

## reminder
use this for practice only. collect final grading proofs from vcenter as required by your instructor.
