-- respostasExercicios.sql
-- Jaime H Rozo - jhrozo@yahoo.com

-- 1. Listar as cidades dos clientes que nao iniciam e não terminam com vogal
SELECT Cidade
  FROM Cliente
 WHERE SUBSTRING(Cidade, 1, 1) NOT IN ('A','E','I','O','U','a','e','i','o','u')
   AND SUBSTRING(Cidade, LEN(Cidade), 1) NOT IN ('A','E','I','O','U','a','e','i','o','u')
 ORDER BY Cidade;

SELECT Cidade
  FROM Cliente
 WHERE LEFT(Cidade, 1) NOT IN ('A','E','I','O','U','a','e','i','o','u')
   AND RIGHT(Cidade, 1) NOT IN ('A','E','I','O','U','a','e','i','o','u')
 ORDER BY Cidade;

SELECT Cidade
  FROM Cliente
 WHERE Cidade LIKE '[^AEIOUaeiou]%' 
   AND Cidade NOT LIKE '%[AEIOUaeiou]'
 ORDER BY Cidade;

-- 2 Listar os 5 primeiros clientes com mais pedidos.
SELECT TOP(5) c.Id, c.Nome+' '+c.Sobrenome, COUNT(*) Núm_Pedidos
  FROM Cliente c, Pedido p
 WHERE c.Id = p.ClienteId
 GROUP BY c.Id, c.Nome+' '+c.Sobrenome
 ORDER BY Núm_Pedidos DESC;

SELECT TOP(5) c.Id, c.Nome+' '+c.Sobrenome, COUNT(*) Núm_Pedidos
  FROM Cliente c INNER JOIN Pedido p ON c.Id = p.ClienteId
 GROUP BY c.Id, c.Nome+' '+c.Sobrenome
 ORDER BY Núm_Pedidos DESC;

--3 Listar todos os atributos dos produtos que nunca foram pedidos, incluir o nome do fornecedor.
SELECT p.Id, p.Nome, p.Preco, p.Apresentacao,
       CHOOSE(p.Descontinuado+1,'ATIVO','DESCONTINUADO') AS Situação, 
	   f.Empresa
  FROM Produto p 
       INNER JOIN
       (SELECT Id FROM Produto
        EXCEPT
        SELECT ProdutoId FROM ItemPedido) AS Id_Produto
	   ON Id_Produto.Id = p.Id 
	   INNER JOIN
	   Fornecedor f ON p.FornecedorId = f.Id

SELECT p.Id, p.Nome, p.Preco, p.Apresentacao,
       CHOOSE(p.Descontinuado+1,'ATIVO','DESCONTINUADO') AS Situação, f.Empresa
  FROM Produto p,
       Fornecedor f
 WHERE p.Id NOT IN (SELECT ProdutoId FROM ItemPedido)
   AND p.FornecedorId = f.Id

--4 Listar todas as combinações entre os números de 1 a 5.
SELECT * 
  FROM tabela_A CROSS JOIN tabela_B

--5 Listar todas as combinações entre os números de 1 a 5, excluir as combinações repetidas.
SELECT a.numero, b.numero
  FROM tabela_A As a JOIN tabela_B AS b ON a.numero < b.numero

--6 Listar os detalhes do último pedido do cliente Christina Berglund.
SELECT c.Nome+' '+c.Sobrenome AS Nome, 
       ProdutoId, PrecoUnit, Quantidade, PrecoUnit * Quantidade AS Total
  FROM ItemPedido i,
       Pedido p,
       Cliente c
 WHERE PedidoId = (SELECT MAX(Id)
	                 FROM Pedido
					WHERE ClienteId = 5)
   AND p.Id = i.PedidoId
   AND c.Id = p.ClienteId

--7 Listar quantos de pedidos e a soma de todos por cliente. Identificar cada cliente.
SELECT c.Id, c.Nome+' '+c.Sobrenome, 
       SUM(p.ValorTotal) AS 'Valor Total', COUNT(p.NumeroPedido) AS 'Número Pedidos'
  FROM Pedido p INNER JOIN Cliente c ON p.ClienteId = c.Id
 GROUP BY c.Id, c.Nome+' '+c.Sobrenome
 ORDER BY 'Número Pedidos' DESC

--8 Listar total de compras por ano de cada cliente.
SELECT ClienteId, [2014], [2013], [2012]
  FROM (SELECT ClienteId, ValorTotal, YEAR(Data) AS Ano
          FROM Pedido) AS p
PIVOT(SUM(ValorTotal) FOR p.Ano IN ([2014], [2013], [2012])) AS pvt
 ORDER BY ClienteId

SELECT ClienteId, Nome, [2014], [2013], [2012]
  FROM (SELECT ClienteId, c.Nome+' '+c.Sobrenome as Nome, ValorTotal, YEAR(Data) AS Ano
          FROM Pedido pe,
		       Cliente c
	     WHERE c.Id = pe.ClienteId) AS p
PIVOT(SUM(ValorTotal) FOR p.Ano IN ([2014], [2013], [2012])) AS pvt
 ORDER BY Nome





