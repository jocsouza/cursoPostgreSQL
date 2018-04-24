SELECT username, nome_real, shell FROM tb_usuario;

CREATE POLICY po_deny_su
    ON tb_usuario
    TO postgres
    USING (false)
    WITH CHECK (false);

TABLE pg_policies;

DROP POLICY po_deny_su ON tb_usuario;

CREATE POLICY po_all_view_usuario ON tb_usuario FOR SELECT USING (true);

CREATE POLICY po_users_mod_usuario ON tb_usuario
    FOR UPDATE
    USING (current_user = username)
    WITH CHECK (
        current_user = username AND
        shell IN ('/bin/bash','/bin/sh','/bin/dash','/bin/zsh','/bin/tcsh'));

UPDATE tb_usuario SET (nome_real, shell) = ('Alice Santos', '/bin/fish');

UPDATE tb_usuario SET (nome_real, shell) = ('Alice Santos', '/bin/zsh');

CREATE TABLE tb_anotacao(
    id serial PRIMARY KEY,
    username text DEFAULT current_user
        REFERENCES tb_usuario (username),
    dt timestamptz DEFAULT now(),
    title varchar(30),
    description text);
