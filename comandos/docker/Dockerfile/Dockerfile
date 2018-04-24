FROM postgres:latest

ENV POSTGRES_INITDB_ARGS="-k \
-D /var/lib/postgresql/data \
-E utf8 -U postgres \
--locale=pt_BR.utf8 \
--lc-collate=pt_BR.utf8 \
--lc-monetary=pt_BR.utf8 \
--lc-messages=en_US.utf8 \
-T portuguese"\
    POSTGRES_INITDB_WALDIR='/var/lib/postgresql/pg_wal'\
    LANG="en_US.UTF-8"

RUN localedef -i pt_BR -c -f UTF-8 \
-A /usr/share/locale/locale.alias pt_BR.UTF-8 && \
usermod -s /bin/bash -d /var/lib/postgresql \
-c 'PostgreSQL System User' postgres && \
echo "\x auto\n\
\set HISTCONTROL ignoreboth\n\
\set COMP_KEYWORD_CASE upper" >> ~postgres/.psqlrc && \
chown -R postgres: ~postgres
