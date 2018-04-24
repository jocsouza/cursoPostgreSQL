CREATE TABLE tb_foo(
    id serial primary key,    
    cor text,
    qtd int2);

INSERT INTO tb_foo (cor, qtd) VALUES
    ('azul', 3),
    ('preto', 4),
    ('verde', 7);

SELECT ctid, * FROM tb_foo;

UPDATE tb_foo SET qtd = 70 WHERE cor = 'verde';

VACUUM FULL tb_foo;
