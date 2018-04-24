pg_ctl -D /tmp/data start

psql -c 'SELECT datname FROM pg_database;'

pg_ctl -D /tmp/data/ stop

pg_ctl start

psql -c "SELECT name, setting, context FROM pg_settings \
WHERE name IN ('wal_level', 'archive_mode', 'archive_command');"

mkdir -pm 700 `dirname "${PGDATA}"`/bkp_{data,wal}

vim ${PGDATA}/postgresql.conf

pg_ctl restart

NOW=`date +%Y%m%d-%H%M`

echo ${NOW}

CHKPNT_START=`psql -Atqc "SELECT pg_start_backup('${NOW}');"`

echo ${CHKPNT_START}

cat ${PGDATA}/backup_label

rm -fr ${PGDATA}

tar -xvf `dirname "${PGDATA}"`/bkp_data/cluster.tar.gz \
-C `dirname "${PGDATA}"`/

ls ${PGCONF}/* | xargs -i ln -sf {} ${PGDATA}/

psql -c 'SELECT datname FROM pg_database;'

cd `dirname "${PGDATA}"`

pg_basebackup -P -D data.new

echo 'local    replication    postgres    trust' >> ${PGDATA}/pg_hba.conf

pg_ctl reload

pg_basebackup -P -D data.new

vim ${PGDATA}/postgresql.conf
