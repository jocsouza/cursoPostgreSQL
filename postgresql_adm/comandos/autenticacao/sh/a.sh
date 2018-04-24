su - postgres

cd ${PGCONF}

cp pg_hba.conf pg_hba.conf.bkp

cat << EOF > pg_hba.conf && pg_ctl reload && clear && cat pg_hba.conf
local all all trust
EOF

psql -c "ALTER ROLE postgres ENCRYPTED PASSWORD '123';"

cat << EOF > pg_hba.conf && pg_ctl reload && clear && cat pg_hba.conf
local all all trust
local all all md5
EOF

psql -c "SELECT 'OK' AS teste;"

cat << EOF > pg_hba.conf && pg_ctl reload && clear && cat pg_hba.conf
local all all md5
local all all trust
EOF

cat << EOF > pg_hba.conf && pg_ctl reload && clear && cat pg_hba.conf
local all all trust
local all all reject
EOF

cat << EOF > pg_hba.conf && pg_ctl reload && clear && cat pg_hba.conf
local all all reject
local all all trust
EOF

cat pg_hba.conf.bkp > pg_hba.conf && pg_ctl reload

yum install -y openldap-{servers,clients} && yum clean all

cp /usr/share/openldap-servers/DB_CONFIG.example /var/lib/ldap/DB_CONFIG

chown ldap:ldap /var/lib/ldap/DB_CONFIG

systemctl enable slapd

systemctl start slapd
