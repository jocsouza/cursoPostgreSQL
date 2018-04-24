vim ${PGDATA}/postgresql.conf && pg_ctl restart

createdb db_bench

psql -Atqc 'CREATE EXTENSION pg_stat_statements;' db_bench

psql -Atqc 'SELECT pg_stat_statements_reset();' db_bench

pgbench -i db_bench

pgbench -c10 -t300 db_bench

psql db_bench

export PYTHON="/usr/bin/`ls /usr/bin/python3* | \
sed 's:/usr/bin/::g' | egrep '\.[0-9]$'`"

wget -qO- https://bootstrap.pypa.io/get-pip.py | ${PYTHON}

pip install pgxnclient

export PATH="${PATH}:`dirname \`su - postgres -c 'which pg_config'\``"

yum install -y make gcc

pgxnclient install shacrypt

createdb db_shacrypt && psql db_shacrypt


