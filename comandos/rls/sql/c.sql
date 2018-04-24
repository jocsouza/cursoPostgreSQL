ALTER TABLE tb_anotacao ENABLE ROW LEVEL SECURITY;

GRANT SELECT, INSERT, UPDATE, DELETE ON tb_anotacao TO admin;


GRANT UPDATE (dt, title, description),
      INSERT (dt, title, description),
      SELECT,  
      DELETE ON tb_anotacao TO PUBLIC;

GRANT USAGE ON tb_anotacao_id_seq TO PUBLIC;

CREATE POLICY po_admin_all_priv_anotacao
    ON tb_anotacao
    FOR ALL
    TO admin
    USING (true)
    WITH CHECK (true);

CREATE POLICY po_users_rw_anotacao
    ON tb_anotacao
    FOR ALL
    TO PUBLIC
    USING (current_user = username)
    WITH CHECK (current_user = username);

SET role joana;

INSERT INTO tb_anotacao (dt, title, description) VALUES 
    (now(), 'Teste', 'Primeira anotação da Joana'),
    ('2016-10-07', 'Segundo Teste', 'Segunda anotação da Joana'),
    (now() - '2 days'::interval, 'Título', 'difdopifikerm fefejkfejkej');

TABLE tb_anotacao;

INSERT INTO tb_anotacao (dt, title, description) VALUES 
    (now(), 'Teste 1', 'Primeira anotação da Alice'),
    (now() - '2 weeks'::interval, 'Título', 'difdopifikerm fefejkfejkej');
