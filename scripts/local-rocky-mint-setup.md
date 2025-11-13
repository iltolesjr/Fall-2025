# local rocky and mint setup (windows host)

purpose: set up one rocky server vm and one linux mint desktop vm on your windows pc for local practice. final graded work still needs to be done in vcenter.

## downloads
- rocky linux 9 minimal iso (x86_64): https://rockylinux.org/download
- linux mint 22 cinnamon 64 bit iso: https://www.linuxmint.com/download.php
- hypervisor (pick one)
  - virtualbox for windows: https://www.virtualbox.org/wiki/Downloads
  - vmware workstation player (free for personal use): https://www.vmware.com/products/workstation-player.html

optional: verify iso checksums.

```powershell
# replace file names to match the iso you downloaded
Get-FileHash .\Rocky-9-*.iso -Algorithm SHA256
Get-FileHash .\linuxmint-22-*.iso -Algorithm SHA256
# compare the sha256 value to the checksum listed on the vendor download page
```

## vm specs
create two vms.

rocky server (for ldap, nfs, samba, ntp, dns, web, log)
- name: rocky-srv-local
- cpu: 2
- ram: 2048 mb
- disk: 20 gb (vdisk dynamically allocated is fine)
- network: two adapters
  - nic1: nat (internet access)
  - nic2: host-only (local vm-to-vm network)
- attach rocky iso for install

mint desktop (for different desktops and as client for nfs/samba)
- name: mint-desktop-local
- cpu: 2
- ram: 4096 mb
- disk: 20 gb
- network: two adapters
  - nic1: nat
  - nic2: host-only (same host-only network as rocky)
- attach mint iso for install

notes
- in virtualbox: file -> tools -> network -> host-only networks -> create. use the default 192.168.56.0/24 network. name often shows as vboxnet0.
- in vmware: add a host-only adapter (vmnet1) via virtual network editor, then attach a second adapter on that network to each vm.

## install steps

rocky linux 9 minimal
1. start vm, pick "minimal install". enable network during install.
2. set hostname: rocky-srv
3. accept automatic partitioning. set strong root password and create an admin user (wheel).
4. complete install and reboot. log in as your user.

post install on rocky
```bash
# become root
sudo -i
# update and basic tools
dnf -y update
# ssh server is installed by default on minimal images; ensure it is enabled
systemctl enable --now sshd
# identify connections and device names
nmcli con show
# example: set static ip on the host-only adapter (often "Wired connection 2")
# use 192.168.56.10/24 for the host-only adapter; leave gateway empty so nat stays default route
nmcli con mod "Wired connection 2" ipv4.method manual ipv4.addresses 192.168.56.10/24 ipv4.gateway "" ipv4.dns "1.1.1.1" connection.autoconnect yes
# set route metrics so nat stays default
nmcli con mod "Wired connection 1" ipv4.route-metric 100
nmcli con mod "Wired connection 2" ipv4.route-metric 200
nmcli con up "Wired connection 2"
# confirm
ip -4 a
ip r
```

linux mint 22 cinnamon
1. start vm, choose install linux mint.
2. normal installation is fine. create user: student.
3. reboot and log in. run updates.

post install on mint
```bash
# update packages
sudo apt update && sudo apt -y upgrade
# useful tools
sudo apt -y install openssh-client net-tools
# identify connections
nmcli con show
# set static ip on host-only adapter (often "Wired connection 2")
# use 192.168.56.11/24
sudo nmcli con mod "Wired connection 2" ipv4.method manual ipv4.addresses 192.168.56.11/24 ipv4.gateway "" ipv4.dns "1.1.1.1" connection.autoconnect yes
sudo nmcli con up "Wired connection 2"
```

## network plan
- host-only network: 192.168.56.0/24
  - rocky-srv: 192.168.56.10/24
  - mint-desktop: 192.168.56.11/24
- nat adapters provide internet. do not set a gateway on host-only adapters.

## connectivity checks
```bash
# from mint to rocky
ping -c 3 192.168.56.10
ssh <your-user>@192.168.56.10
# from rocky to mint
ping -c 3 192.168.56.11
```

## snapshots
- take a snapshot named "clean-base" on both vms after completing post install steps.
- before each lab, take another snapshot so you can roll back quickly.

## which vm for which lab (local practice)
- users and ssh: rocky
- ntp and dns: rocky
- ldap server: rocky
- network filesystems: rocky (server) + mint (client) or a second rocky
- samba to windows: rocky (server) + your windows host (client)
- log server: rocky
- web server: rocky
- different desktops: mint (install and compare additional desktops if desired)

## troubleshooting quick hits
- if virtualbox does not offer 64 bit options or vms will not start, ensure virtualization is enabled in bios/uefi. if hyper-v is enabled, prefer vmware player or disable hyper-v features.
- if the vms cannot see each other, confirm both have a second adapter on the same host-only network and that ips are in the same subnet.
- keep selinux enforcing on rocky. open ports as needed per lab using firewall-cmd when you reach those steps.

## reminder
use this environment to practice and verify commands. capture final grading screenshots from the vcenter vms as your instructor requires.
