SELECT campo FROM tb_teste WHERE campo = 19038;

SELECT indexrelname, idx_blks_read, idx_blks_hit FROM  pg_statio_all_indexes
    WHERE relname = 'tb_teste';

SELECT campo FROM tb_teste WHERE campo = 598731;

SELECT count(*) FROM tb_teste WHERE campo % 19 = 0;

CREATE SEQUENCE sq_teste;

SELECT blks_read, blks_hit FROM pg_statio_all_sequences WHERE relname = 'sq_teste';

SELECT nextval('sq_teste');

SELECT blks_read, blks_hit FROM pg_statio_all_sequences WHERE relname = 'sq_teste';

CREATE OR REPLACE FUNCTION fc_teste(num INT) 
	RETURNS INT AS $abobrinha$   
	BEGIN
	    RETURN num ^ 3;
	END; 
	$abobrinha$ LANGUAGE plpgsql;

SELECT fc_teste(3);

SELECT calls FROM pg_stat_user_functions WHERE funcname = 'fc_teste';

SET track_functions TO pl;

SELECT
	datname,
	confl_tablespace,
	confl_lock,
	confl_snapshot,
	confl_bufferpin,
	confl_deadlock
	FROM pg_stat_database_conflicts;
