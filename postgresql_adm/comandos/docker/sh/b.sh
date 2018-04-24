docker run -itd \
    --memory 1g \
    --memory-swappiness 1 \
    --memory-swap 256m \
    --restart=always \
    --name pg \
    --hostname pg.local \
    -p 5433:5432 \
    --network net_curso \
    --volume /srv/docker/pg/conf:/etc/postgresql:ro \
    --volume /srv/docker/pg/data:/var/lib/postgresql/data \
    --volume /srv/docker/pg/pg_wal:/var/lib/postgresql/pg_wal \
    --volume /srv/docker/pg/log:/var/log/postgresql \
    --tmpfs /var/lib/postgresql/pg_stat_tmp:size=32M,mode=0770 \
    postgres_br:v1.0 postgres -c 'config_file=/etc/postgresql/postgresql.conf'

sudo netstat -nltp | fgrep 5433

docker exec -itu postgres pg rm -fr \
    /var/lib/postgresql/data/{pg_stat_tmp,log,*.conf}

docker exec -itu postgres pg psql -Atqc 'SELECT version();'

docker rm -f pg

docker network rm net_curso

vim docker-compose.yml
