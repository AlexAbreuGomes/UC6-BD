

		/*Crie as instruções em SQL Server para as questões abaixo:
		1. Retornar todos os livros de sociologia.
		2. Listar os nomes dos funcionários que são bibliotecários.
		3. Exibir os títulos dos livros publicados antes de 2000.
		4. Mostrar o número total de livros em cada biblioteca.
		5. Listar os eventos do tipo 'Workshop' que ocorreram após 2020.
		6. Exibir os nomes dos usuários que fizeram empréstimos de livros em janeiro de 2023.
		7. Retornar os títulos dos livros de tecnologia que têm 'Python' no título.
		8. Listar os títulos dos periódicos disponíveis na biblioteca com CNPJ 
		'12345678000123'.
		9. Mostrar os nomes dos funcionários que não são técnicos de TI.
		10.Exibir o título e o autor dos livros emprestados pelo usuário com ID 'U0001'.
		11.Listar todas as palestras que custaram mais de R$ 100,00.
		12.Retornar os títulos dos livros de ciência que foram publicados após 2010.
		13.Exibir os nomes dos atendentes que têm 'Maria' no nome.
		14.Mostrar os títulos dos livros que foram emprestados mais de 5 vezes.
		15.Listar os nomes dos usuários que emprestaram livros de tecnologia.
		16.Exibir os eventos que ocorreram na biblioteca '67890123000178' em 2022.
		17.Retornar os títulos dos periódicos que têm 'Saúde' no título.
		18.Listar os nomes dos estagiários que começam com a letra 'L'.
		19.Mostrar os títulos dos livros de sociologia que foram publicados nos anos 90.
		20.Exibir os títulos dos livros e os nomes dos autores dos livros emprestados em 
		fevereiro de 2023.*/


				/*questao 01
1. Retornar todos os livros de sociologia.*/
use sistema_biblioteca;

SELECT livro.Titulo, LIVRO.numero_registro
FROM LIVRO
JOIN SOCIOLOGIA ON SOCIOLOGIA.numero_registro = LIVRO.numero_registro;

select * from SOCIOLOGIA;

				/*questao 02
2. Listar os nomes dos funcionários que são bibliotecários.*/

select funcionario.nome
from FUNCIONARIO
join BIBLIOTECARIO on BIBLIOTECARIO.matricula = FUNCIONARIO.matricula;

				/*questao 03
3. Exibir os títulos dos livros publicados antes de 2000.*/

SELECT Livro.titulo, LIVRO.ano_publicacao
from LIVRO
WHERE ano_publicacao < 2000;

				/*questao 04
4. Mostrar o número total de livros em cada biblioteca.*/



insert into LIVRO_BIBLIOTECA (cnpj, numero_registro) values
('01234567000112',1),
('01234567000112',2),
('01234567000112',3),
('01234567000112',4),
('01234567000112',5);
insert into LIVRO_BIBLIOTECA (cnpj, numero_registro) values
('12345678000123',6),
('12345678000123',7),
('12345678000123',8),
('12345678000123',9),
('12345678000123',10);
insert into LIVRO_BIBLIOTECA (cnpj, numero_registro) values
('23456789000134',11),
('23456789000134',12),
('23456789000134',13),
('23456789000134',14),
('23456789000134',15);
insert into LIVRO_BIBLIOTECA (cnpj, numero_registro) values
('34567890000145',16),
('34567890000145',17),
('34567890000145',18),
('34567890000145',19),
('34567890000145',20);
insert into LIVRO_BIBLIOTECA (cnpj, numero_registro) values
('45678901000156',21),
('45678901000156',22),
('45678901000156',23),
('45678901000156',24),
('45678901000156',25);
insert into LIVRO_BIBLIOTECA (cnpj, numero_registro) values
('56789012000167',26),
('56789012000167',27),
('56789012000167',28),
('56789012000167',29),
('56789012000167',30);
insert into LIVRO_BIBLIOTECA (cnpj, numero_registro) values
('67890123000178',31),
('67890123000178',32),
('67890123000178',33),
('67890123000178',34),
('67890123000178',35);
insert into LIVRO_BIBLIOTECA (cnpj, numero_registro) values
('78901234000189',36),
('78901234000189',37),
('78901234000189',38),
('78901234000189',39),
('78901234000189',40);
insert into LIVRO_BIBLIOTECA (cnpj, numero_registro) values
('89012345000190',41),
('89012345000190',42),
('89012345000190',43),
('89012345000190',44),
('89012345000190',45);
insert into LIVRO_BIBLIOTECA (cnpj, numero_registro) values
('90123456000101',46),
('90123456000101',47),
('90123456000101',48),
('90123456000101',49),
('90123456000101',50);

select * from LIVRO_BIBLIOTECA;

TRUNCATE TABLE livro_biblioteca


SELECT LIVRO_BIBLIOTECA.cnpj, count(*)  AS total_biblioteca
FROM LIVRO_BIBLIOTECA
JOIN LIVRO ON LIVRO_BIBLIOTECA.numero_registro = LIVRO.numero_registro
GROUP BY cnpj;

					/*questao 05
5. Listar os eventos do tipo 'Workshop' que ocorreram após 2020.*/

select * from EVENTO
join WORKSHOP on WORKSHOP.id_evento = EVENTO.id_evento
WHERE YEAR (DATA) > 2020;

					/*QUESTAO 06
6. Exibir os nomes dos usuários que fizeram empréstimos de livros em janeiro de 2023.*/

create table endereco(
	id_endereco int primary key identity (1,1),
	rua nvarchar (100) not null, 
	bairro nvarchar (50) not null,
	cidade nvarchar (50) not null,
	uf char (2) not null,
	cep nchar (8) not null,
	numero nvarchar (30) not null
);

create table usuario(
	id_usuario int primary key identity(1,1),
	nome nvarchar (20) not null,
	sobrenome nvarchar (40) not null,
	cpf nchar (11) not null,
	data_nasc date not null,
	telefone nchar (11) not null,
	email nvarchar (50) not null,
	id_endereco int not null,
	foreign key (id_endereco) references endereco (id_endereco)
); 
ALTER TABLE usuario DROP CONSTRAINT FK__usuario__id_ende__71D1E811;
ALTER TABLE usuario DROP CONSTRAINT PK__usuario__4E3E04AD5082BB38;
drop table usuario;

create table emprestimo(
	id_emprestimo int  primary key identity(1,1),
	data_emprestimo date not null,
	prazo int not null,
	data_devolucao date null,
	id_usuario int not null,
	numero_registro int not null,
	foreign key (id_usuario) references usuario (id_usuario),
	foreign key (numero_registro) references livro (numero_registro),
	
);
ALTER TABLE emprestimo DROP CONSTRAINT FK__emprestim__id_us__74AE54BC
drop table emprestimo;

insert into endereco (rua, bairro, cidade, uf, cep, numero) values 
	('Rua Mossoró', 'Cidade Alta', 'Natal', 'RN', '59025200', '100'),
	('Avenida Engenheiro Roberto Freire', 'Ponta Negra', 'Natal', 'RN', '59090000', '500'),
	('Rua Praia de Pirangi', 'Pirangi do Norte', 'Parnamirim', 'RN', '59161050', '300'),
	('Avenida Prudente de Morais', 'Tirol', 'Natal', 'RN', '59020400', '900'),
	('Rua dos Cajueiros', 'Candelária', 'Natal', 'RN', '59064050', '200'),
	('Avenida Governador Silvio Pedrosa', 'Areia Preta', 'Natal', 'RN', '59014100', '1500'),
	('Rua das Algas', 'Ponta Negra', 'Natal', 'RN', '59094300', '700'),
	('Avenida Capitão Mor-Gouveia', 'Cidade Alta', 'Natal', 'RN', '59025000', '1000'),
	('Rua Praia de Ponta Negra', 'Ponta Negra', 'Natal', 'RN', '59092300', '400'),
	('Avenida Presidente Bandeira', 'Lagoa Nova', 'Natal', 'RN', '59056000', '1200'),
	('Rua Praia de Muriú', 'Muriú', 'Ceará-Mirim', 'RN', '59570000', '800'),
	('Avenida Nascimento de Castro', 'Lagoa Nova', 'Natal', 'RN', '59056450', '5000'),
	('Rua das Gaivotas', 'Ponta Negra', 'Natal', 'RN', '59094020', '600'),
	('Avenida Doutor João Medeiros Filho', 'Potengi', 'Natal', 'RN', '59115000', '1000'),
	('Rua Praia de Camurupim', 'Camurupim', 'Nísia Floresta', 'RN', '59164000', '700'),
	('Avenida Praia de Ponta Negra', 'Ponta Negra', 'Natal', 'RN', '59094020', '2000'),
	('Rua dos Mariscos', 'Ponta Negra', 'Natal', 'RN', '59094110', '300'),
	('Avenida Bernardo Vieira', 'Tirol', 'Natal', 'RN', '59015200', '1500'),
	('Rua Praia de Genipabu', 'Genipabu', 'Extremoz', 'RN', '59575000', '100'),
	('Avenida Hermes da Fonseca', 'Tirol', 'Natal', 'RN', '59015300', '1500');


truncate table endereco; 
select * from endereco;

insert into usuario (nome, sobrenome, cpf, data_nasc, telefone, email, id_endereco )values 
	('João', 'Silva', '12345678901', '1990-05-15', '11987654321', 'joao.silva@email.com', 1),
	('Maria', 'Souza', '98765432109', '1985-08-25', '11976543210', 'maria.souza@email.com', 2),
	('Pedro', 'Santos', '56789012345', '1995-02-10', '11965432109', 'pedro.santos@email.com', 3),
	('Ana', 'Oliveira', '01234567890', '1992-11-30', '11954321098', 'ana.oliveira@email.com', 4);

select * from usuario;

insert into emprestimo (data_emprestimo, prazo, id_usuario, numero_registro ) values 
	('2024-05-02', 10, 1, 1);
insert into emprestimo (data_emprestimo, prazo, id_usuario, numero_registro ) values 
	('2023-01-01', 15, 2, 2),
	('2023-01-05', 10, 3, 1),
	('2023-02-02', 10, 2, 4),
	('2022-01-01', 10, 4, 5);
insert into emprestimo (data_emprestimo, prazo, id_usuario, numero_registro ) values 
	('2024-05-02', 10, 1, 5);
insert into emprestimo (data_emprestimo, prazo, id_usuario, numero_registro ) values 
	('2024-05-02', 10, 1, 8);

select * from emprestimo;

SELECT usuario.nome
FROM usuario
JOIN emprestimo ON emprestimo.id_usuario = usuario.id_usuario
WHERE YEAR(emprestimo.data_emprestimo) = 2023 AND MONTH(emprestimo.data_emprestimo) = 1;

				/* questao 07
7. Retornar os títulos dos livros de tecnologia que têm 'Python' no título.*/

SELECT LIVRO.titulo 
 FROM LIVRO 
 join TECNOLOGIA on TECNOLOGIA.numero_registro = LIVRO.numero_registro
 WHERE titulo LIKE '%python%';

				/*questao 08
 8. Listar os títulos dos periódicos disponíveis na biblioteca com CNPJ '12345678000123'.*/

select PERIODICO.titulo
from PERIODICO
join PERIODICO_BIBLIOTECA on PERIODICO_BIBLIOTECA.numero_registro = PERIODICO.numero_registro
where cnpj = 12345678000123

select * from PERIODICO


		/*questao 09
9. Mostrar os nomes dos funcionários que não são técnicos de TI.*/

/*Podemos combinar o operador In com o operador lógico NOT SQL para determinar
se um valor NÃO corresponde com nenhum valor na lista ou subconsulta realizada:
https://www.bosontreinamentos.com.br/mysql/bancos-de-dados-operadores-in-e-not-in-no-mysql/ link*/

SELECT FUNCIONARIO.nome 
FROM funcionario
WHERE matricula NOT IN (SELECT matricula FROM TECNICO_TI);

select FUNCIONARIO.matricula, FUNCIONARIO.nome
from FUNCIONARIO
join TECNICO_TI on TECNICO_TI.matricula = FUNCIONARIO.matricula;


				/*questao 10
10.Exibir o título e o autor dos livros emprestados pelo usuário com ID '1'.*/


SELECT LIVRO.titulo, LIVRO.autor
FROM emprestimo
JOIN LIVRO ON emprestimo.numero_registro = LIVRO.numero_registro
WHERE emprestimo.id_usuario = 1;

select * from emprestimo;
select * from LIVRO;


				/*questao 11
11.Listar todas as palestras que custaram mais de R$ 100,00.*/

select * from PALESTRA;

select EVENTO.custo, EVENTO.tipo
from EVENTO
join PALESTRA on PALESTRA.id_evento = EVENTO.id_evento
WHERE custo > 100.00

				/* questao 12
12.Retornar os títulos dos livros de ciência que foram publicados após 2010.*/

select LIVRO.titulo, LIVRO.ano_publicacao
from LIVRO
join CIENCIA on CIENCIA.numero_registro = livro.numero_registro
WHERE YEAR (ano_publicacao) > 2010;

				/* questao 13
13.Exibir os nomes dos atendentes que têm 'Maria' no nome.*/
-- o resultado foi errado pois apareceu nome semelhante descobrir como filtrar 

SELECT FUNCIONARIO.nome 
 FROM FUNCIONARIO
 join ATENDENTE on ATENDENTE.matricula = FUNCIONARIO.matricula
 WHERE ATENDENTE.nome LIKE '%Maria%';

select * from FUNCIONARIO

				/*questao 14
14.Mostrar os títulos dos livros que foram emprestados mais de 5 vezes.*/


				/*questao 15
15.Listar os nomes dos usuários que emprestaram livros de tecnologia.*/

SELECT usuario.nome
FROM usuario
join TECNOLOGIA on TECNOLOGIA.numero_registro = usuario.id_usuario

 select emprestimo.id_usuario
 from emprestimo
 join TECNOLOGIA on TECNOLOGIA.numero_registro = emprestimo.id_emprestimo
 
 select * from emprestimo

 select LIVRO.titulo, LIVRO.numero_registro
 from LIVRO
 join TECNOLOGIA on TECNOLOGIA.numero_registro = LIVRO.numero_registro

				/*questao 16
 16.Exibir os eventos que ocorreram na biblioteca '67890123000178' em 2022.*/

 select * from BIBLIOTECA

 select * from EVENTO

				/* questao 17
 17.Retornar os títulos dos periódicos que têm 'Saúde' no título.*/

 SELECT PERIODICO.titulo
 FROM PERIODICO
 WHERE PERIODICO.titulo LIKE '%Saúde%';

 select * from PERIODICO
 where PERIODICO.titulo like '%Saúde%'

				/* questao 18
 18.Listar os nomes dos estagiários que começam com a letra 'L'.*/

 SELECT ESTAGIARIO.nome
 FROM ESTAGIARIO
 WHERE ESTAGIARIO.nome LIKE 'L%';

 select * FROM ESTAGIARIO
 WHERE ESTAGIARIO.nome LIKE 'L%';

				 /*questao 19
19.Mostrar os títulos dos livros de sociologia que foram publicados nos anos 90.*/

select LIVRO.titulo, LIVRO.ano_publicacao
from LIVRO
join SOCIOLOGIA on SOCIOLOGIA.numero_registro = livro.numero_registro
WHERE YEAR (ano_publicacao) > 1989 and (ano_publicacao) < 2000;

				/*questao 20
20.Exibir os títulos dos livros e os nomes dos autores dos livros emprestados em fevereiro de 2023.*/

SELECT LIVRO.titulo, LIVRO.autor
FROM LIVRO
JOIN emprestimo ON emprestimo.id_usuario = LIVRO.numero_registro
WHERE YEAR(emprestimo.data_emprestimo) = 2023 AND MONTH(emprestimo.data_emprestimo) = 2;


