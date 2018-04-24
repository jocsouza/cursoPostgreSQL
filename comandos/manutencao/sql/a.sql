SELECT oid, relfilenode FROM pg_class WHERE relname = 'actor';

VACUUM actor;

VACUUM FULL actor;

SELECT oid, relfilenode FROM pg_class WHERE relname = 'actor';

VACUUM (FULL, VERBOSE, ANALYZE);

VACUUM (FULL, VERBOSE, ANALYZE) actor;

DELETE FROM actor WHERE actor_id = 201;

VACUUM (FULL, VERBOSE, ANALYZE) actor;

SELECT count(*) FROM actor;

SELECT reltuples FROM pg_class WHERE relname = 'actor';

INSERT INTO actor (first_name, last_name) VALUES ('Roberto', 'Vivar');

SELECT first_name FROM actor WHERE last_name = 'Vivar';

DELETE FROM actor WHERE last_name = 'Vivar';

SELECT (s1.setting::REAL + s2.setting::REAL + c.reltuples::REAL)
    AS "vacuum threshold"
    FROM pg_settings AS s1, pg_settings AS s2, pg_class AS c
    WHERE
        s1.name = 'autovacuum_vacuum_threshold'
        AND s2.name = 'autovacuum_vacuum_scale_factor'
        AND c.relname = 'actor';

