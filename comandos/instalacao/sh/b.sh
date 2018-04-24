mv ${PGDATA}/*.conf ${PGCONF}/

ls ${PGCONF}/* | xargs -i ln -sf {} ${PGDATA}/

cat << EOF > ~postgres/.pgvars 
export PGVERSION="${PGVERSION}"
export PGDATA="/var/lib/pgsql/\${PGVERSION}/data"
export PGCONF="/etc/pgsql/\${PGVERSION}/main"
export PGDATABASE='postgres'
export PGUSER='postgres'
export PATH="\${PATH}:/usr/pgsql-${PGVERSION}/bin/"
export OOMScoreAdjust=-1000
export PG_OOM_ADJUST_FILE=/proc/self/oom_score_adj
export PG_OOM_ADJUST_VALUE=0
EOF

echo 'source .pgvars' >> ~postgres/.bash_profile

chmod -R 0700 ${PGCONF} /var/lib/pgsql ~postgres

find /var/lib/pgsql ${PGCONF} -type f -exec chmod 0600 {} \;

chown -R postgres: ${PGCONF} /var/lib/pgsql ~postgres

su - postgres

pg_ctl start

psql -c 'SELECT true;'
