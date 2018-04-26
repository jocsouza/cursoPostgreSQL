read -p 'Digite a versão antiga: ' PGVERSION_OLD

read -p 'Digite a versão nova: ' PGVERSION_NEW

export PGDATAOLD="/var/lib/pgsql/${PGVERSION_OLD}/data"

export PGDATANEW="/var/lib/pgsql/${PGVERSION_NEW}/data"

export PGBINOLD="/usr/local/pgsql/${PGVERSION_OLD}/bin"

export PGBINNEW="/usr/local/pgsql/${PGVERSION_NEW}/bin"

${PGBINOLD}/pg_ctl -m i -D ${PGDATAOLD} stop

${PGBINNEW}/pg_ctl -m i -D ${PGDATANEW} stop

pg_upgrade

sed -i 's/port = 5433/port = 5432/g' ${PGDATANEW}/postgresql.conf

${PGBINNEW}/pg_ctl -m i -D ${PGDATANEW} start

./analyze_new_cluster.sh

./delete_old_cluster.sh

psql -c 'SELECT * FROM actor LIMIT 3;' pagila

systemctl disable postgresql-8.4.service
