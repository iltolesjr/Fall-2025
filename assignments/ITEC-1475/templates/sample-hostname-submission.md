# vcenter lab: change the hostname - sample submission

student: your name
course: itec 1475-60
lab: week 2 - change the hostname
date: 2025-11-01

## short answers
- what changed: the system hostname changed with hostnamectl
- why it matters: consistent name helps ssh and hosts file testing
- how i proved it: hostnamectl output, ip and hosts, and a successful ping/getent

---

## shot 01 - hostnamectl
This shows the new hostname is set correctly.

![shot 01 hostnamectl](https://via.placeholder.com/1200x700?text=hostnamectl%20output)

what this proves
- the static hostname is set
- operating system and kernel context match the vm

---

## shot 02 - ip a
This shows the vCenter network IP on the correct interface.

![shot 02 ip a](https://via.placeholder.com/1200x700?text=ip%20a%20show%20addresses)

what this proves
- ip is assigned from the vcenter network, not a local vm range
- interface is up

---

## shot 03 - /etc/hosts lines
This shows the hostname is mapped for testing.

![shot 03 etc hosts](https://via.placeholder.com/1200x700?text=cat%20%2Fetc%2Fhosts)

what this proves
- hostname to ip mapping exists for name lookups

---

## shot 04 - ping or getent
This proves name resolution works for the hostname.

![shot 04 ping getent](https://via.placeholder.com/1200x700?text=ping%20hostname%20or%20getent%20hosts)

what this proves
- name resolves and round trip shows connectivity

---

## commands run (high level)
```
hostnamectl
sudo hostnamectl set-hostname your-hostname
ip a
cat /etc/hosts
ping -c 2 your-hostname || getent hosts your-hostname
```

## submission notes
- screenshots taken from the vcenter console window
- only the requested images included; cropped to avoid private info
- file exported to pdf and uploaded to lms
