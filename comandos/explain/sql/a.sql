SELECT generate_series(1, 2000000) AS campo INTO tb_teste;

CREATE INDEX idx_teste_comum ON tb_teste (campo);

CREATE INDEX idx_teste_div19 ON tb_teste (campo) WHERE campo % 19 = 0;

EXPLAIN SELECT campo FROM tb_teste WHERE campo = 975421;

EXPLAIN ANALYZE SELECT campo FROM tb_teste WHERE campo = 975421;

EXPLAIN SELECT count(*) FROM tb_teste WHERE campo % 19 = 0;

EXPLAIN ANALYZE SELECT count(*) FROM tb_teste WHERE campo % 19 = 0;

XPLAIN (ANALYZE, FORMAT JSON, VERBOSE, BUFFERS) 
SELECT count(*) FROM tb_teste WHERE campo % 19 = 0;
