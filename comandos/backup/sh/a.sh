createdb pagila

wget -c \
http://pgfoundry.org/frs/download.php/1719/pagila-0.10.1.zip \
-O ~/pagila.zip

unzip ~/pagila.zip -d /tmp/

psql -f /tmp/pagila-0.10.1/pagila-schema.sql pagila

psql -f /tmp/pagila-0.10.1/pagila-data.sql pagila

psql -c "SELECT relname tabela FROM pg_stat_user_tables \
ORDER by tabela LIMIT 5;" pagila

mkdir -pm 700 /tmp/pg_dumps/{texto,custom,tar,compact}

pg_dump -j7 -Fd pagila -f /tmp/pg_dumps/diretorio

dropdb pagila && createdb pagila

pg_restore -d pagila -Fd /tmp/pg_dumps/diretorio

pg_dump -Ft pagila > /tmp/pg_dumps/tar/pagila.tar

pg_restore -d pagila -Ft /tmp/pg_dumps/tar/pagila.tar

pg_dump -Fc pagila > /tmp/pg_dumps/custom/pagila.dump

pg_restore -j5 -d pagila -Fc /tmp/pg_dumps/custom/pagila.dump

pg_dump -C pagila > /tmp/pg_dumps/texto/pagila.sql

dropdb pagila

psql -f /tmp/pg_dumps/texto/pagila.sql

pg_dump -C pagila | gzip -9 > /tmp/pg_dumps/compact/pagila.gz

gunzip -c /tmp/pg_dumps/compact/pagila.gz | psql

pg_dump -C pagila | bzip2 -9 > /tmp/pg_dumps/compact/pagila.bz2

bunzip2 -c /tmp/pg_dumps/compact/pagila.bz2 | psql

initdb -U postgres -D /tmp/cluster2
