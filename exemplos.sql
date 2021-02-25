-- exemplos.sql  v.1.0 2021
-- Jaime H Rozo - jhrozo@yahoo.com

/*
   Exemplos do manual Introdução ao SQL.
   Use os scripts criarEsquema.sql e popularTabelas.sql para criar e 
   popular as tabelas usadas nos exemplos.
*/

use bd_01;

-- SELECT
SELECT Id, Nome, Cidade
  FROM Cliente;
	
SELECT Empresa, Contato, Telefone
  FROM Fornecedor;
	
SELECT *             
  FROM Cliente;
	
SELECT *
 FROM Fornecedor;

SELECT 2 + 2;

SELECT GETDATE();
	
SELECT UPPER('abcd efg');
	
SELECT 'Curso de SQL';

-- CLÁUSULA TOP
SELECT TOP(10) Id, Nome, Cidade
  FROM Cliente;

SELECT TOP(30) Empresa, Contato, Telefone
  FROM Fornecedor;

-- USO DO ALIAS
SELECT c.Id,
       c.Nome,
       c.Cidade
  FROM Cliente AS c;

SELECT f.*     -- lista todas as colunas da tabela Fornecedor
  FROM Fornecedor AS f;

SELECT c.Id, c.Nome, c.Cidade,            -- dados da tabela Cliente, alias c        
       f.Id, f.Empresa, f.Contato         -- dados da tabela Fornecedor, alias f
  FROM Cliente AS c, Fornecedor AS f;

-- MUDANDO O NOME DAS COLUNAS
SELECT PedidoId AS Número_Pedido,
	   ProdutoId AS Código_Produto
  FROM ItemPedido;

SELECT PedidoId AS [Número Pedido], 
	   ProdutoId AS [Código Produto]
  FROM ItemPedido;

-- COLUNAS CALCULADAS
SELECT PedidoId as Número_Pedido,
       ProdutoId as Código_Produto,
	   PrecoUnit * Quantidade as ValorTotal   -- coluna calculada
  FROM ItemPedido;

SELECT c.Id as Cód_Cliente,
	   UPPER(c.Nome),      -- mostra o nome com letras maiúsculas
       c.Cidade
  FROM Cliente as c;

-- DISTINCT 
SELECT DISTINCT Cidade   
  FROM Cliente;

-- ORDER BY
SELECT Sobrenome, Nome, Cidade   
  FROM Cliente
 ORDER BY Sobrenome ASC, Nome ASC, Cidade DESC;

-- WHERE
SELECT Sobrenome, Nome, Cidade   
  FROM Cliente
 WHERE Cidade = 'Rio de Janeiro'
 ORDER BY Sobrenome ASC, Nome ASC;

SELECT NumeroPedido, ClienteID, ValorTotal   
  FROM Pedido
 WHERE ValorTotal >= 400 AND ValorTotal < 700;
		
SELECT Sobrenome, Nome, Cidade   
  FROM Cliente
 WHERE Cidade != 'Rio de Janeiro'
 ORDER BY Sobrenome, Nome, Cidade DESC;

-- NULL
SELECT Empresa, Fax   -- lista fornecedores sem o número do fax
  FROM Fornecedor
 WHERE Fax IS NULL;
 
SELECT Empresa, Fax   -- lista fornecedores com o número do fax
  FROM Fornecedor
 WHERE Fax IS NOT NULL;

-- GROUP BY
SELECT Cidade, COUNT(*) as Contagem
  FROM Cliente
 GROUP BY Cidade;

-- COUNT(*)
SELECT Cidade, COUNT(*) as Contagem
  FROM Cliente
 GROUP BY Cidade
 ORDER BY Contagem DESC;   -- usando o nome assinado à coluna 

SELECT Pais, Cidade, COUNT(*) as Contagem
  FROM Cliente
 GROUP BY Pais, Cidade
 ORDER BY Pais, Cidade;

SELECT Fax, COUNT(*) as Contagem
  FROM Fornecedor
 GROUP BY Fax
 ORDER BY Contagem DESC;

-- HAVING
SELECT Pais, Cidade, COUNT(*) as Contagem
  FROM Cliente
 GROUP BY Pais, Cidade
HAVING COUNT(*) > 2     -- não pode ser usado o nome “Contagem”
 ORDER BY Pais, Cidade;

-- UNION
SELECT 'Cliente', Nome, Cidade, Pais
  FROM Cliente
UNION
SELECT 'Fornecedor', Empresa, Cidade, Pais
  FROM Fornecedor
 ORDER BY Pais, Cidade, Nome;

-- INTERSECT
SELECT Id
  FROM Produto
INTERSECT
SELECT ProdutoId
  FROM ItemPedido;

-- EXCEPT
SELECT Id
  FROM Produto
EXCEPT
SELECT ProdutoId
  FROM ItemPedido;

-- INNER JOIN
SELECT Nome, Sobrenome, NumeroPedido, Data, ValorTotal   
  FROM Cliente INNER JOIN Pedido ON Cliente.Id = ClienteId
 WHERE Cliente.Id = 63
 ORDER BY Data, NumeroPedido; 

SELECT Nome, Sobrenome, NumeroPedido, Data, ValorTotal   
  FROM Cliente INNER JOIN Pedido ON Cliente.Id = ClienteId
 WHERE Cliente.Id = 63
   AND Data >= '2014-01-01'
 ORDER BY Data, NumeroPedido;

SELECT Nome, Sobrenome, NumeroPedido, Data, ValorTotal   
  FROM Cliente, Pedido
 WHERE Cliente.Id = 63
   AND ClienteID = 63
   AND Data >= '2014-01-01'
ORDER BY Data, NumeroPedido;

-- LEFT JOIN
SELECT c.Id, c.Nome, c.SobreNome, p.NumeroPedido, p.Data, p.ValorTotal
  FROM Cliente AS c  LEFT JOIN  Pedido AS p  ON c.Id = p.ClienteId
 --WHERE p.NumeroPedido IS NULL -- decomente esta linha para mostrar somente os clientes que nunca fizeram pedidos
 ORDER BY p.NumeroPedido;

-- RIGHT JOIN
SELECT p.Id, p.Nome, i.PedidoId, i.Quantidade, i.PrecoUnit, 
       i.Quantidade * i.PrecoUnit AS [Valor]
  FROM ItemPedido AS i  RIGHT JOIN  Produto AS p  ON p.Id = i.ProdutoId
 --WHERE i.PedidoId IS NULL  -- decomente esta linha para mostrar somente os produtos que nunca foram pedidos
 ORDER BY i.PedidoId;

-- FULL JOIN
SELECT p.Id, p.Nome, i.PedidoId, i.Quantidade, i.PrecoUnit, 
       i.Quantidade * i.PrecoUnit AS [Valor]
  FROM ItemPedido AS i  FULL JOIN  Produto AS p  ON p.Id = i.ProdutoId
 ORDER BY i.PedidoId;

-- CROSS JOIN
SELECT COUNT (*) * (SELECT COUNT(*) FROM Fornecedor)
  FROM Cliente;
    
SELECT Cliente.Id, Cliente.Nome, 
       Fornecedor.Id, Fornecedor.Empresa   
  FROM Cliente CROSS JOIN Fornecedor;

-- SCALAR SUBQUERY
SELECT PedidoId, ProdutoId, PrecoUnit, Quantidade
  FROM ItemPedido 
 WHERE PedidoId = (SELECT MAX(Id) AS [Útimo Pedido] 
                     FROM Pedido);

-- MULTIVALUED SUBQUERY
SELECT PedidoId, ProdutoId, Quantidade
  FROM ItemPedido 
 WHERE PedidoId IN (SELECT Id 
                      FROM Pedido
                     WHERE DATA >= '2014-05-04' AND DATA <= '2014-05-06');

SELECT PedidoId, ProdutoId, Quantidade
  FROM ItemPedido i INNER JOIN Pedido p ON i.PedidoId = p.Id
 WHERE p.Data >= '2014-05-04' AND p.Data <= '2014-05-06'
 ORDER BY i.PedidoId, i.ProdutoId;

 -- CORRELATED SUBQUERY
SELECT ClienteId, CONVERT(VARCHAR,Data,103) NumeroPedido, ValorTotal
FROM Pedido p1
WHERE Data = (SELECT MAX(Data)
                FROM Pedido p2
	           WHERE p2.ClienteId = p1.ClienteId)
ORDER BY ClienteId, Data;