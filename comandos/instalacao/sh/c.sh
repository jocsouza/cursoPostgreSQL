groupadd -r postgres &> /dev/null

useradd -s /bin/bash -k /etc/skel -d /var/lib/pgsql \
-g postgres -m -r postgres  &> /dev/null

read -p \
'Digite o número de versão completo (X.Y) do PostgreSQL a ser baixado: ' \
PGVERSIONXY

(wget --quiet -c \
https://ftp.postgresql.org/pub/source/v${PGVERSIONXY}/\
postgresql-${PGVERSIONXY}.tar.bz2 -P /tmp/) &

PGVERSION=`echo ${PGVERSIONXY} | cut -f1 -d.`

PG_INSTALL_DIR="/usr/local/pgsql/${PGVERSION}"

PGBIN="${PG_INSTALL_DIR}/bin"

PG_LD_LIBRARY_PATH="${PG_INSTALL_DIR}/lib"

PG_MANPATH="${PG_INSTALL_DIR}/man"

PGCONF="/etc/pgsql/${PGVERSION}"

PGLOG="/var/log/pgsql/${PGVERSION}"

PGDATA="/var/lib/pgsql/${PGVERSION}/data"

PG_STATS_TEMP="/var/lib/pgsql/${PGVERSION}/pg_stat_tmp"

PG_WAL="/var/lib/pgsql/${PGVERSION}/pg_wal"

PYTHONDIR="/var/lib/pgsql/${PGVERSION}/python"

INITDB_OPTS="-k \
-D ${PGDATA} -E utf8 -U postgres \
--locale=pt_BR.utf8 \
--lc-collate=pt_BR.utf8 \
--lc-monetary=pt_BR.utf8 \
--lc-messages=en_US.utf8 \
-T portuguese \
-X ${PG_WAL}"

PG_STATS_TEMP_SIZE='32M'

mkdir -p ${PG_INSTALL_DIR}/src/ ${PGCONF} ${PGLOG} \
${PG_WAL} ${PGDATA} ${PG_STATS_TEMP} ${PYTHONDIR}
