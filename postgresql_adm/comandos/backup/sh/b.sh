sed -i 's/\#port = 5432/port = 5433/g' /tmp/cluster2/postgresql.conf

pg_ctl -D /tmp/cluster2/ start

psql -p 5433 -U postgres -c 'SELECT datname FROM pg_database;'

pg_dumpall | psql -p 5433 -U postgres

psql -p 5433 -U postgres -c \
'SELECT relname tabela FROM pg_stat_user_tables ORDER by tabela LIMIT 5' pagila

pg_dumpall > /tmp/cluster.dump.sql

pg_dumpall | bzip2 -9 -c > /tmp/cluster.dump.sql.bz2

ls -lh /tmp/cluster.* | awk '{print $(NF) " => " $5}'

pg_ctl -D /tmp/cluster2 -m immediate stop && rm -fr /tmp/cluster2

initdb -U postgres -D /tmp/cluster2

sed -i 's/\#port = 5432/port = 5433/g' /tmp/cluster2/postgresql.conf

pg_ctl -D /tmp/cluster2/ start

time psql -p 5433 -f /tmp/cluster.dump.sql

pg_ctl -D /tmp/cluster2 -m immediate stop && \
rm -fr /tmp/cluster2

sed -i 's/\#port = 5432/port = 5433/g' \
/tmp/cluster2/postgresql.conf

time bunzip2 -dc /tmp/cluster.dump.sql.bz2 | psql -p 5433 

pg_ctl -D /tmp/cluster2/ stop

pg_ctl stop

cd `dirname "${PGDATA}"`

tar cvzf /tmp/cluster.tar.gz `basename ${PGDATA}`

tar xvf /tmp/cluster.tar.gz -C /tmp/

vim /tmp/data/postgresql.conf
