psql -A -F ';' -c 'TABLE actor;' pagila > /tmp/pagila_actor.csv

cat << EOF > /tmp/pagila_actor.html
<!DOCTYPE HTML>
<html lang="pt-br">
<head>
<meta charset="UTF-8">
<title>Banco pagila - Tabela actor</title>
</head>
<body>
EOF

psql -H -c 'TABLE actor;' pagila >> /tmp/pagila_actor.html

echo -e "</body>\n</html>" >> /tmp/pagila_actor.html
