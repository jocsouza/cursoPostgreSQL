# arquivo de configuracao para extensão pg_stat_statements.conf
cat << EOF > /etc/pgsql/10/pg_stat_statements.conf && \
ln -sf /etc/pgsql/10/pg_stat_statements.conf $PGDATA/ && \
pg_ctl restart
# pg_stat_statements Settings
pg_stat_statements.max = 10000
pg_stat_statements.track = all
pg_stat_statements.track_utility = on
pg_stat_statements.save = on
EOF