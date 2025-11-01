# vlab screenshots template

student: 
course: itec 1475-60
lab: 
date: 

instructions
- replace each image path with your real screenshot file
- keep only the sections needed for this lab
- export to pdf when done

## proof shots (required for most labs)

1) hostname and ip

caption: hostnamectl and ip address

![shot 01 hostnamectl](images/shot-01-hostnamectl.png)

![shot 02 ip a](images/shot-02-ip-a.png)

2) service status or config

caption: top of service status or config check

![shot 03 service status](images/shot-03-service-status.png)

3) success line

caption: the line that proves success (ping, mount, ssh, share, export)

![shot 04 success proof](images/shot-04-success.png)

---

## hostname lab specific

- hostnamectl output
- /etc/hosts lines
- ping or getent name lookup

![shot 11 hostnamectl](images/shot-11-hostnamectl.png)
![shot 12 etc hosts](images/shot-12-etc-hosts.png)
![shot 13 ping or getent](images/shot-13-ping.png)

## users and ssh lab specific

- id alice and group project
- systemctl status ssh
- ssh to localhost as alice

![shot 21 id alice](images/shot-21-id-alice.png)
![shot 22 ssh status](images/shot-22-ssh-status.png)
![shot 23 ssh localhost alice](images/shot-23-ssh-localhost.png)

## ntp and dns lab specific

- chronyc tracking and sources
- resolver status or resolv.conf
- getent hosts lookups

![shot 31 chronyc tracking](images/shot-31-chronyc-tracking.png)
![shot 32 resolver status](images/shot-32-resolver-status.png)
![shot 33 getent hosts](images/shot-33-getent-hosts.png)

## ldap lab specific

- ldapsearch result for test user uid and cn
- dpkg reconfigure or base dn info (if shown)

![shot 41 ldapsearch](images/shot-41-ldapsearch.png)
![shot 42 base dn info](images/shot-42-basedn.png)

## nfs lab specific

- exportfs -v
- ls -l /srv/nfs/shared on server
- mount and ls on client

![shot 51 exportfs](images/shot-51-exportfs.png)
![shot 52 server folder](images/shot-52-server-folder.png)
![shot 53 client mount](images/shot-53-client-mount.png)

## samba to windows lab specific

- testparm -s top lines
- smbstatus top lines
- windows explorer path \\server-ip\public with your file

![shot 61 testparm](images/shot-61-testparm.png)
![shot 62 smbstatus](images/shot-62-smbstatus.png)
![shot 63 windows share](images/shot-63-windows-share.png)

---

notes
- take screenshots from the vcenter console, not a local vm
- crop private info and show only what is asked
- keep file names simple like shot-01-*.png
