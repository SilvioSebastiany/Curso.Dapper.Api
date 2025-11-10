
CREATE TABLE ALUNOS (
    ID                  NUMBER(10) NOT NULL,
    NOME                VARCHAR2(100) ,
    EMAIL               VARCHAR2(150),
    DATA_NASCIMENTO     DATE NOT NULL,
    ATIVO               NUMBER(1) DEFAULT 1 NOT NULL,
    CURSO               VARCHAR2(100),
    TURMA               VARCHAR2(50),
    TURNO               VARCHAR2(20),
    DATA_CADASTRO       TIMESTAMP,
    DATA_ATUALIZACAO    TIMESTAMP,
    USUARIO_CADASTRO    VARCHAR2(50),
    USUARIO_ATUALIZACAO VARCHAR2(50),

    CONSTRAINT PK_ALUNOS PRIMARY KEY (ID)
);


CREATE SEQUENCE SEQ_ALUNOS_ID START WITH 1;


CREATE OR REPLACE TRIGGER TRG_ALUNOS_ID
    BEFORE INSERT ON ALUNOS
    FOR EACH ROW
BEGIN
    :NEW.ID := SEQ_ALUNOS_ID.NEXTVAL;
END;


-- =====================================================
-- INSERÇÃO DE DADOS DE EXEMPLO
-- =====================================================

-- Alunos do curso de Engenharia de Software
INSERT INTO ALUNOS (NOME, EMAIL, DATA_NASCIMENTO, CURSO, TURMA, TURNO, DATA_CADASTRO, USUARIO_CADASTRO)
VALUES ('João Silva Santos', 'joao.silva@email.com', DATE '1995-03-15', 'Engenharia de Software', 'ES-2024-1', 'NOITE', SYSTIMESTAMP, 'ADMIN');

INSERT INTO ALUNOS (NOME, EMAIL, DATA_NASCIMENTO, CURSO, TURMA, TURNO, DATA_CADASTRO, USUARIO_CADASTRO)
VALUES ('Maria Oliveira Costa', 'maria.oliveira@email.com', DATE '1998-07-22', 'Engenharia de Software', 'ES-2024-1', 'NOITE', SYSTIMESTAMP, 'ADMIN');

INSERT INTO ALUNOS (NOME, EMAIL, DATA_NASCIMENTO, CURSO, TURMA, TURNO, DATA_CADASTRO, USUARIO_CADASTRO)
VALUES ('Pedro Henrique Lima', 'pedro.lima@email.com', DATE '1997-11-08', 'Engenharia de Software', 'ES-2024-2', 'MANHÃ', SYSTIMESTAMP, 'ADMIN');

-- Alunos do curso de Ciência da Computação
INSERT INTO ALUNOS (NOME, EMAIL, DATA_NASCIMENTO, CURSO, TURMA, TURNO, DATA_CADASTRO, USUARIO_CADASTRO)
VALUES ('Ana Paula Ferreira', 'ana.ferreira@email.com', DATE '1996-01-30', 'Ciência da Computação', 'CC-2024-1', 'MANHÃ', SYSTIMESTAMP, 'ADMIN');

INSERT INTO ALUNOS (NOME, EMAIL, DATA_NASCIMENTO, CURSO, TURMA, TURNO, DATA_CADASTRO, USUARIO_CADASTRO)
VALUES ('Carlos Eduardo Souza', 'carlos.souza@email.com', DATE '1999-09-12', 'Ciência da Computação', 'CC-2024-1', 'MANHÃ', SYSTIMESTAMP, 'ADMIN');

INSERT INTO ALUNOS (NOME, EMAIL, DATA_NASCIMENTO, CURSO, TURMA, TURNO, DATA_CADASTRO, USUARIO_CADASTRO)
VALUES ('Fernanda Alves Pereira', 'fernanda.alves@email.com', DATE '1994-05-18', 'Ciência da Computação', 'CC-2024-2', 'TARDE', SYSTIMESTAMP, 'ADMIN');

-- Alunos do curso de Sistemas de Informação
INSERT INTO ALUNOS (NOME, EMAIL, DATA_NASCIMENTO, CURSO, TURMA, TURNO, DATA_CADASTRO, USUARIO_CADASTRO)
VALUES ('Ricardo Mendes Silva', 'ricardo.mendes@email.com', DATE '1993-12-03', 'Sistemas de Informação', 'SI-2024-1', 'TARDE', SYSTIMESTAMP, 'ADMIN');

INSERT INTO ALUNOS (NOME, EMAIL, DATA_NASCIMENTO, CURSO, TURMA, TURNO, DATA_CADASTRO, USUARIO_CADASTRO)
VALUES ('Juliana Santos Rodrigues', 'juliana.santos@email.com', DATE '1996-08-25', 'Sistemas de Informação', 'SI-2024-1', 'TARDE', SYSTIMESTAMP, 'ADMIN');

INSERT INTO ALUNOS (NOME, EMAIL, DATA_NASCIMENTO, CURSO, TURMA, TURNO, DATA_CADASTRO, USUARIO_CADASTRO)
VALUES ('Bruno Costa Martins', 'bruno.martins@email.com', DATE '1998-02-14', 'Sistemas de Informação', 'SI-2024-2', 'NOITE', SYSTIMESTAMP, 'ADMIN');

-- Alunos do curso de Análise e Desenvolvimento de Sistemas
INSERT INTO ALUNOS (NOME, EMAIL, DATA_NASCIMENTO, CURSO, TURMA, TURNO, DATA_CADASTRO, USUARIO_CADASTRO)
VALUES ('Camila Ribeiro Lima', 'camila.ribeiro@email.com', DATE '1997-06-07', 'Análise e Desenvolvimento de Sistemas', 'ADS-2024-1', 'NOITE', SYSTIMESTAMP, 'ADMIN');

INSERT INTO ALUNOS (NOME, EMAIL, DATA_NASCIMENTO, CURSO, TURMA, TURNO, DATA_CADASTRO, USUARIO_CADASTRO)
VALUES ('Diego Fernandes Oliveira', 'diego.fernandes@email.com', DATE '1995-10-28', 'Análise e Desenvolvimento de Sistemas', 'ADS-2024-1', 'NOITE', SYSTIMESTAMP, 'ADMIN');

INSERT INTO ALUNOS (NOME, EMAIL, DATA_NASCIMENTO, CURSO, TURMA, TURNO, DATA_CADASTRO, USUARIO_CADASTRO)
VALUES ('Letícia Moreira Santos', 'leticia.moreira@email.com', DATE '1999-04-16', 'Análise e Desenvolvimento de Sistemas', 'ADS-2024-2', 'MANHÃ', SYSTIMESTAMP, 'ADMIN');

-- Alguns alunos inativos (para testar filtros)
INSERT INTO ALUNOS (NOME, EMAIL, DATA_NASCIMENTO, ATIVO, CURSO, TURMA, TURNO, DATA_CADASTRO, USUARIO_CADASTRO)
VALUES ('Roberto Silva Junior', 'roberto.junior@email.com', DATE '1992-03-20', 0, 'Engenharia de Software', 'ES-2023-2', 'NOITE', SYSTIMESTAMP, 'ADMIN');

INSERT INTO ALUNOS (NOME, EMAIL, DATA_NASCIMENTO, ATIVO, CURSO, TURMA, TURNO, DATA_CADASTRO, USUARIO_CADASTRO)
VALUES ('Patrícia Costa Almeida', 'patricia.almeida@email.com', DATE '1994-11-11', 0, 'Ciência da Computação', 'CC-2023-1', 'TARDE', SYSTIMESTAMP, 'ADMIN');

INSERT INTO ALUNOS (NOME, EMAIL, DATA_NASCIMENTO, ATIVO, CURSO, TURMA, TURNO, DATA_CADASTRO, USUARIO_CADASTRO)
VALUES ('Thiago Barbosa Lima', 'thiago.barbosa@email.com', DATE '1996-07-09', 0, 'Sistemas de Informação', 'SI-2023-2', 'MANHÃ', SYSTIMESTAMP, 'ADMIN');

-- Commit das alterações
COMMIT;

-- =====================================================
-- CONSULTAS DE VERIFICAÇÃO
-- =====================================================

-- Consulta básica
SELECT * FROM ALUNOS;

