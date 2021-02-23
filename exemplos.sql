-- FUNÇÕES LÓGICAS ---------------------

-- CHOOSE()
-- Sintaxe: CHOOSE ( posição, val_1, val_2, .. , val_n )  

SELECT CHOOSE ( 3, 'Gerente', 'Diretor', 'Desenvolvedor', 'Testador' ) AS Resultado;

SELECT NumeroPedido, 
      CHOOSE(MONTH(Data),'Verão','Verão','Outono','Outono','Outono','Inverno','Inverno',   
                         'Inverno','Primavera','Primavera','Primavera','Verão') AS [Estação do Pedido]  
  FROM Pedidos 
 ORDER BY Data;

-- FUNÇÕES MATEMÁTICAS  ----------------
--
-- ABS()
-- ACOS()
-- ASIN()
-- CEILING()
-- EXP()
-- FLOOR()
-- POWER()
-- ROUND()
-- SIGN()
-- SQRT()


-- FUNÇÕES DE DATA E HORA --------------
--
-- CURRENT_TIMESTAMP
SELECT CURRENT_TIMESTAMP

-- DATENAME()
SELECT DATENAME(MONTH, GETDATE());
SELECT DATENAME(MONTH, '2021-02-18');
SELECT DATENAME(WEEKDAY, '2021-02-01');

SET LANGUAGE Italian;

SELECT DATENAME(MONTH, GETDATE());
SELECT DATENAME(MONTH, '2021-02-18');
SELECT DATENAME(WEEKDAY, '2021-02-01');

-- DATEPART() 
SELECT DATEPART(YEAR, GETDATE());
SELECT DATEPART(MONTH, GETDATE());
SELECT DATEPART(WEEKDAY, GETDATE());
SELECT DATEPART(DAY, GETDATE());
SELECT DATEPART(HOUR, GETDATE());
SELECT DATEPART(MINUTE, GETDATE());
SELECT DATEPART(SECOND, GETDATE());

-- DAY()
SELECT DAY('2021-02-18')
SELECT DAY(GETDATE())

-- MONTH()
SELECT MONTH('2021-02-18')
SELECT MONTH(GETDATE())

-- YEAR()
SELECT YEAR('2021-02-18')
SELECT YEAR(GETDATE())

-- DATEADD()
DECLARE @data DATETIME2 = '2021-01-01 13:10:10.1111111';  

SELECT 'Ano', DATEADD(YEAR, 1, @data);  
SELECT 'Quarto', DATEADD(QUARTER, 1, @data);  
SELECT 'Mês', DATEADD(MONTH, 1, @data);  
SELECT 'Dia do ano', DATEADD(DAYOFYEAR, 1, @data);  
SELECT 'Dia', DATEADD(DAY, 1, @data);  
SELECT 'Semana do ano', DATEADD(WEEK, 1, @data); 
SELECT 'Dia da semana', DATEADD(WEEKDAY, 1, @data); 
SELECT 'Hora', DATEADD(HOUR, 1, @data);  
SELECT 'Minutos', DATEADD(MINUTE, 1, @data);  
SELECT 'Segundos', DATEADD(SECOND, 1, @data);  
SELECT 'Millisegundos', DATEADD(MILLISECOND, 1, @data);  
SELECT 'Microsegundos', DATEADD(MICROSECOND, 1, @data);  
SELECT 'Nanosegundos', DATEADD(NANOSECOND, 1, @data);

-- DATEDIFF()
-- https://docs.microsoft.com/pt-br/sql/t-sql/functions/datediff-transact-sql?view=sql-server-ver15
SELECT DATEDIFF(day,         '2036-03-01', '2036-02-28');  -- devolve -2 indicando que 2036 é um ano bissexto
SELECT DATEDIFF(year,        '2005-12-31 23:59:59.9999999', '2006-01-01 00:00:00.0000000');
SELECT DATEDIFF(quarter,     '2005-12-31 23:59:59.9999999', '2006-01-01 00:00:00.0000000');
SELECT DATEDIFF(month,       '2005-12-31 23:59:59.9999999', '2006-01-01 00:00:00.0000000');
SELECT DATEDIFF(dayofyear,   '2005-12-31 23:59:59.9999999', '2006-01-01 00:00:00.0000000');
SELECT DATEDIFF(day,         '2005-12-31 23:59:59.9999999', '2006-01-01 00:00:00.0000000');
SELECT DATEDIFF(week,        '2005-12-31 23:59:59.9999999', '2006-01-01 00:00:00.0000000');
SELECT DATEDIFF(hour,        '2005-12-31 23:59:59.9999999', '2006-01-01 00:00:00.0000000');
SELECT DATEDIFF(minute,      '2005-12-31 23:59:59.9999999', '2006-01-01 00:00:00.0000000');
SELECT DATEDIFF(second,      '2005-12-31 23:59:59.9999999', '2006-01-01 00:00:00.0000000');
SELECT DATEDIFF(millisecond, '2005-12-31 23:59:59.9999999', '2006-01-01 00:00:00.0000000');
SELECT DATEDIFF(microsecond, '2005-12-31 23:59:59.9999999', '2006-01-01 00:00:00.0000000');

-- EOMONTH()  
SELECT EOMONTH ( GETDATE() ) AS 'Fim do mês';  
SELECT EOMONTH ( GETDATE(), 1 ) AS 'Fim do próximo mês';  
SELECT EOMONTH ( GETDATE() -1 ) AS 'Fim do mês anterior'; 

-- FORMAT()
-- Sintaxe: FORMAT( valor, formato [, cultura ] )  
--
-- Veja a lista completa das siglas das culturas na planilha excel MSSQL_Culturas.
-- fonte: https://lonewolfonline.net/list-net-culture-country-codes/
--

-- Lista os nomes e outros detalhes das linguagens suportadas e suas caraterísticas.
SELECT * FROM sys.syslanguages;  
EXEC sp_helplanguage; 

-- Seleciona o idioma para a sessão:
SET LANGUAGE 'Portugues' (Brasil);

-- Exemplos
SELECT FORMAT( '11/22/2020', 'd', 'en-US' ) 'Inglês americano',  
       FORMAT( '11/22/2020', 'd', 'pt-BR' ) 'Português Brasil',  
       FORMAT( '11/22/2020', 'd', 'de-de' ) 'Alemão',  
       FORMAT( '11/22/2020', 'd', 'zh-cn' ) 'Chines simplificado';  
  
SELECT FORMAT( '11/22/2020', 'D', 'en-US' ) 'Inglês americano',  
       FORMAT( '11/22/2020', 'D', 'pt-BR' ) 'Português Brasil',  
       FORMAT( '11/22/2020', 'D', 'de-de' ) 'Alemão',   
       FORMAT( '11/22/2020', 'D', 'zh-cn' ) 'Chines simplificado'; 

SELECT FORMAT( '11/22/2020', 'dd/MM/yyyy', 'en-US' ) AS 'Data',  
       FORMAT(123456789,'###-##-####') AS 'Número formatado';


-- GETDATE() 
SELECT GETDATE()

-- ISDATE()
SET LANGUAGE us_english;  
SET DATEFORMAT mdy;  

/* Formato da data  mdy*/  
SELECT ISDATE('04/15/2008'); --Retorna  1.  
SELECT ISDATE('04-15-2008'); --Retorna  1.   
SELECT ISDATE('04.15.2008'); --Retorna  1.   
SELECT ISDATE('04/2008/15'); --Retorna  1.  
  
SET DATEFORMAT mdy;  
SELECT ISDATE('15/04/2008'); --Retorna  0.  
SET DATEFORMAT mdy;  
SELECT ISDATE('15/2008/04'); --Retorna  0.  
SET DATEFORMAT mdy;  
SELECT ISDATE('2008/15/04'); --Retorna  0.  
SET DATEFORMAT mdy;  
SELECT ISDATE('2008/04/15'); --Retorna  1.  
  
SET DATEFORMAT dmy;  
SELECT ISDATE('15/04/2008'); --Retorna  1.  
SET DATEFORMAT dym;  
SELECT ISDATE('15/2008/04'); --Retorna  1.  
SET DATEFORMAT ydm;  
SELECT ISDATE('2008/15/04'); --Retorna  1.  
SET DATEFORMAT ymd;  
SELECT ISDATE('2008/04/15'); --Retorna  1.  
  
SET LANGUAGE English;  
SELECT ISDATE('15/04/2008'); --Retorna  0.  
SET LANGUAGE Hungarian;  
SELECT ISDATE('15/2008/04'); --Retorna  0.  
SET LANGUAGE Swedish;  
SELECT ISDATE('2008/15/04'); --Retorna  0.  
SET LANGUAGE Italian;  
SELECT ISDATE('2008/04/15'); --Retorna  1.  
  
/* Voltar ao Português Brasil. */  
SET LANGUAGE 'Portugues (Brasil)';  
SET DATEFORMAT dmy;  


-- FUNÇÕES DE STRINGS -----------------
--
-- ASCII()
-- CHAR()
-- CHARINDEX()
-- CONCAT()
-- CONCAT_WS()
-- DIFFERENCE()
-- FORMAT() 
-- LEFT() 
-- LEN()
-- LOWER()
-- LTRIM()
-- NCHAR()
-- PATINDEX()
-- QUOTENAME()
-- REPLACE()
-- REPLICATE()
-- REVERSE()

-- RIGHT()
SELECT RIGHT('abcdefg1234', 4) AS [Os números no string];
SELECT RIGHT('abcdefg1234', 6) AS [Algumas letras e os números no string];

-- RTRIM()
-- SPACE()
-- STR()

-- STRING_AGG()
SELECT STRING_AGG(Nome, '; ') -- lista horizontal com o nome dos clientes
  FROM Cliente;

SELECT STRING_AGG(Nome, CHAR(13)) -- lista vertical com o nome dos clientes
  FROM Cliente;

SELECT STRING_AGG(Nome, CHAR(13)) WITHIN GROUP (ORDER BY Nome DESC) -- lista os nomes em ordem descendente
  FROM Cliente;

-- STUFF()

-- SUBSTRING()
SELECT SUBSTRING('abcdefg1234', 1, 7) AS [As letras no string];
SELECT SUBSTRING('abcdefg1234', 8, 4) AS [Os números no string];
SELECT SUBSTRING('abcdefg1234', 6, 4) AS [Algumas letras e números no string];

-- TRIM()
-- UPPER()