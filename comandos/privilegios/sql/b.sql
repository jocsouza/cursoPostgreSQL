CREATE TABLE sc_teste_priv.tb_teste1(campo int);

CREATE TABLE sc_teste_priv.tb_teste2(campo int);

CREATE TABLE sc_teste_priv.tb_teste3(campo int);

SELECT * FROM sc_teste_priv.tb_teste1 LIMIT 5;

GRANT USAGE ON SCHEMA sc_teste_priv TO silvana;

SELECT * FROM sc_teste_priv.tb_teste1;

SELECT has_table_privilege('silvana', 'sc_teste_priv.tb_teste1', 'SELECT');

GRANT SELECT ON ALL TABLES IN SCHEMA sc_teste_priv TO silvana;

SELECT * FROM sc_teste_priv.tb_teste2;

SELECT * FROM sc_teste_priv.tb_teste3;

GRANT SELECT ON ALL TABLES IN SCHEMA sc_teste_priv TO marcia;

SELECT has_table_privilege('marcia','sc_teste_priv.tb_teste1','SELECT');

GRANT USAGE ON SCHEMA sc_teste_priv TO marcia;

GRANT USAGE ON SCHEMA sc_teste_priv TO jose;

GRANT SELECT ON ALL TABLES IN SCHEMA sc_teste_priv TO jose;

DROP ROLE jose;

REVOKE ALL ON ALL TABLES IN SCHEMA sc_teste_priv FROM jose;

REVOKE ALL ON SCHEMA sc_teste_priv FROM jose;
