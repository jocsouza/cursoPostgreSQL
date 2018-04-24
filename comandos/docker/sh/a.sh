docker network create net_curso

sudo mkdir -m 770 /srv/docker && sudo chgrp docker /srv/docker

mkdir -p /srv/docker/pg/{build,data,pg_wal,log,pg_stat_tmp}

docker run -itd --name ct_tmp postgres

docker exec -it ct_tmp mkdir /tmp/conf

docker exec -it ct_tmp bash -c 'cp /var/lib/postgresql/data/*.conf /tmp/conf'

docker cp ct_tmp:/tmp/conf /srv/docker/pg/

PGUSER_ID=`docker exec -it ct_tmp id -u postgres | tr -d "\r"`

sudo chown -R ${PGUSER_ID}:docker /srv/docker/pg

sudo chmod -R g+rw /srv/docker/pg

vim /srv/docker/pg/conf/postgresql.conf

docker rm -f ct_tmp

cd /srv/docker/pg/build

vim Dockerfile

docker build -t postgres_br:v1.0 .
