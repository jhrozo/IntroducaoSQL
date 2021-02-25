-- criarEsquema.sql  v.1.0 2021
-- Jaime H Rozo - jhrozo@yahoo.com

/*
   Script para criação do esquema de dados para o Sistema de Pedidos
   usado nos exemplos dos manual Introdução ao SQL.
*/
 

/** Criar o banco de dados **/
USE [master]
go

-- SQL Server Syntax
DROP DATABASE IF EXISTS [bd_01]
go

CREATE DATABASE [bd_01]
go

/** Criar as tabelas, índices e constraints **/
use bd_01
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('"Pedido"') and o.name = 'FK_CLIENTEID_REFERENCIA_CLIENTE')
alter table "Pedido"
   drop constraint FK_CLIENTEID_REFERENCIA_CLIENTE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('ItemPedido') and o.name = 'FK_PEDIDOID_REFERENCIA_PEDIDO')
alter table ItemPedido
   drop constraint FK_PEDIDOID_REFERENCIA_PEDIDO
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('ItemPedido') and o.name = 'FK_PRODUTOID_REFERENCIA_PRODUTO')
alter table ItemPedido
   drop constraint FK_PRODUTOID_REFERENCIA_PRODUTO
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Produto') and o.name = 'FK_FORNECEDORID_REFERENCIA_FORNECEDOR')
alter table Produto
   drop constraint FK_FORNECEDORID_REFERENCIA_FORNECEDOR
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Cliente')
            and   name  = 'IdxNomeCliente'
            and   indid > 0
            and   indid < 255)
   drop index Cliente.IdxNomeCliente
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Cliente')
            and   type = 'U')
   drop table Cliente
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('"Pedido"')
            and   name  = 'IdxPedidoData'
            and   indid > 0
            and   indid < 255)
   drop index "Pedido".IdxPedidoData
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('"Pedido"')
            and   name  = 'IdxPedidoCliente'
            and   indid > 0
            and   indid < 255)
   drop index "Pedido".IdxPedidoCliente
go

if exists (select 1
            from  sysobjects
           where  id = object_id('"Pedido"')
            and   type = 'U')
   drop table "Pedido"
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('ItemPedido')
            and   name  = 'IdxItemPedidoProduto'
            and   indid > 0
            and   indid < 255)
   drop index ItemPedido.IdxItemPedidoProduto
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('ItemPedido')
            and   name  = 'IdxItemPedidoNumPedido'
            and   indid > 0
            and   indid < 255)
   drop index ItemPedido.IdxItemPedidoNumPedido
go

if exists (select 1
            from  sysobjects
           where  id = object_id('ItemPedido')
            and   type = 'U')
   drop table ItemPedido
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Produto')
            and   name  = 'IdxProdutoNome'
            and   indid > 0
            and   indid < 255)
   drop index Produto.IdxProdutoNome
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Produto')
            and   name  = 'IdxProdutoFornecedor'
            and   indid > 0
            and   indid < 255)
   drop index Produto.IdxProdutoFornecedor
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Produto')
            and   type = 'U')
   drop table Produto
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Fornecedor')
            and   name  = 'IdxFornecedorPais'
            and   indid > 0
            and   indid < 255)
   drop index Fornecedor.IdxFornecedorPais
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Fornecedor')
            and   name  = 'IdxFornecedorNome'
            and   indid > 0
            and   indid < 255)
   drop index Fornecedor.IdxFornecedorNome
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Fornecedor')
            and   type = 'U')
   drop table Fornecedor
go

/*==============================================================*/
/* CLIENTE                                                      */
/*==============================================================*/
create table Cliente (
   Id                   int                  identity,
   Nome					nvarchar(40)         not null,
   Sobrenome            nvarchar(40)         not null,
   Cidade               nvarchar(40)         null,
   Pais					nvarchar(40)         null,
   Telefone             nvarchar(20)         null,
   constraint PK_CLIENTE primary key (Id)
)
go

/*==============================================================*/
/* Index: IdxClienteNome                                        */
/*==============================================================*/
create index IdxNomeCliente on Cliente (
	Nome ASC,
	Sobrenome ASC
)
go

/*==============================================================*/
/* Table: "Pedido"                                              */
/*==============================================================*/
create table "Pedido" (
   Id                   int                  identity,
   Data					datetime             not null default getdate(),
   NumeroPedido			nvarchar(10)         null,
   ClienteId			int                  not null,
   ValorTotal           decimal(12,2)        null default 0,
   constraint PK_PEDIDO primary key (Id)
)
go

/*==============================================================*/
/* Index: IdxPedidoCliente                                      */
/*==============================================================*/
create index IdxPedidoCliente on "Pedido" (
	ClienteId ASC
)
go

/*==============================================================*/
/* Index: IdxPedidoData                                         */
/*==============================================================*/
create index IdxPedidoData   on "Pedido" (
	Data ASC
)
go

/*==============================================================*/
/* Table: ItemPedido                                            */
/*==============================================================*/
create table ItemPedido (
   Id                   int                  identity,
   PedidoId             int                  not null,
   ProdutoId            int                  not null,
   PrecoUnit            decimal(12,2)        not null default 0,
   Quantidade           int                  not null default 1,
   constraint PK_ITEMPEDIDO primary key (Id)
)
go

/*==============================================================*/
/* Index: IdxItemPedidoNumPedido                                */
/*==============================================================*/
create index IdxItemPedidoNumPedido    on ItemPedido (
	PedidoId ASC
)
go

/*==============================================================*/
/* Index: IdxItemPedidoProduto                                  */
/*==============================================================*/
create index IdxItemPedidoProduto on ItemPedido (
ProdutoId ASC
)
go

/*==============================================================*/
/* Table: Produto                                               */
/*==============================================================*/
create table Produto (
   Id                   int                  identity,
   Nome					nvarchar(50)         not null,
   FornecedorId         int                  not null,
   Preco	            decimal(12,2)        null default 0,
   Apresentacao         nvarchar(30)         null,
   Descontinuado        bit                  not null default 0,
   constraint PK_PRODUTO primary key (Id)
)
go

/*==============================================================*/
/* Index: IdxProdutoFornecedor                                  */
/*==============================================================*/
create index IdxProdutoFornecedor on Produto (
	FornecedorId ASC
)
go

/*==============================================================*/
/* Index: IdxProdutoNome                                    */
/*==============================================================*/
create index IdxProdutoNome   on Produto (
	Nome ASC
)
go

/*==============================================================*/
/* Table: Fornecedor                                            */
/*==============================================================*/
create table Fornecedor (
   Id                   int                  identity,
   Empresa	            nvarchar(40)         not null,
   Contato              nvarchar(50)         null,
   Cargo		        nvarchar(40)         null,
   Cidade               nvarchar(40)         null,
   Pais                 nvarchar(40)         null,
   Telefone             nvarchar(30)         null,
   Fax                  nvarchar(30)         null,
   constraint PK_FORNECEDOR primary key (Id)
)
go

/*==============================================================*/
/* Index: IdxFornecedorNome                                     */
/*==============================================================*/
create index IdxFornecedorNome  on Fornecedor (
	Empresa ASC
)
go

/*==============================================================*/
/* Index: IdxFornecedorPais                                     */
/*==============================================================*/
create index dxFornecedorPais on Fornecedor (
	Pais ASC
)
go

alter table "Pedido"
   add constraint FK_CLIENTEID_REFERENCIA_CLIENTE foreign key (ClienteId)
      references Cliente (Id)
go

alter table ItemPedido
   add constraint FK_PEDIDOID_REFERENCIA_PEDIDO foreign key (PedidoId)
      references "Pedido" (Id)
go

alter table ItemPedido
   add constraint FK_PRODUTOID_REFERENCIA_PRODUTO foreign key (ProdutoId)
      references Produto (Id)
go

alter table Produto
   add constraint FK_FORNECEDORID_REFERENCIA_FORNECEDOR foreign key (FornecedorId)
      references Fornecedor (Id)
go