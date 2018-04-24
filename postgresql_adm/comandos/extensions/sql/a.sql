SELECT extname FROM pg_extension;

SELECT name, comment FROM pg_available_extensions;

SELECT
    query,
    calls,
    total_time,
    rows, 100.0 * shared_blks_hit / 
        nullif(shared_blks_hit + shared_blks_read, 0) AS hit_percent

    FROM pg_stat_statements
    ORDER BY total_time DESC LIMIT 5;

CREATE EXTENSION shacrypt;

SELECT sha256_crypt('minha_senha', 'salt_aqui');
