--
-- exemplosFormatosData.sql
--
-- Este script cria a tabela temporária dateFormats contendo os códigos para
-- formatação das datas usados na função CONVERT().
-- 

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