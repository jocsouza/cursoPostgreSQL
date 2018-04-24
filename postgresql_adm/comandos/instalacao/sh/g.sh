read -p 'Digite o endereço do Servidor PostgreSQL: ' PGSERVER

if [ ! -e ~/.ssh/id_rsa ]; then
    ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa;
fi

ssh-copy-id root@${PGSERVER}

ssh root@${PGSERVER} \
"su - postgres -c \"ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa\""

cat ~/.ssh/id_rsa.pub | \
ssh root@${PGSERVER} "cat - >> ~postgres/.ssh/authorized_keys"

ssh postgres@${PGSERVER}
