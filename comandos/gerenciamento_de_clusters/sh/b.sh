psql 'service=mydb' -c 'SHOW application_name;'

initdb -D /tmp/data -U postgres

sed -i 's/#port = 5432/port = 5433/g' /tmp/data/postgresql.conf

pg_ctl -D /tmp/data/ start

psql -U postgres -p 5433 -c 'SHOW port;'

pg_ctl -D /tmp/data/ stop

PGDATA='/tmp/data'

pg_ctl start

ls $PGDATA/base/<id da base de dados>

ls $PGDATA/base/`psql -Aqtc \
"SELECT datid FROM pg_stat_database WHERE datname = 'postgres';"`
