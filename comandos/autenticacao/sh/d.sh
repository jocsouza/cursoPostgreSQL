ldapadd -c -xD 'cn=Manager,dc=curso,dc=dominio' -W -H ldapi:/// -f /tmp/1.ldif

ldapsearch -xD 'uid=tux,ou=dbuser,dc=curso,dc=dominio' -W -b \
'dc=curso,dc=dominio' $> /dev/null ; echo $?

read -p 'Digite o IP do Servidor OpenLDAP: ' SRV_OPENLDAP

read -p 'Digite IP/Máscara (XXX.XXX.XXX.XXX/XX) da rede: ' NET_ADDR

cat << EOF > ${PGDATA}/pg_hba.conf && pg_ctl reload 
local   all    postgres                          trust
host    all    all         127.0.0.1/32          md5
host    all    tux         ${NET_ADDR}    ldap \
ldapserver=${SRV_OPENLDAP} ldapbasedn="dc=curso,dc=dominio" \
ldapsearchattribute=uid
local   all    tux                               md5
EOF

psql -c 'CREATE ROLE tux LOGIN;'

psql -c "ALTER ROLE tux ENCRYPTED PASSWORD '789';"

read -p 'Digite o IP do Servidor PostgreSQL: ' SRV_PGSQL

psql -h ${SRV_PGSQL} -U tux -d template1 -c 'SELECT true;'

psql -U tux postgres -c 'SELECT true;'
