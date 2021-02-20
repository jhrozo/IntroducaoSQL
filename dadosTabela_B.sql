-- Dados_Tabela_B
USE bd_01;

DECLARE @i AS SMALLINT = 1;

WHILE (@i <= 25)
	BEGIN TRY
		INSERT INTO dbo.tabela_B VALUES(@i);
		SET @i = @i + 1;
	END TRY
	BEGIN CATCH
		SELECT ERROR_NUMBER() AS [Número do erro],
		       ERROR_MESSAGE() AS [Descrição];
	END CATCH;

