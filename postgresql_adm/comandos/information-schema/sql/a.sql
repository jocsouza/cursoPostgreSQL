CREATE TABLE tb_teste(
    id serial primary key,
    campo1 int2,
    campo2 int4,
    campo3 int8,
    campo4 text);

SELECT column_name, data_type
    FROM information_schema.columns
    WHERE table_name = 'tb_teste'
        AND table_schema = 'public';
