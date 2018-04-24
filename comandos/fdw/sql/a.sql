CREATE DATABASE db_teste2;

CREATE TABLE tb_teste( 
    id SERIAL PRIMARY KEY, 
    campo_a INT, 
    campo_b VARCHAR(10));

CREATE DATABASE db_teste1;

CREATE EXTENSION postgres_fdw;

CREATE SERVER srv_srv2
    FOREIGN DATA WRAPPER postgres_fdw
    OPTIONS (host '192.168.56.3', dbname 'db_teste2', port '5432');

CREATE USER MAPPING FOR postgres
    SERVER srv_srv2
    OPTIONS (user 'postgres', password '123');

CREATE FOREIGN TABLE tb_fdw_teste( 
    id SERIAL, 
    campo_a INT, 
    campo_b VARCHAR(10)) 
    SERVER srv_srv2 
    OPTIONS (table_name 'tb_teste', updatable 'true');

INSERT INTO tb_fdw_teste (campo_a, campo_b) VALUES (700, 'foo');

SELECT * FROM tb_fdw_teste;

SELECT * FROM tb_teste;

DROP FOREIGN TABLE tb_fdw_teste; -- Apaga a tabela estrangeira

DROP USER MAPPING FOR postgres SERVER srv_srv2;  -- Apaga o mapeamento de usuário

DROP SERVER srv_srv2; -- Apaga a configuração de servidor

DROP EXTENSION postgres_fdw; -- Desabilita a extensão na base de dados

CREATE USER 'postgres'@'192.168.56.2' IDENTIFIED BY '123';

GRANT ALL PRIVILEGES ON db_teste2.* TO 'postgres'@'192.168.56.2';

CREATE TABLE tb_teste(
	id INT AUTO_INCREMENT PRIMARY KEY, 
	campo_a INT, 
	campo_b VARCHAR(10));
