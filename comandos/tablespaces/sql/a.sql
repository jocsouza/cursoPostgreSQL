CREATE TABLE tb_teste_tablespace(
  campo1 INT2,
  campo2 TEXT,
  CONSTRAINT pk_campo1_teste_tablespace PRIMARY KEY (campo1))
  TABLESPACE ts_alpha;

SELECT tablespace
    FROM pg_indexes WHERE indexname = 'pk_campo1_teste_tablespace';

DROP TABLE tb_teste_tablespace;

CREATE TABLE tb_teste_tablespace(
    campo1 INT2,
    campo2 TEXT,
    CONSTRAINT pk_campo1_teste_tablespace PRIMARY KEY (campo1)
    USING INDEX TABLESPACE ts_beta)
    TABLESPACE ts_alpha;

SELECT tablespace FROM pg_indexes WHERE indexname = 'pk_campo1_teste_tablespace';

SELECT tablespace FROM pg_tables WHERE tablename = 'tb_teste_tablespace';

ALTER TABLE tb_teste_tablespace SET TABLESPACE ts_gama;
