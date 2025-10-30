VCenter Lab LDAP Server and Network Filesystems

Course: ITEC 1475
Instructor: Brian Huilman
Semester: Fall 2025

Overview
This file combines the LDAP server lab and the network filesystems lab. Follow the steps, capture required screenshots, answer the questions, and submit the document.

Deliverables
- Answers to the lab questions (copied then answered)
- Screenshots: slapd install, ldapsearch output, exportfs output, client mount and test file, /etc/fstab entry
- One short reflection paragraph

Tasks

LDAP Server
1. Install slapd and ldap-utils.
2. Configure base domain and admin password.
3. Add one test user using an LDIF file.
4. Verify with ldapsearch.
5. Optionally enable TLS and restart slapd.
#cmds
sudo apt update
sudo apt install -y slapd ldap-utils
sudo apt update
sudo apt install -y slapd ldap-utils

# optionally reconfigure interactively to set domain and admin password
sudo dpkg-reconfigure slapd

# create test user LDIF
cat > /tmp/test_user.ldif <<'LDIF'
dn: uid=testuser,ou=people,dc=example,dc=edu
objectClass: inetOrgPerson
sn: User
cn: Test User
uid: testuser
userPassword: password
LDIF

# add the test user (will prompt for admin password)
sudo ldapadd -x -D "cn=admin,dc=example,dc=edu" -W -f /tmp/test_user.ldif

# verify the user exists
ldapsearch -x -LLL -H ldap://localhost -b dc=example,dc=edu "(uid=testuser)" cn uid
# optionally reconfigure interactively to set domain and admin password
sudo dpkg-reconfigure slapd

# create test user LDIF
cat > /tmp/test_user.ldif <<'LDIF'
dn: uid=testuser,ou=people,dc=example,dc=edu
objectClass: inetOrgPerson
sn: User
cn: Test User
uid: testuser
userPassword: password
LDIF

# add the test user (will prompt for admin password)
sudo ldapadd -x -D "cn=admin,dc=example,dc=edu" -W -f /tmp/test_user.ldif

# verify the user exists
ldapsearch -x -LLL -H ldap://localhost -b dc=example,dc=edu "(uid=testuser)" cn uid
Network Filesystems
1. Install nfs-kernel-server on server VM.
2. Create and export /srv/nfs/shared.
3. Mount the export on a client VM.
4. Test read and write from the client.
5. Add an /etc/fstab entry for persistence.

#cmds

Short answers to lab questions

Question 1: What command would you use to search for available web server packages?
Answer: Use apt search with a keyword. Example:
apt search apache2

Question 2: What is the main difference between APT and YUM/DNF package managers?
Answer: APT is for Debian based systems. YUM and DNF are for RedHat based systems.

Question 3: What are two advantages of using Snap packages compared to traditional package managers?
Answer: Snaps bundle dependencies. Snaps update automatically and roll back easily.

Question 4: How do Flatpak and Snap differ in their approach to application sandboxing?
Answer: Flatpak uses runtimes and portal based permissions. Snap uses confinement via AppArmor and packaged dependencies.

Question 5: What makes AppImage different from Snap and Flatpak?
Answer: AppImage is a single executable file. No install required and no auto updates by default.

Question 6: In what scenarios would an AppImage be more useful than a Snap or Flatpak package?
Answer: When you need a portable app that runs without root on many distributions.

Question 7: What is the primary difference between a Docker container and a virtual machine?
Answer: Containers share the host kernel and are lightweight. VMs include a full guest OS and more isolation.

Question 9: After extracting a tarball, what file(s) should you look for to find installation instructions?
Answer: Look for README or INSTALL files, or a configure script.

Question 10: What command installs the compiler and build tools needed to compile programs from source?
Answer: sudo apt install build-essential

Question 11: Why might you prefer installing a pre-compiled binary over compiling from source?
Answer: It is faster and avoids installing build dependencies.

Question 12: Comparison table of package methods

| Method | Advantage | Disadvantage |
| APT YUM | Well integrated, reliable updates | Package versions may lag |
| Snap | Bundles deps, auto updates | Larger disk use, confinement issues |
| Flatpak | Good sandboxing, cross distro | Needs runtimes, larger disk use |
| AppImage | Portable, no install | No auto updates, not integrated |
| Docker | Consistent runtime, isolation | Overhead for system services |
| Tarball | Simple distribution | Manual install and updates |
| Source code | Full control, optimizable | Requires build tools and time |

Question 13: Recommendations
- System administrator managing many servers: Use APT or YUM with configuration management.
- Developer testing across distributions: Use Docker or containers for consistent environments.
- User who wants latest version: Use Snap Flatpak or AppImage depending on the app and distro.

Question 14: What security considerations should you keep in mind when installing software from different sources?
Answer: Verify sources and signatures. Use TLS for directory services. Restrict NFS exports to trusted IPs. Use firewall rules and least privilege.

Question 15: Why read the whole lab first?
Answer: Reading first prevents missing prerequisites, installing packages in the wrong order, and misconfiguring TLS or exports. Examples: TLS certificates must be prepared before enabling TLS. Exports should restrict clients to correct IPs. Some installs need build tools first.

Minimal reflection
LDAP centralizes user data and should be secured with TLS. NFS is simple for file sharing but needs export restrictions and root squashing. Use the right tool for the use case.

VM bulk commands to run (run on the correct VM; replace placeholders)

LDAP server setup (server VM)
```bash
sudo apt update
sudo apt install -y slapd ldap-utils
sudo dpkg-reconfigure slapd
cat > /tmp/test_user.ldif <<'LDIF'
dn: uid=testuser,ou=people,dc=example,dc=edu
objectClass: inetOrgPerson
sn: User
cn: Test User
uid: testuser
userPassword: password
LDIF
sudo ldapadd -x -D "cn=admin,dc=example,dc=edu" -W -f /tmp/test_user.ldif
ldapsearch -x -LLL -H ldap://localhost -b dc=example,dc=edu "(uid=testuser)" cn uid