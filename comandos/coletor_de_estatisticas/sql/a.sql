SELECT pid, wait_event, state, query FROM pg_stat_activity;

BEGIN;

SELECT pid, wait_event, state, query FROM pg_stat_activity; 

SELECT generate_series(1, 1000000000) AS campo INTO tb_teste;

SELECT TRUE;

ROLLBACK;

SELECT count(pid) FROM pg_stat_activity;

SELECT checkpoints_req FROM pg_stat_bgwriter;

SELECT generate_series(1, 7000000) AS campo INTO tb_teste;

DROP TABLE tb_teste;

CHECKPOINT;

SELECT numbackends FROM pg_stat_database WHERE datname = 'postgres';

SELECT 
    xact_commit, xact_rollback, blks_read, blks_hit, tup_deleted
    FROM pg_stat_database
    WHERE datname = 'postgres';

CREATE TABLE tb_carro(
    id smallserial,
    marca varchar(15),
    modelo varchar(15),
    cor varchar(15));

INSERT INTO tb_carro (marca, modelo, cor) values
    ('Fiat', '147', 'amarelo'),
    ('Volkswagen', 'Fusca', 'preto');

DELETE FROM tb_carro WHERE id = 2;

DROP TABLE tb_carro;
