if [ -f /etc/yum.repos.d/CentOS-Base.repo ]; then
    # CentOS
    sed -i 's/\(\[base\]\|\[updates\]\)/\1\nexclude=postgresql*/g' \
/etc/yum.repos.d/CentOS-Base.repo

else
    # RedHat
    sed -i 's/\(\[main\]\)/\1\nexclude=postgresql*/g' \
/etc/yum/pluginconf.d/rhnplugin.conf

fi

read -p 'Digite a versão majoritária do PostgreSQL a ser instalada: ' \
PGVERSION

rpm -Uvh https://download.postgresql.org/pub/repos/yum/10/redhat/rhel-7-x86_64/pgdg-centos10-10-2.noarch.rpm

yum install -y postgresql${PGVERSION}-server && yum clean all

systemctl enable postgresql-${PGVERSION}

/usr/pgsql-${PGVERSION}/bin/postgresql-${PGVERSION}-setup initdb

systemctl start postgresql-${PGVERSION}

rsync -v /etc/skel/.* ~postgres/

PGDATA="/var/lib/pgsql/${PGVERSION}/data"

PGCONF="/etc/pgsql/${PGVERSION}/main"

systemctl stop postgresql-${PGVERSION}

mkdir -p ${PGCONF}
