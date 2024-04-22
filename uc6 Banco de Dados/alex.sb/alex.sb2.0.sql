/*	views: ultilizado para consultas constantes, simplificar consultas complexas, encapsula;
	triggers;
	procedures;
	functions;
*/

--views: ultilizado para consultas constantes, simplificar consultas complexas, encapsula;

use sistema_biblioteca
--exemplo
	create view vm_livros_emprestados 
	as
	SELECT LIVRO.titulo, LIVRO.autor
	FROM LIVRO
	JOIN emprestimo ON emprestimo.id_usuario = LIVRO.numero_registro
	WHERE YEAR(emprestimo.data_emprestimo) = 2023 AND MONTH(emprestimo.data_emprestimo) = 2;

	select * from vm_livros_emprestados;

/*--------------------------------------------------------------------------------------------------------------------------------*/

	create procedure splista_funcionario
	as 
	begin 
	select * from FUNCIONARIO
	end;

	exec splista_funcionario;



	create procedure sp_livro_tecnologia
	as
	begin
	SELECT livro.Titulo, LIVRO.numero_registro
	FROM LIVRO
	JOIN TECNOLOGIA ON TECNOLOGIA.numero_registro = LIVRO.numero_registro
	end;

	EXEC sp_livro_tecnologia



	create procedure sp_buscar_livro_concatenado
		@titulo nvarchar(100)
	as
	begin
		select * from LIVRO
		where titulo like '%'+@titulo+'%'
	end;

	exec sp_buscar_livro_concatenado @titulo = 'p'



	alter procedure sp_buscar_livro_ano
		@ano nvarchar(30)
	as
	begin
		select * from livro
		WHERE ano_publicacao = @ano
	end;


	exec sp_buscar_livro_ano @ano = '2016'
	
	
	alter procedure sp_buscar_livro_tecnologia_ano
		@ano nvarchar(30)
	as
	begin
		SELECT Titulo, ano_publicacao
		FROM LIVRO
		JOIN TECNOLOGIA ON TECNOLOGIA.numero_registro = LIVRO.numero_registro
		where ano_publicacao = @ano
	end;

	exec sp_buscar_livro_tecnologia_ano @ano = '2016';



	create procedure sp_inserir_funcionario
		@matricula nvarchar (6),
		@nome nvarchar (50)
	as
	begin
		insert into funcionario (matricula, nome) values (@matricula, @nome)
	end

	exec sp_inserir_funcionario @matricula = 'T02002', @nome = 'Alex de abreu'

	select * from FUNCIONARIO;



	create procedure sp_inserir_funcionario_educador
		@matricula nvarchar (6),
		@nome nvarchar (50)
	as
	begin
		insert into FUNCIONARIO (matricula, nome) values (@matricula, @nome)
		insert into EDUCADOR (matricula, nome) values (@matricula, @nome)
	end;
	
	exec sp_inserir_funcionario_educador @matricula = 'ED0010', @nome = 'Alex Gomes';