use AdventureWorks2016; --boa pr�tica
GO

CREATE SCHEMA Aulas; --criar esquema
GO

CREATE TABLE Aulas.Pessoa
(
	  ID NUMERIC(18,0) NOT NULL IDENTITY(1,1) PRIMARY KEY
	, SALARIO DECIMAL(12,2)
	, CEP CHAR(9)
	, [NOME COMPLETO] VARCHAR(200) NOT NULL
	, CPF CHAR(15)
	, CNPJ CHAR(18)
	, OBSERVACAO NVARCHAR(MAX)
	, UF CHAR(2)
	, IDADE INT
	, STATUS INT CHECK(STATUS IN (1,2,3))
	, DT_NASC DATE NOT NULL
	, DT_ULT_MODIFICACAO DATETIME DEFAULT (GETDATE())
	, ATIVO BIT
);
GO

INSERT  Aulas.Pessoa (
	 SALARIO
	,CEP
	,[NOME COMPLETO]
	,CPF, CNPJ
	,OBSERVACAO
	,UF
	,IDADE
	,STATUS
	,DT_NASC
	,DT_ULT_MODIFICACAO
	,ATIVO
	)
/*Valores a serem inseridos*/
VALUES (
	 2250.89
	,'13190-000'
	,'Christian Marque'
	,'321.654.987-25'
	,'34.342.678/0001-45'
	, NULL
	, NULL
	, NULL
	, 1
	,'1990-02-05'
	, GETDATE()
	,1
),(
	 5624.23
	,'13125-256'
	,'Jo�o Crito Ribeiro'
	,'123.654.789.58'
	,'54.145.367/0001-67'
	, NULL
	, NULL
	, NULL
	, NULL
	,'1979-08-19'
	, GETDATE()
	, 1
),(
	6555.23,
	 '13542-525'
	,'Maria Jo�o Maia'
	,'741.852.963.52'
	,'67.463.654/0001-87'
	, NULL
	, NULL
	, 2
	, NULL
	,'1981-01-31'
	, GETDATE()
	, 1
);
GO
 
INSERT  Aulas.Pessoa (
	 [CEP]
    ,[NOME COMPLETO]
    ,[CPF]
    ,[CNPJ]
    ,[OBSERVACAO]
    ,[UF]
    ,[IDADE]
    ,[STATUS]
    ,[SALARIO]
    ,[DT_NASC]
    ,[ATIVO])
VALUES(
	'14258-870'
	,'Henrique Gabriel Cordeiro'
	,'963.852.741.47'
	,'22.876.987/0001-44'
	,NULL
	,NULL
	,NULL
	,3
	,2525.25
	,'1978-07-22'
	,1
),(
	'12546-875'
	,'Carlos da Silva' 
	,'123 2'
	,'456.852.753.95 '
	,NULL
	,NULL
	,NULL
	,1
	,4125.25
	,'1982-12-15'
	,1
);
GO

SELECT * 
FROM Aulas.Pessoa WHERE [NOME COMPLETO] LIKE ('%Jo�o%')
GO

CREATE TABLE Aulas.Saldo
(
		 ID_SALDO INT NOT NULL IDENTITY(1,1) PRIMARY KEY
		,ID_PESSOA NUMERIC(18,0) NOT NULL FOREIGN KEY REFERENCES Aulas.Pessoa (ID)
		,TIPO_CONTA VARCHAR(10) CHECK(TIPO_CONTA IN ('Corrente','Polpan�a','Conjunta') )
		,SALDO_PESSOA NUMERIC(10,2) DEFAULT(0.00)
);
GO

INSERT  Aulas.Saldo ([ID_PESSOA], [TIPO_CONTA], [SALDO_PESSOA])
VALUES ('1', 'Corrente', 9560.55),('1', 'Polpan�a', 15654.47),('2', 'Corrente', 25880.55)
GO

INSERT  Aulas.Saldo ([ID_PESSOA], [TIPO_CONTA], [SALDO_PESSOA])
VALUES ('3', 'Corrente', 58412.66),('4', 'Polpan�a', 6325.87),('5', 'Conjunta', 1000.25)
GO

INSERT  Aulas.Saldo ([ID_PESSOA], [TIPO_CONTA], [SALDO_PESSOA])
VALUES ('2', 'Conjunta', 4578.00),('3', 'Polpan�a', 500.00),('4', 'Corrente', 25.00)
GO

SELECT 
	 [NOME COMPLETO] Nome 
	,[DT_NASC] 'Data de nasc.' 
	,[SALDO_PESSOA]
	,CASE 
		WHEN A.STATUS = 1 THEN 'ATIVO'
		WHEN A.STATUS = 2 THEN 'EM PROCESSO' 
		WHEN A.STATUS = 3 THEN 'DESATIVA��O TEMPOR�RIA'
		ELSE 'Desativado' 
	END ATIVA��O
FROM Aulas.Pessoa A
INNER JOIN Aulas.Saldo B
ON A.ID = B.ID_PESSOA
GO