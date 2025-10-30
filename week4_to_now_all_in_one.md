week 4 to now all in one

how to use
1. open a linux vm console
2. copy the script block below into the vm
3. run the two command lines shown under run it
4. take the screenshots listed

script
```bash
cat > setup_ldap_nfs.sh <<'SH'
#!/usr/bin/env bash
set -e

echo "ldap and nfs setup for debian or ubuntu"

# install
sudo apt update
sudo apt install -y slapd ldap-utils nfs-kernel-server nfs-common

# configure slapd
echo
echo "slapd reconfigure will open. set domain and admin password"
sudo dpkg-reconfigure slapd

# prompts (no placeholders hard coded)
echo
read -p "base dn example dc=school,dc=edu: " BASE_DN
read -p "admin dn example cn=admin,$BASE_DN: " ADMIN_DN
read -p "test user id default testuser: " TEST_UID
TEST_UID=${TEST_UID:-testuser}
read -p "test user name default Test User: " TEST_CN
TEST_CN=${TEST_CN:-Test User}
read -s -p "test user password: " TEST_PW
echo

# add ldap test user
LDIF="/tmp/${TEST_UID}.ldif"
cat > "$LDIF" <<LDIF
dn: uid=${TEST_UID},ou=people,${BASE_DN}
objectClass: inetOrgPerson
sn: ${TEST_CN}
cn: ${TEST_CN}
uid: ${TEST_UID}
userPassword: ${TEST_PW}
LDIF

echo
echo "adding ldap user"
sudo ldapadd -x -D "${ADMIN_DN}" -W -f "$LDIF"

echo "verify ldap user"
ldapsearch -x -LLL -H ldap://localhost -b "${BASE_DN}" "(uid=${TEST_UID})" cn uid || true

# nfs server and local client test
echo
echo "set up nfs server"
sudo mkdir -p /srv/nfs/shared
if id nobody >/dev/null 2>&1 && id nogroup >/dev/null 2>&1; then
  sudo chown nobody:nogroup /srv/nfs/shared
fi
sudo chmod 0775 /srv/nfs/shared
echo "/srv/nfs/shared *(rw,sync,no_subtree_check,root_squash)" | sudo tee /etc/exports >/dev/null
sudo exportfs -a
sudo systemctl enable --now nfs-kernel-server
sudo exportfs -v || true

echo
echo "mount nfs locally and write a test file"
sudo mkdir -p /mnt/nfs_shared
sudo mount -t nfs localhost:/srv/nfs/shared /mnt/nfs_shared
echo "hello from client" | sudo tee /mnt/nfs_shared/test_from_client.txt >/dev/null
ls -l /mnt/nfs_shared
echo "localhost:/srv/nfs/shared /mnt/nfs_shared nfs defaults 0 0" | sudo tee -a /etc/fstab >/dev/null

echo
echo "done"
echo "screenshots to take:"
echo "- ldapsearch output above"
echo "- exportfs -v"
echo "- ls -l /mnt/nfs_shared and the test file"
SH
chmod +x setup_ldap_nfs.sh
sudo ./setup_ldap_nfs.sh
```

run it
- paste the whole block above into the vm
- press enter through prompts and fill in simple values

screenshots to take
- ldapsearch output with cn and uid
- exportfs -v
- ls -l /mnt/nfs_shared showing test_from_client.txt

short answers
ldap
1 what is ldap
a central list of users and groups
2 how do you test ldap
use ldapsearch with base dn
3 how do you add a user
make an ldif then run ldapadd
4 how to secure ldap
use tls and strong admin password

nfs
1 what is nfs
it shares a folder over the network
2 how to export a folder
add a line to etc exports then run exportfs
3 how to mount on a client
use mount server colon path space mount point
4 why root squash
it makes remote root less powerful

software managers
1 what is apt
a tool to install and update software on debian and ubuntu
2 what is snap
apps that bundle what they need and auto update
3 what is flatpak
apps that run in a safe box and work on many linux
4 what is appimage
one file app that runs without install
5 why use docker or podman
same app runs the same on many machines
6 what to read in a tarball
readme or install file
7 why use a pre built binary
it is fast and easy

find this file on github
- path week4_to_now_all_in_one.md
- in the main branch
