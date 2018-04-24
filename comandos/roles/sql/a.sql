CREATE ROLE financeiro;

CREATE ROLE comercial;

CREATE ROLE marcia LOGIN;

CREATE ROLE jose LOGIN;

CREATE ROLE silvana LOGIN;

CREATE ROLE chiquinho LOGIN IN ROLE comercial, financeiro;

CREATE ROLE g_teste_priv;

ALTER ROLE chiquinho PASSWORD '123';

ALTER ROLE jose PASSWORD '123';

ALTER ROLE marcia PASSWORD '123';

ALTER ROLE silvana PASSWORD '123';

SELECT current_user;

SET role marcia;

SELECT current_user;

CREATE ROLE user_foo LOGIN;

ALTER ROLE user_foo SET work_mem = '77MB';

ALTER ROLE user_foo SET log_min_duration_statement = 0;

SELECT rolconfig FROM pg_roles WHERE rolname = 'user_foo';

SHOW log_min_duration_statement;

SHOW work_mem;

SELECT name, pg_size_pretty(setting::int8 * 1024)
    FROM pg_settings
    WHERE name IN ('log_min_duration_statement', 'work_mem');

ALTER ROLE user_foo SET log_min_duration_statement  = -1;
