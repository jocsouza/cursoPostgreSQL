SELECT pg_stat_get_backend_pid(s.backendid) AS pid,
	pg_stat_get_backend_activity(s.backendid) AS query
	FROM (SELECT pg_stat_get_backend_idset() AS backendid) AS s;

SELECT pg_stat_get_backend_idset();

SELECT pg_stat_get_backend_activity(1);

SELECT pg_stat_get_backend_activity(2);
