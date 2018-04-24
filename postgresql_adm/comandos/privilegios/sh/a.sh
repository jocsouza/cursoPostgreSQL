cat << EOF > ${PGDATA}/pg_hba.conf
local    all               postgres               trust
local    db_teste_priv     +g_teste_priv          md5 
EOF

pg_ctl reload && psql

cat << EOF > ${PGDATA}/pg_hba.conf
local    all               postgres              md5
local    db_teste_priv     +g_teste_priv         md5 
EOF

pg_ctl reload && $ psql db_teste_priv
