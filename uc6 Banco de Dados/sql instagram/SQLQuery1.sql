--alterando o nome do database 
alter database biblioteca	--nome antigo
modify name = livraria;		--novo nome

create database livraria;

use livraria;

create table cliente(
	cod_cliente int primary key,
	nome nvarchar(30),
	email nchar(50),
	telefone_1 nchar(11),
	telefone_2 nchar(11),
	rua nvarchar(30),
	bairro nvarchar(30),
	cidade nvarchar(30),
	estado nvarchar(30)
);

create table pessoa_fisica(
	cpf nvarchar(11) primary key,
	rg nvarchar (10),
	cod_cliente int,
	foreign key (cod_cliente) references cliente (cod_cliente)
);

create table pessoa_juridica(
	cnpj nvarchar(14),
	ie nvarchar (14),
	cod_cliente int,
	foreign key (cod_cliente) references cliente (cod_cliente)
);

create table pedido(
	cod_pedido nvarchar(5) primary key,
	cod_cliente int,
	data_pedido datetime,
	valor_pedido smallmoney,
	foreign key (cod_cliente) references cliente (cod_cliente)
);

create table editora(
	cod_editora int primary key,
	telefone_1 nchar(11),
	telefone_2 nchar(11),
	nome_contato nvarchar(30),
	email nvarchar(30)
);

create table livro(
	cod_livro int primary key,
	cod_editora int,
	valor smallmoney,
	ano_publicacao date,
	categoria varchar(255),
	titulo varchar(255),
	autor nvarchar(30),
	foreign key (cod_editora) references editora (cod_editora)
);

create table estoque(
	cod_estoque int primary key,
	cod_editora int,
	cod_livro int,
	foreign key (cod_editora) references editora (cod_editora),
	foreign key (cod_livro) references livro (cod_livro)
);

create table item_pedido(
	cod_item_pedido int primary key,
	cod_pedido nvarchar(5),
	cod_livro int,
	foreign key (cod_livro) references livro (cod_livro),
	foreign key (cod_pedido) references pedido (cod_pedido)
);

 -- Inserir clientes
INSERT INTO cliente (cod_cliente, nome, email, telefone_1, telefone_2, rua, bairro, cidade, estado)
VALUES 
(1, 'João Silva', 'joao@email.com', '12345678901', '98765432101', 'Rua A', 'Bairro X', 'Cidade Y', 'Estado Z'),
(2, 'Maria Santos', 'maria@email.com', '12345678902', '98765432102', 'Rua B', 'Bairro Y', 'Cidade Z', 'Estado X'),
(3, 'José Oliveira', 'jose@email.com', '12345678903', '98765432103', 'Rua C', 'Bairro Z', 'Cidade X', 'Estado Y');

-- Inserir pessoas físicas
INSERT INTO pessoa_fisica (cpf, rg, cod_cliente)
VALUES 
('11111111111', '1234567890', 1),
('22222222222', '2345678901', 2),
('33333333333', '3456789012', 3);

-- Inserir pessoas jurídicas
INSERT INTO pessoa_juridica (cnpj, ie, cod_cliente)
VALUES 
('11111111111111', '12345678901234', 1),
('22222222222222', '23456789012345', 2),
('33333333333333', '34567890123456', 3);

-- Inserir pedidos
INSERT INTO pedido (cod_pedido, cod_cliente, data_pedido, valor_pedido)
VALUES 
('00001', 1, '2024-03-13T20:00:00', 50.00),
('00002', 2, '2024-03-14T21:00:00', 75.00),
('00003', 3, '2024-03-15T22:00:00', 100.00);

-- Inserir editoras
INSERT INTO editora (cod_editora, telefone_1, telefone_2, nome_contato, email)
VALUES 
(1, '12345678901', '98765432101', 'Contato 1', 'contato1@email.com'),
(2, '12345678902', '98765432102', 'Contato 2', 'contato2@email.com');

-- Inserir livros
INSERT INTO livro (cod_livro, cod_editora, valor, ano_publicacao, categoria, titulo, autor)
VALUES 
(1, 1, 25.00, '2022-01-01', 'Ficção', 'Livro 1', 'Autor 1'),
(2, 1, 30.00, '2020-01-01', 'Não Ficção', 'Livro 2', 'Autor 2'),
(3, 2, 20.00, '2019-01-01', 'Fantasia', 'Livro 3', 'Autor 3');

-- Inserir itens de estoque
INSERT INTO estoque (cod_estoque, cod_editora, cod_livro)
VALUES 
(1, 1, 1),
(2, 1, 2),
(3, 2, 3);

-- Inserir itens de pedido
INSERT INTO item_pedido (cod_item_pedido, cod_pedido, cod_livro)
VALUES 
(1, '00001', 1),
(2, '00002', 2),
(3, '00003', 3);

select * from cliente;
select * from editora;
select * from estoque;
select * from item_pedido;
select * from livro;
select * from pedido;
select * from pessoa_fisica;
select * from pessoa_juridica;

