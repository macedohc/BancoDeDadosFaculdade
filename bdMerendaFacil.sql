-- Cria um novo banco de dados chamado merendaFacil
CREATE DATABASE merendaFacil;

-- Seleciona o banco de dados merendaFacil para uso
USE merendaFacil;

-- Cria uma nova tabela chamada T_login com três colunas: idlogin, email e senha
-- A coluna idlogin é definida como uma chave primária e autoincrementável
CREATE TABLE T_login (
    idlogin INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(50),
    senha VARCHAR(50)
);

-- Insere dados na tabela T_login
-- Insere dois conjuntos de valores: (email, senha)
-- Um para 'adminmerendaescolar@gmail.com' com a senha 'adminescolar'
-- Outro para 'inspetormerendaescolar@gmail.com' com a senha 'inspetorescolar'
INSERT INTO T_login (email, senha) 
VALUES ('adminmerendaescolar@gmail.com', 'adminescolar'), 
       ('inspetormerendaescolar@gmail.com', 'inspetorescolar');

-- Seleciona todos os dados da tabela T_login
SELECT * FROM T_login;

-- Cria uma nova tabela chamada T_telaInicial
CREATE TABLE T_telaInicial (
     RA INT AUTO_INCREMENT PRIMARY KEY,
    serie VARCHAR(2),
    nome_aluno VARCHAR(100),
    restricaoAlimentar VARCHAR(100),
    numero_de_refeicoes INT DEFAULT 0,
    dataRetirada VARCHAR(10)
);

-- Seleciona todos os dados da tabela T_telaInicial
SELECT * FROM T_telaInicial;

-- Remove a tabela T_telaInicial
DROP TABLE T_telaInicial;

-- Define um delimitador temporário para criar o trigger
DELIMITER //

-- Cria um trigger chamado atualizar_numero_refeicoes
-- Este trigger é acionado após uma inserção na tabela T_telaInicial
-- Ele atualiza o campo numero_de_refeicoes para 2 se houver dois RAs (Registro Acadêmico) iguais
CREATE TRIGGER atualizar_numero_refeicoes AFTER INSERT ON T_telaInicial
FOR EACH ROW
BEGIN
    DECLARE contador INT;
    SELECT COUNT(*) INTO contador FROM T_telaInicial WHERE RA = NEW.RA;
    IF contador = 2 THEN
        UPDATE T_telaInicial SET numero_de_refeicoes = 2 WHERE RA = NEW.RA;
    END IF;
END//

-- Restaura o delimitador padrão
DELIMITER ;
