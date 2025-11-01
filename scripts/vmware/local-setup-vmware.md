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
- install "minimal install". set hostname: rocky-srv (bootstrap will change it to fj3453rb). enable network during install. create an admin user in wheel.

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

## step 4 - one-liners to configure

on rocky (as your admin user)
```bash
sudo bash -c "curl -fsSL https://raw.githubusercontent.com/iltolesjr/Fall-2025/main/scripts/rocky/bootstrap.sh | bash"
sudo bash -c "curl -fsSL https://raw.githubusercontent.com/iltolesjr/Fall-2025/main/scripts/rocky/run-all.sh -o /root/run-all.sh && chmod +x /root/run-all.sh && curl -fsSL https://raw.githubusercontent.com/iltolesjr/Fall-2025/main/scripts/rocky/lab-check.sh -o /root/lab-check.sh && chmod +x /root/lab-check.sh && mkdir -p /root/labs && for f in users_ssh ntp_dns nfs samba ldap; do curl -fsSL https://raw.githubusercontent.com/iltolesjr/Fall-2025/main/scripts/rocky/labs/$f.sh -o /root/labs/$f.sh; chmod +x /root/labs/$f.sh; done && /root/run-all.sh"
```

on mint
```bash
sudo bash -c "curl -fsSL https://raw.githubusercontent.com/iltolesjr/Fall-2025/main/scripts/mint/bootstrap.sh | bash"
```

notes
- defaults set hostname fj3453rb on rocky, fj3453rb-cli on mint, passwords 1212 for root and your user on rocky and your user on mint, host-only ips 192.168.56.53 and 192.168.56.54. change by exporting HOSTONLY_IP or USER_PASS before running if you need.
- example override on rocky: `sudo HOSTONLY_IP=192.168.200.53/24 USER_PASS=supersecret bash -c "curl -fsSL .../bootstrap.sh | bash"`

## step 5 - connectivity checks
```bash
# from mint to rocky
ping -c 3 192.168.56.53
ssh <your-rocky-user>@192.168.56.53
# from rocky to mint
ping -c 3 192.168.56.54
```

## step 6 - snapshots
- after post-install and networking, take a snapshot named clean-base on both vms.
- take a snapshot before each lab; revert if needed.

## troubleshooting
- virtual network editor requires administrator; changes may not apply otherwise.
- if vms cannot see each other, ensure both have a second adapter on vmnet1 and matching subnet ips.
- if internet breaks after setting host-only static ip, confirm the nat adapter has lower route-metric (smaller number) than host-only.
- leave selinux enforcing on rocky; open ports with firewall-cmd when needed during labs.

## reminder
use this for practice only. collect final grading proofs from vcenter as required by your instructor.
