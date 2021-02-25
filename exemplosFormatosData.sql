-- exemplosFormatosData.sql  v1.0  2021
-- Jaime H Rozo - jhrozo@yahoo.com

/*
   Este script cria a tabela temporária dateFormats contendo todos os códigos que
   podem ser usados como parámetro na função CONVERT() para formatação das datas.

   A tabela dateFormats contem 2 colunas: uma para armazenar o código do formato e outra 
   para gravar um exemplo com o formato correspondente.
*/

DECLARE @formato INT = 0
DECLARE @data DATETIME = GETDATE()

CREATE TABLE #dateFormats (formato int, exemplo nvarchar(40))

WHILE (@formato <= 150 )
BEGIN
   BEGIN TRY
      INSERT INTO #dateFormats
      SELECT CONVERT(nvarchar, @formato), CONVERT(nvarchar,@data, @formato) 
      SET @formato = @formato + 1
   END TRY
   BEGIN CATCH;
      SET @formato = @formato + 1
      IF @formato >= 150
      BEGIN
         BREAK
      END
   END CATCH
END

-- Para visualizar a tabela com os formatos de data:
-- SELECT * FROM #dateFormats

-- Para apagar a tabela com os formatos de data:
-- DROP TABLE #dateFormats