psql -c "ALTER ROLE postgres ENCRYPTED PASSWORD '123';"

echo 'host all all 192.168.56.2/32 md5' >> ${PGDATA}/pg_hba.conf

pg_ctl reload

mysql -e 'CREATE DATABASE db_teste2;'

mysql db_teste2

yum install -y make gcc mariadb-devel

git clone https://github.com/EnterpriseDB/mysql_fdw.git /tmp/mysql_fdw

cd /tmp/mysql_fdw

source ~postgres/.pgvars

export USE_PGXS=1 && make && make install

yum erase -y make gcc mariadb-devel

echo '/usr/lib64/mysql' > /etc/ld.so.conf.d/mysql.conf

ldconfig

cat << EOF > /tmp/capitais_sudeste.csv
SP;São Paulo;12106920
RJ;Rio de Janeiro;6520266
MG;Belo Horizonte;2523794
ES;Vitória;363140
EOF
