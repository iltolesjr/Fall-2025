#!/usr/bin/env bash
set -euo pipefail

dnf -y install openldap-servers openldap-clients

# db config
if [[ ! -f /var/lib/ldap/DB_CONFIG ]]; then
  cp /usr/share/openldap-servers/DB_CONFIG.example /var/lib/ldap/DB_CONFIG
  chown ldap:ldap /var/lib/ldap/DB_CONFIG
fi

systemctl enable --now slapd

# firewall
firewall-cmd --permanent --add-service=ldap || true
firewall-cmd --reload || true

# configure suffix and rootdn via cn=config overlay
PASS_HASH=$(slappasswd -s 1212)
cat >/tmp/db.ldif <<EOF
DN: olcDatabase={2}mdb,cn=config
changetype: modify
replace: olcSuffix
olcSuffix: dc=lab,dc=local
-
replace: olcRootDN
olcRootDN: cn=Manager,dc=lab,dc=local
-
replace: olcRootPW
olcRootPW: ${PASS_HASH}
EOF

ldapmodify -Y EXTERNAL -H ldapi:/// -f /tmp/db.ldif || true

# base entries
cat >/tmp/base.ldif <<'EOF'
DN: dc=lab,dc=local
objectClass: top
objectClass: dcObject
objectClass: organization
dc: lab
o: Lab Org

DN: ou=people,dc=lab,dc=local
objectClass: top
objectClass: organizationalUnit
ou: people

DN: ou=groups,dc=lab,dc=local
objectClass: top
objectClass: organizationalUnit
ou: groups
EOF

ldapadd -x -D "cn=Manager,dc=lab,dc=local" -w 1212 -H ldap://localhost -f /tmp/base.ldif || true

# test search
ldapsearch -x -H ldap://localhost -b dc=lab,dc=local -D "cn=Manager,dc=lab,dc=local" -w 1212 -s base "(objectClass=*)" dn || true

echo "ldap helper done"
