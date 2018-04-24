cat << EOF > ~postgres/.pgvars

# Environment Variables

export PGVERSION='${PGVERSION}'
export LD_LIBRARY_PATH="/usr/local/pgsql/\${PGVERSION}/lib:\${LD_LIBRARY_PATH}" 
export MANPATH="/usr/local/pgsql/\${PGVERSION}/man:\${MANPATH}"
export PATH="/usr/local/pgsql/\${PGVERSION}/bin:\${PATH}"
export PGDATA="/var/lib/pgsql/\${PGVERSION}/data"
export PGCONF="/etc/pgsql/\${PGVERSION}"
export OOMScoreAdjust=-1000
export PG_OOM_ADJUST_FILE=/proc/self/oom_score_adj
export PG_OOM_ADJUST_VALUE=0
export PYTHONPATH="\${PYTHONPATH}:/var/lib/pgsql/\${PGVERSION}/python"
EOF

echo 'source ~/.pgvars' >> ~postgres/.bashrc

cat << EOF > /lib/systemd/system/postgresql-${PGVERSION}.service
[Unit]
Description=PostgreSQL ${PGVERSION} database server
After=syslog.target
After=network.target
[Service]
Type=forking
User=postgres
Group=postgres
Environment=PGDATA=${PGDATA}
Environment=PYTHONPATH=${PYTHONDIR}
OOMScoreAdjust=-1000    
ExecStart=${PGBIN}/pg_ctl start -D ${PGDATA} -s -w -t 300
ExecStop=${PGBIN}/pg_ctl stop -D ${PGDATA} -s -m fast
ExecReload=${PGBIN}/pg_ctl reload -D ${PGDATA} -s
OOMScoreAdjust=-1000
Environment=PG_OOM_ADJUST_FILE=/proc/self/oom_score_adj
Environment=PG_OOM_ADJUST_VALUE=0
TimeoutSec=300
[Install]
WantedBy=multi-user.target
EOF

systemctl enable postgresql-${PGVERSION}.service
