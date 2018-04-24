echo -e "\ntmpfs ${PG_STATS_TEMP} tmpfs \
size=${PG_STATS_TEMP_SIZE},uid=postgres,gid=postgres 0 0" >> /etc/fstab

mount -a

PYTHON_PKG=`yum search python3 | egrep '^python3.\.x86_64' | awk '{print $1}' \
| sort | tail -1 | cut -f1 -d.`

PYTHON_PKG="${PYTHON_PKG} ${PYTHON_PKG}-devel"

PKG="bison gcc flex gettext make readline-devel openssl-devel libxml2-devel \
openldap-devel perl-devel perl-ExtUtils-MakeMaker \
perl-ExtUtils-Embed"

yum -y install ${PKG} ${PYTHON_PKG} && yum clean all

export PYTHON="/usr/bin/`ls /usr/bin/python3* | \
sed 's:/usr/bin/::g' | egrep '\.[0-9]$'`"

mv /tmp/postgresql-${PGVERSIONXY}.tar.bz2 ${PG_INSTALL_DIR}/src/

tar xf ${PG_INSTALL_DIR}/src/postgresql-${PGVERSIONXY}.tar.bz2 \
-C ${PG_INSTALL_DIR}/src/

CPPFLAGS="-DLINUX_OOM_SCORE_ADJ=0"

MAKEOPTS="-j`expr \`cat /proc/cpuinfo | egrep ^processor | wc -l\` + 1`"

CFLAGS="-march=native -O2 -pipe" && CXXFLAGS="$CFLAGS"

CONFIGURE_OPTS="
--prefix=${PG_INSTALL_DIR} \
--with-perl \
--with-python \
--with-libxml \
--with-openssl \
--with-ldap \
--mandir=/usr/local/pgsql/${PGVERSION}/man \
--docdir=/usr/local/pgsql/${PGVERSION}/doc"

cd ${PG_INSTALL_DIR}/src/postgresql-${PGVERSIONXY}

./configure ${CONFIGURE_OPTS} && make world && make install-world
