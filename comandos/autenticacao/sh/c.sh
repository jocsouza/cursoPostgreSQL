cat << EOF > /tmp/1.ldif
dn: dc=curso,dc=dominio
dc: curso
objectClass: dcObject
objectClass: organizationalUnit
ou: Curso PostgreSQL - Administração

# dbuser ou      
dn: ou=dbuser,dc=curso,dc=dominio
ou: dbuser
objectClass: organizationalUnit
objectClass: top

# tux uid
dn: uid=tux,ou=dbuser,dc=curso,dc=dominio
uid: tux
cn: tux
objectClass: account
objectClass: posixAccount
objectClass: top
objectClass: shadowAccount
userPassword: ${TUX_PW}
shadowLastChange: 15140
shadowMin: 0
shadowMax: 99999
shadowWarning: 7
loginShell: /bin/false
homeDirectory: /dev/null
uidNumber: 10000
gidNumber: 10000
EOF
