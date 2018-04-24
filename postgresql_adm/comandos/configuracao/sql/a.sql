SHOW port;

SET application_name = 'minha_aplicacao';

SHOW shared_buffers;

SELECT setting, context, vartype, unit FROM pg_settings
    WHERE name = 'shared_buffers';

SELECT 
    ((setting::int * 8) / 1024) "shared_buffers (MB)" 
    FROM pg_settings WHERE name = 'shared_buffers';

SHOW application_name;

SET application_name = 'curso_adm_postgres'; 

SELECT setting, context, vartype, unit FROM pg_settings
    WHERE name = 'application_name';

ALTER SYSTEM SET port = 5432;

ALTER SYSTEM SET log_min_duration_statement = '5s';

ALTER SYSTEM SET port TO DEFAULT;

ALTER SYSTEM SET log_min_duration_statement TO DEFAULT;

ALTER SYSTEM SET wal_level = 'cold_standby';
