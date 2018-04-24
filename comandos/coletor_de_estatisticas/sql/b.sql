SELECT 
    n_tup_ins, n_tup_upd, n_tup_del, n_tup_hot_upd, n_dead_tup
    FROM pg_stat_all_tables
    WHERE relname = 'tb_carro';

INSERT INTO tb_carro (marca, modelo, cor) values
    ('Fiat', '147', 'amarelo'),
    ('Volkswagen', 'Fusca', 'preto');

UPDATE tb_carro SET cor = 'azul' WHERE id = 1;

VACUUM tb_carro;

SELECT 
    n_live_tup, n_dead_tup, n_dead_tup, autovacuum_count, analyze_count, autoanalyze_count
    FROM pg_stat_all_tables
    WHERE relname = 'tb_carro';

SELECT generate_series(1, 2000000) AS campo INTO tb_teste;

CREATE INDEX idx_teste_comum ON tb_teste (campo);

CREATE INDEX idx_teste_div19 ON tb_teste (campo) WHERE campo % 19 = 0;

SELECT
    indexrelname, idx_scan, idx_tup_read, idx_tup_fetch 
    FROM pg_stat_all_indexes 
    WHERE relname = 'tb_teste';

SELECT campo FROM tb_teste WHERE campo = 547889;

SELECT
    indexrelname, idx_scan, idx_tup_read, idx_tup_fetch 
    FROM pg_stat_all_indexes 
    WHERE relname = 'tb_teste';

SELECT count(*) FROM tb_teste WHERE campo % 19 = 0;

SELECT
    heap_blks_read, heap_blks_hit, idx_blks_read, idx_blks_hit
    FROM pg_statio_all_tables
    WHERE relname = 'tb_teste';
