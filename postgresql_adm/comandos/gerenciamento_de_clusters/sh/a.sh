initdb -U postgres -E utf8 -D /tmp/cluster2

sed -i 's/\#port = 5432/port = 5433/g' \
/tmp/cluster2/postgresql.conf && pg_ctl -D /tmp/cluster2 start

psql -p 5433 -c "ALTER ROLE postgres ENCRYPTED PASSWORD '123';"

psql -p 5433 -c "CREATE ROLE zezinho LOGIN ENCRYPTED PASSWORD '123';"

echo 'local all all md5' > /tmp/cluster2/pg_hba.conf

pg_ctl -D /tmp/cluster2 reload

psql -p 5433

cat << EOF > ~/.pgpass 
# hostname:port:database:username:password
localhost:5433:*:postgres:123
localhost:5433:*:zezinho:1234
EOF

chmod 0600 ~/.pgpass

psql -U zezinho -p 5433 postgres

cat << EOF > ~/.pg_service.conf
# comentário
# bla bla bla bla
[mydb]
host=localhost
port=5432
user=postgres
dbname=template1
application_name=teste_pg_service
EOF

cat << EOF > ${PGDATA}/pg_hba.conf
local all all trust
host all all 127.0.0.1/32 trust
host all all ::1/128 trust
EOF

pg_ctl reload
