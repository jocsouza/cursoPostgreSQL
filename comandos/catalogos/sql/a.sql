SELECT indexname, indexdef FROM pg_indexes WHERE tablename = 'actor';

SELECT rolname FROM pg_catalog.pg_authid WHERE rolsuper;

SELECT datname FROM pg_database WHERE datname !~ 'postgres|^template.';

CREATE ROLE financeiro;

CREATE ROLE marcia LOGIN;

CREATE ROLE alice IN ROLE financeiro LOGIN;

CREATE ROLE zeninguem LOGIN;

GRANT financeiro TO marcia WITH ADMIN OPTION;

TABLE pg_auth_members;

SELECT usename FROM pg_user;

SELECT groname FROM pg_group;

SELECT definition FROM pg_views WHERE viewname = 'pg_indexes';
