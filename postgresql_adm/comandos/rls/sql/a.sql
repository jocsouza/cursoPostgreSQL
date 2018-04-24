CREATE DATABASE db_rls;

CREATE ROLE admin LOGIN; -- Administrador

CREATE ROLE alice LOGIN; -- Usuário comum

CREATE ROLE joana LOGIN; -- Usuário comum

CREATE TABLE tb_usuario(
    username text PRIMARY KEY, -- Usuário
    pw TEXT, -- Senha
    nome_real text NOT NULL, -- Nome
    shell text NOT NULL -- Shell
);

INSERT INTO tb_usuario VALUES
    ('admin', '###', 'Administrador', '/bin/tcsh'),
    ('alice', '###', 'Alice', '/bin/bash'),
    ('joana', '###', 'Joana', '/bin/zsh');

GRANT SELECT, INSERT, UPDATE, DELETE ON tb_usuario TO admin;

GRANT SELECT (username, nome_real, shell) ON tb_usuario TO PUBLIC;

GRANT UPDATE (pw, username, nome_real, shell) ON tb_usuario TO PUBLIC;

TABLE tb_usuario;

ALTER TABLE tb_usuario ENABLE ROW LEVEL SECURITY;

SET role admin;

SELECT current_user;

TABLE tb_usuario;

CREATE POLICY po_admin_all_priv_usuario
    ON tb_usuario
    TO admin
    USING (true)
    WITH CHECK (true);

SET role alice;
