CREATE DATABASE db_teste1;

CREATE EXTENSION mysql_fdw;

CREATE SERVER srv_mysql 
    FOREIGN DATA WRAPPER mysql_fdw
    OPTIONS (host '192.168.56.3', port '3306');

CREATE USER MAPPING FOR postgres SERVER srv_mysql 
    OPTIONS (username 'postgres', password '123');

CREATE FOREIGN TABLE ft_teste( 
    id INT, 
    campo_a INT, 
    campo_b VARCHAR(10)) 
    SERVER srv_mysql 
        OPTIONS (dbname 'db_teste2', table_name 'tb_teste');

INSERT INTO ft_teste (campo_a, campo_b) VALUES (500, 'bar');

SELECT * FROM ft_teste;

SELECT * FROM tb_teste;

CREATE EXTENSION file_fdw;

CREATE SERVER srv_srv1_file_fdw FOREIGN DATA WRAPPER file_fdw;

CREATE FOREIGN TABLE ft_capitais_sudeste(
    id char(2),
    nome VARCHAR(50),
    populacao INT)
    SERVER srv_srv1_file_fdw
    OPTIONS (filename '/tmp/capitais_sudeste.csv', format 'csv', delimiter ';');

SELECT id, nome, populacao FROM ft_capitais_sudeste;

SELECT id, nome, populacao FROM ft_capitais_sudeste;
