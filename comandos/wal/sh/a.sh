pg_ctl stop

ls -lhd ${PGDATA}/pg_wal/* | egrep -v '^d' | \
awk '{print $(NF)}' | xargs chmod -w

pg_ctl start

psql -c 'CREATE DATABASE db_teste;'

ls -lhd ${PGDATA}/pg_wal/* | egrep -v '^d' | \
awk '{print $(NF)}' | xargs chmod +w

psql -c "SELECT 'OK' AS teste;"

psql -c 'CREATE TABLE tb_teste_wal();'
