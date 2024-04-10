 /*Crie as instruções em SQL Server para as questões abaixo:
Procedures:
1. Criar uma procedure para inserir um registro de funcionário do tipo educador, 
recebendo nome e matrícula como parâmetros.
2. Criar uma procedure para listar os livros de uma categoria específica, recebendo o 
nome da categoria como parâmetro.
3. Criar uma procedure para obter os nomes dos funcionários de um determinado 
cargo, recebendo o cargo como parâmetro.
4. Criar uma procedure para exibir os títulos dos livros publicados antes de um ano 
específico, recebendo o ano como parâmetro.
5. Criar uma procedure para contar o número total de livros em uma biblioteca 
específica, recebendo o CNPJ da biblioteca como parâmetro.
6. Criar uma procedure para listar os eventos de um tipo específico que aconteceram 
após um ano determinado, recebendo o tipo de evento e o ano como parâmetros.
7. Criar uma procedure para mostrar os nomes dos usuários que fizeram empréstimos 
de livros em um mês e ano específicos, recebendo o mês e o ano como parâmetros.
8. Criar uma procedure para encontrar os títulos dos livros de uma categoria específica 
que contenham uma palavra-chave no título, recebendo a categoria e a palavrachave como parâmetros.
9. Criar uma procedure para listar os títulos dos periódicos disponíveis em uma 
biblioteca específica, recebendo o CNPJ da biblioteca como parâmetro.
10.Criar uma procedure para exibir o título e o autor dos livros emprestados por um 
usuário específico, recebendo o ID do usuário como parâmetro.
11.Criar uma procedure para inserir um registro de funcionário do tipo educador, 
recebendo nome e matrícula como parâmetros.
12.Criar uma procedure para listar os livros de uma categoria específica, recebendo o 
nome da categoria como parâmetro.
13.Criar uma procedure para obter os nomes dos funcionários de um determinado 
cargo, recebendo o cargo como parâmetro.
14.Criar uma procedure para exibir os títulos dos livros publicados antes de um ano 
específico, recebendo o ano como parâmetro.
15.Criar uma procedure para contar o número total de livros em uma biblioteca 
específica, recebendo o CNPJ da biblioteca como parâmetro.
16.Criar uma procedure para listar os eventos de um tipo específico que aconteceram 
após um ano determinado, recebendo o tipo de evento e o ano como parâmetros.
17.Criar uma procedure para mostrar os nomes dos usuários que fizeram empréstimos 
de livros em um mês e ano específicos, recebendo o mês e o ano como parâmetros.
18.Criar uma procedure para encontrar os títulos dos livros de uma categoria específica 
que contenham uma palavra-chave no título, recebendo a categoria e a palavrachave como parâmetros.
19.Criar uma procedure para listar os títulos dos periódicos disponíveis em uma 
biblioteca específica, recebendo o CNPJ da biblioteca como parâmetro.
20.Criar uma procedure para exibir o título e o autor dos livros emprestados por um 
usuário específico, recebendo o ID do usuário como parâmetro.*/

/*1. Criar uma procedure para inserir um registro de funcionário do tipo educador, 
recebendo nome e matrícula como parâmetros.*/

use sistema_biblioteca


create procedure sp_inserir_funcionario_educador
		@matricula nvarchar (6),
		@nome nvarchar (50)
	as
	begin
		insert into FUNCIONARIO (matricula, nome) values (@matricula, @nome)
		insert into EDUCADOR (matricula, nome) values (@matricula, @nome)
	end;
	
	exec sp_inserir_funcionario_educador @matricula = 'ED009', @nome = 'Alex Gomes';

	select * from FUNCIONARIO

/*2. Criar uma procedure para listar os livros de uma categoria específica, recebendo o 
nome da categoria como parâmetro.*/

create procedure sp_buscar_livro_tecnologia
	@tecnologia nvarchar(100)
	as
	begin
		SELECT * FROM LIVRO
		JOIN TECNOLOGIA ON TECNOLOGIA.numero_registro = LIVRO.numero_registro
		where titulo like '%'+@tecnologia+'%' 
	end;

	exec sp_buscar_livro_tecnologia  @tecnologia = 'desenvolvimento'

	
/*3. Criar uma procedure para obter os nomes dos funcionários de um determinado cargo recebendo o cargo como parametro*/

 alter procedure sp_funcionario_ti
	@ti nvarchar(50)
	as
	begin
		select funcionario.nome
		from FUNCIONARIO
		join TECNICO_TI on TECNICO_TI.matricula = FUNCIONARIO.matricula
		where funcionario.nome like'%'+@ti+'%'
	end;

	exec sp_funcionario_ti @ti = 'a';

	select * from TECNICO_TI 

/*4. Criar uma procedure para exibir os títulos dos livros publicados antes de um ano 
específico, recebendo o ano como parâmetro.*/

ALTER procedure sp_buscar_livro
		@ano nvarchar(30)
	as
	begin
		SELECT Titulo, ano_publicacao
		FROM LIVRO
		where ano_publicacao < @ano
	end;

	exec sp_buscar_livro @ano = '2000';

/*5. Criar uma procedure para contar o número total de livros em uma biblioteca 
específica, recebendo o CNPJ da biblioteca como parâmetro.*/

create procedure sp_contar_livro
	@total nvarchar(14)
	as
	begin
		SELECT LIVRO_BIBLIOTECA.cnpj, count(*)  AS total_biblioteca
		FROM LIVRO_BIBLIOTECA
		JOIN LIVRO ON LIVRO_BIBLIOTECA.numero_registro = LIVRO.numero_registro
		where cnpj = @total
		GROUP BY cnpj
	end;

	exec sp_contar_livro @total = '01234567000112'
	select * from LIVRO_BIBLIOTECA

/*6. Criar uma procedure para listar os eventos de um tipo específico que aconteceram 
após um ano determinado, recebendo o tipo de evento e o ano como parâmetros.*/

alter procedure sp_listar_evento
	@evento nvarchar (30),
	@ano nvarchar (30)
as
	begin
		SELECT tipo, data
		FROM EVENTO
		where tipo = @evento and  YEAR (DATA) = @ano
	end;

	exec sp_listar_evento @evento = 'palestra' , @ano = '2020'
	exec sp_listar_evento @evento = 'workshop' , @ano = '2020'
	 
	select * from EVENTO

/*7. Criar uma procedure para mostrar os nomes dos usuários que fizeram empréstimos 
de livros em um mês e ano específicos, recebendo o mês e o ano como parâmetros.*/

create procedure sp_usuario_emprestimo
		@mes int,
		@ano int
as
begin
	SELECT nome
	FROM usuario
	JOIN emprestimo ON emprestimo.id_usuario = usuario.id_usuario
	WHERE YEAR(emprestimo.data_emprestimo) = @ano AND MONTH(emprestimo.data_emprestimo) = @mes
end;

exec sp_usuario_emprestimo @mes = 1 , @ano = 2022;

select * from emprestimo

/*8. Criar uma procedure para encontrar os títulos dos livros de uma categoria específica 
que contenham uma palavra-chave no título, recebendo a categoria e a palavrachave como parâmetros.*/

create procedure sp_buscar_livro_sociologia
	@sociologia nvarchar(100)
	as
	begin
		SELECT * FROM LIVRO
		JOIN SOCIOLOGIA ON SOCIOLOGIA.numero_registro = LIVRO.numero_registro
		where titulo like '%'+@sociologia+'%' 
	end;

	exec sp_buscar_livro_sociologia @sociologia = 'casa'


/*9. Criar uma procedure para listar os títulos dos periódicos disponíveis em uma 
biblioteca específica, recebendo o CNPJ da biblioteca como parâmetro.*/

alter procedure sp_listar_livro
	@cnpj nvarchar(14)
	as
	begin
		SELECT titulo
		FROM LIVRO
		JOIN LIVRO_BIBLIOTECA ON LIVRO_BIBLIOTECA.numero_registro = LIVRO.numero_registro
		where cnpj = @cnpj
	end;

	exec sp_listar_livro @cnpj = '12345678000123'

/*10.Criar uma procedure para exibir o título e o autor dos livros emprestados por um 
usuário específico, recebendo o ID do usuário como parâmetro.*/

create procedure sp_livro_emprestado
	@usuario int
as
begin
	SELECT LIVRO.titulo, LIVRO.autor
	FROM emprestimo
	JOIN LIVRO ON emprestimo.numero_registro = LIVRO.numero_registro
	WHERE emprestimo.id_usuario = @usuario;
END;

exec sp_livro_emprestado @usuario = 3

select * from emprestimo

/*11.Criar uma procedure para inserir um registro de funcionário do tipo educador, 
recebendo nome e matrícula como parâmetros.*/

create procedure sp_inserir_funcionario_educador
		@matricula nvarchar (6),
		@nome nvarchar (50)
	as
	begin
		insert into FUNCIONARIO (matricula, nome) values (@matricula, @nome)
		insert into EDUCADOR (matricula, nome) values (@matricula, @nome)
	end;
	
	exec sp_inserir_funcionario_educador @matricula = 'ED0010', @nome = 'Alex Gomes';


/*12.Criar uma procedure para listar os livros de uma categoria específica, recebendo o 
nome da categoria como parâmetro.*/


/*13.Criar uma procedure para obter os nomes dos funcionários de um determinado 
cargo, recebendo o cargo como parâmetro.*/

CREATE PROCEDURE sp_encontrar_livros_por_categoria_e_palavra_chave
    @categoria nvarchar(100),
    @palavra_chave nvarchar(100)
AS
BEGIN
    SELECT LIVRO.titulo
    FROM LIVRO
    JOIN @categoria ON @categoria.numero_registro = LIVRO.numero_registro
    WHERE LIVRO.titulo LIKE '%' + @palavra_chave + '%';
END;
--errado revisar depois 