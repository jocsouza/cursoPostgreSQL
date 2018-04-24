sysctl kernel.sem

sysctl vm.swappiness

free -m

echo 'vm.swappiness = 1' >> /etc/sysctl.conf

echo 'vm.overcommit_memory = 2' >> /etc/sysctl.conf

sysctl -p

vim ${PGDATA}/postgresql.conf

pg_ctl restart

vim ${PGDATA}/postgresql.conf

pg_ctl restart
