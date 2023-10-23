-- Sequências
create sequence sk_pagamento; -- para sk pagamento
create sequence sk_tempo; -- para dime tempo
drop sequence cliente; -- para dime cliente código
create sequence sk_cliente; -- para dime cliente sk
create sequence sk_filme; -- para dime filme
create sequence sk_locacao; -- para fato locacao

-- Tabela Dime_cliente
create table Dime_cliente (
    Sk_cliente int primary key not null,
    Cd_cliente int not null,
    Nome varchar(45) not null,
    Sobrenome varchar(80) not null,
    Email varchar(80) not null,
    Ativo char(1) not null,
    Rua_Endereco varchar(45) not null,
    Bairro_Endereco varchar(45) not null,
    Cidade_Endereco varchar(45) not null,
    Pais_Endereco varchar(45) not null,
    Codigo_postal char(2) not null,
    Telefone char(9) not null,
    In_scdcorr char(1) not null,
    Data_vigencia date not null,
    Data_fim_vigencia date not null
);

-- Tabela Dime_Pagamento
create table Dime_Pagamento (
    Sk_pagamento int primary key not null,
    Valor_pagamento int not null,
    Forma_pagamento char(1) not null,
    Data_pagamento date not null,
    Data_vencimento date not null,
    Valor_pago int not null
);

-- Tabela Dime_tempo
create table Dime_tempo (
    Sk_tempo int primary key not null,
    Data date not null,
    Dia int not null,
    Nm_Dia varchar(45) not null,
    Cd_mes int not null,
    Nm_mes varchar(45) not null,
    Ano int not null,
    In_bissexto char(1) not null
);

-- Tabela Dime_filme
create table Dime_filme (
    Sk_filme int primary key not null,
    Cd_filme int not null,
    Titulo varchar(45) not null,
    Descricao varchar(100) not null,
    Ano_lancamento date not null,
    Opcoes_linguagem char (1) not null,
    Linguagem_original char(1) not null,
    Duracao int not null,
    Categoria varchar(45) not null
);

-- Tabela fato_locacao
create table fato_locacao (
    Sk_cliente int primary key not null,
    Sk_pagamento int primary key not null,
    Sk_tempo int primary key not null,
    Sk_filme int primary key not null,
    Sk_locacao int primary key not null,
    Valor_locacao float not null,
    Data_locacao date not null,
    Data_entrega date not null,
    Qtd_locacao int not null
);

--Popular tabela Dime_tempo
truncate table dime_tempo;

select *
from Dime_tempo d
where d.sk_tempo = 1;

SELECT sk_tempo.currval FROM DUAL;

create sequence sk_tempo
start with 1
increment by 1

select sysdate from dual;


-- Populando a tabela Dime_tempo
DECLARE
    v_data DATE := TO_DATE('01/01/2020', 'DD/MM/YYYY');  -- Data inicial
    --data_limite DATE := sysdate
    v_sk_tempo INT := 1;
BEGIN
    WHILE v_data <= sysdate LOOP
        INSERT INTO Dime_tempo (Sk_tempo, Data, Dia, Nm_Dia, Cd_mes, Nm_mes, Ano, In_bissexto)
        VALUES (
            sk_tempo.nextval, 
            v_data, 
            EXTRACT(DAY FROM v_data), 
            TO_CHAR(v_data, 'Day'), 
            EXTRACT(MONTH FROM v_data), 
            TO_CHAR(v_data, 'Month'), 
            EXTRACT(YEAR FROM v_data), 
            CASE
                WHEN TO_CHAR(v_data, 'YYYY') = '2024' THEN 'S'
                ELSE 'N'
            END
        );
        v_data := v_data + 1;
    END LOOP;
    COMMIT;
END;


