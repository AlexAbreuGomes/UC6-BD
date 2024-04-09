 /*Crie as instru��es em SQL Server para as quest�es abaixo:
Procedures:
1. Criar uma procedure para inserir um registro de funcion�rio do tipo educador, 
recebendo nome e matr�cula como par�metros.
2. Criar uma procedure para listar os livros de uma categoria espec�fica, recebendo o 
nome da categoria como par�metro.
3. Criar uma procedure para obter os nomes dos funcion�rios de um determinado 
cargo, recebendo o cargo como par�metro.
4. Criar uma procedure para exibir os t�tulos dos livros publicados antes de um ano 
espec�fico, recebendo o ano como par�metro.
5. Criar uma procedure para contar o n�mero total de livros em uma biblioteca 
espec�fica, recebendo o CNPJ da biblioteca como par�metro.
6. Criar uma procedure para listar os eventos de um tipo espec�fico que aconteceram 
ap�s um ano determinado, recebendo o tipo de evento e o ano como par�metros.
7. Criar uma procedure para mostrar os nomes dos usu�rios que fizeram empr�stimos 
de livros em um m�s e ano espec�ficos, recebendo o m�s e o ano como par�metros.
8. Criar uma procedure para encontrar os t�tulos dos livros de uma categoria espec�fica 
que contenham uma palavra-chave no t�tulo, recebendo a categoria e a palavrachave como par�metros.
9. Criar uma procedure para listar os t�tulos dos peri�dicos dispon�veis em uma 
biblioteca espec�fica, recebendo o CNPJ da biblioteca como par�metro.
10.Criar uma procedure para exibir o t�tulo e o autor dos livros emprestados por um 
usu�rio espec�fico, recebendo o ID do usu�rio como par�metro.
11.Criar uma procedure para inserir um registro de funcion�rio do tipo educador, 
recebendo nome e matr�cula como par�metros.
12.Criar uma procedure para listar os livros de uma categoria espec�fica, recebendo o 
nome da categoria como par�metro.
13.Criar uma procedure para obter os nomes dos funcion�rios de um determinado 
cargo, recebendo o cargo como par�metro.
14.Criar uma procedure para exibir os t�tulos dos livros publicados antes de um ano 
espec�fico, recebendo o ano como par�metro.
15.Criar uma procedure para contar o n�mero total de livros em uma biblioteca 
espec�fica, recebendo o CNPJ da biblioteca como par�metro.
16.Criar uma procedure para listar os eventos de um tipo espec�fico que aconteceram 
ap�s um ano determinado, recebendo o tipo de evento e o ano como par�metros.
17.Criar uma procedure para mostrar os nomes dos usu�rios que fizeram empr�stimos 
de livros em um m�s e ano espec�ficos, recebendo o m�s e o ano como par�metros.
18.Criar uma procedure para encontrar os t�tulos dos livros de uma categoria espec�fica 
que contenham uma palavra-chave no t�tulo, recebendo a categoria e a palavrachave como par�metros.
19.Criar uma procedure para listar os t�tulos dos peri�dicos dispon�veis em uma 
biblioteca espec�fica, recebendo o CNPJ da biblioteca como par�metro.
20.Criar uma procedure para exibir o t�tulo e o autor dos livros emprestados por um 
usu�rio espec�fico, recebendo o ID do usu�rio como par�metro.*/

/*1. Criar uma procedure para inserir um registro de funcion�rio do tipo educador, 
recebendo nome e matr�cula como par�metros.*/

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

/*2. Criar uma procedure para listar os livros de uma categoria espec�fica, recebendo o 
nome da categoria como par�metro.*/

create procedure sp_buscar_livro_tecnologia
	@tecnologia nvarchar(100)
	as
	begin
		SELECT * FROM LIVRO
		JOIN TECNOLOGIA ON TECNOLOGIA.numero_registro = LIVRO.numero_registro
		where titulo like '%'+@tecnologia+'%' 
	end;

	exec sp_buscar_livro_tecnologia  @tecnologia = 'py'

	
/*3. Criar uma procedure para obter os nomes dos funcion�rios de um determinado cargo recebendo o cargo como parametro*/

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


