SELECT datid
    FROM pg_stat_database
    WHERE datname = 'postgres';

SELECT oid
    FROM pg_database
    WHERE datname = 'postgres';

CREATE TABLE tb_tmp(id serial PRIMARY KEY);

SELECT oid, relfilenode, relname, relkind
    FROM pg_class WHERE relname ~ 'tb_tmp' ORDER BY oid;

VACUUM FULL tb_tmp;

SELECT oid, relfilenode, relname, relkind
    FROM pg_class WHERE relname ~ 'tb_tmp' ORDER BY oid;

TRUNCATE tb_tmp RESTART IDENTITY;

SELECT oid, relfilenode, relname, relkind
    FROM pg_class WHERE relname ~ 'tb_tmp' ORDER BY oid;

SELECT
    relname "Nome do objeto",
    CASE relkind
        WHEN 'r' THEN 'tabela comum'
        WHEN 'i' THEN 'índice'
        WHEN 'S' THEN 'sequência'
        WHEN 'v' THEN 'visão'
        WHEN 'c' THEN 'tipo composto'
        WHEN 't' THEN 'tabela TOAST'        
	WHEN 'p' THEN 'tabela particionada'
        ELSE '---'
    END "Tipo de objeto"
    FROM pg_class WHERE relfilenode = 16413;
