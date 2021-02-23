-- Dados_Tabela_B
USE bd_01
go

CREATE TABLE tabela_B (numero SMALLINT NULL) ON [PRIMARY]
go

DECLARE @i AS SMALLINT = 1;
WHILE (@i <= 25)
	BEGIN TRY
		INSERT INTO tabela_B VALUES(@i);
		SET @i = @i + 1;
	END TRY
	BEGIN CATCH
		SELECT ERROR_NUMBER() AS [Número do erro],
		       ERROR_MESSAGE() AS [Descrição];
	END CATCH;