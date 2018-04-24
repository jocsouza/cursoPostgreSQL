CREATE DATABASE db_teste_priv;

SELECT
    generate_series(1, 15) AS campo1,
    (generate_series(1, 15) * 3) AS campo2 
    INTO tb_teste_priv;

GRANT g_teste_priv TO chiquinho, jose, marcia, silvana;

SELECT campo1, campo2 FROM tb_teste_priv LIMIT 5;

GRANT SELECT ON tb_teste_priv TO g_teste_priv;

REVOKE SELECT ON tb_teste_priv FROM g_teste_priv;

GRANT financeiro TO silvana;

GRANT comercial TO jose, marcia;

GRANT SELECT (campo1) ON tb_teste_priv TO comercial;

GRANT SELECT (campo2) ON tb_teste_priv TO financeiro;

SELECT campo1 FROM tb_teste_priv LIMIT 5;

REVOKE ALL PRIVILEGES ON DATABASE db_teste_priv FROM PUBLIC;

SELECT datacl AS "Permissões de Acesso" FROM pg_database
    WHERE datname = 'db_teste_priv';

GRANT CONNECT, CREATE, TEMPORARY ON DATABASE db_teste_priv TO g_teste_priv;

ALTER TABLE tb_teste_priv OWNER TO chiquinho;

CREATE TABLE tb_xyz(campo int);

ALTER TABLE tb_xyz OWNER TO chiquinho;

CREATE SEQUENCE sq_xyz;

ALTER SEQUENCE sq_xyz OWNER TO chiquinho;

REASSIGN OWNED BY chiquinho TO g_teste_priv;

ALTER ROLE postgres ENCRYPTED PASSWORD '123';

REASSIGN OWNED BY g_teste_priv TO postgres;

CREATE SCHEMA sc_teste_priv;
