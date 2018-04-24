psql -c "SELECT context FROM pg_settings WHERE name = 'max_wal_senders';"

pg_basebackup -P -D data.new

mv data data.old

mv data.new data

ls ${PGCONF}/* | xargs -i ln -sf {} ${PGDATA}/

psql -c 'SELECT datname FROM pg_database;'

rm -fr data.old/

pg_basebackup -P -D /tmp/data

initdb -U postgres -E utf8 -D /tmp/pgtmp

cp -f /tmp/pgtmp/*.conf /tmp/data/

pg_ctl -D /tmp/data start

pg_ctl -D /tmp/data stop

NOW=`date +%Y%m%d-%H%M`

pg_basebackup -P -Ft -z -Z 9 \
-D `dirname "${PGDATA}"`/bkp_data/${NOW}/

mkdir -pm 700 /tmp/data2

tar xf bkp_data/${NOW}/base.tar.gz -C /tmp/data2/

tar xf bkp_data/${NOW}/pg_wal.tar.gz -C /tmp/data2/pg_wal/

cp /tmp/pgtmp/*.conf /tmp/data2/

sed -i 's/\#port = 5432/port = 5433/g' /tmp/data2/postgresql.conf

chmod -R 700 /tmp/data2 && find /tmp/data2 -type f -exec chmod 0600 {} \;

pg_ctl -D /tmp/data2/ start

psql -c 'SELECT datname FROM pg_database;' -p 5433

pg_ctl -D /tmp/data2/ stop
