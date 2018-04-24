chown -R postgres: ${PGCONF} ${PGLOG} ${PG_WAL} ${PGDATA} \
${PG_STATS_TEMP} ~postgres

su - postgres -c "initdb ${INITDB_OPTS}"

su - postgres -c "mv ${PGDATA}/*.conf ${PGCONF}/"

su - postgres -c "ls ${PGCONF}/* | xargs -i ln -sf {} ${PGDATA}/"

sed "s:\(^#listen_addresses.*\):\1\nlisten_addresses = '*':g" \
-i ${PGCONF}/postgresql.conf

sed "s:\(^#log_destination.*\):\1\nlog_destination = 'stderr':g" \
-i ${PGCONF}/postgresql.conf

sed "s:\(^#logging_collector.*\):\1\nlogging_collector = on:g" \
-i ${PGCONF}/postgresql.conf

sed "s:\(^#\)\(log_filename.*\):\1\2\n\2:g" \
-i ${PGCONF}/postgresql.conf

sed "s:\(^#log_directory.*\):\1\nlog_directory = '${PGLOG}':g" \
-i ${PGCONF}/postgresql.conf

sed "s:\(^#stats_temp_directory.*\):\1\nstats_temp_directory = \
'${PG_STATS_TEMP}':g" -i ${PGCONF}/postgresql.conf

systemctl start postgresql-${PGVERSION}

su - postgres -c "cat << EOF > ~/.psqlrc
\set HISTCONTROL ignoredups
\set COMP_KEYWORD_CASE upper
\x auto
EOF
"

yum erase -y ${PKG}

su - postgres -c "psql -c 'SELECT true;'"
