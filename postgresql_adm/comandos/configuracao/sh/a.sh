netstat -nltp | fgrep postgres

echo 'port = 5433' >> ${PGDATA}/postgresql.auto.conf

cat ${PGDATA}/postgresql.auto.conf

pg_ctl restart

psql -p 5433

cat ${PGDATA}/postgresql.auto.conf
