ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/cosine.ldif

ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/nis.ldif 

ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/inetorgperson.ldif

ADMIN_PW=`slappasswd`

TUX_PW=`slappasswd`

cat << EOF > /tmp/0.ldif
dn: olcDatabase={2}hdb,cn=config
replace: olcSuffix
olcSuffix: dc=curso,dc=dominio
-
replace: olcRootDN
olcRootDN: cn=Manager,dc=curso,dc=dominio
-
add: olcRootPW
olcRootPW: ${ADMIN_PW}
EOF

ldapmodify -Y EXTERNAL -H ldapi:/// -f /tmp/0.ldif
