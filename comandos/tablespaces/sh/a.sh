cd ${HOME}

mkdir -p ${PGVERSION}/tablespaces/{ts0,ts1,ts2}

psql -c "CREATE TABLESPACE ts_alpha \
LOCATION '/var/lib/pgsql/${PGVERSION}/tablespaces/ts0';"

psql -c "CREATE TABLESPACE ts_beta \
LOCATION '/var/lib/pgsql/${PGVERSION}/tablespaces/ts1';"

psql -c "CREATE TABLESPACE ts_gama LOCATION \
 '/var/lib/pgsql/${PGVERSION}/tablespaces/ts2';"
