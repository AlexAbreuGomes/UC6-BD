create database senac 

use senac

create table instituicao(
	id_instituicao int primary key,				-- auto-incrementado (chave prim�ria)
	nome nvarchar(255) NOT NULL,				-- nome da institui��o
	cnpj nvarchar(14)unique,					-- n�mero de Cadastro Nacional da Pessoa Jur�dica, (unique) = �nico para a institui��o
	id_endereco int NOT NULL,					-- referencia a id_endereco em endereco - chave estrangeira que referencia o endere�o da institui��o na entidade endereco
	telefone nvarchar(20) NOT NULL,				-- n�mero de telefone da institui��o
	email nvarchar(255) unique					-- endere�o de email da institui��o, �nico para a institui��o
	--foreign key (id_endereco) references endereco (id_endereco)
);

create table funcionario(
	id_funcionario int primary key,				-- auto-incrementado (chave prim�ria)
	nome nvarchar(255) NOT NULL,				-- nome do funcion�rio
	cpf nvarchar(11) unique,					-- n�mero de Cadastro de Pessoa F�sica, �nico para cada funcion�rio
	data_nascimento date NOT NULL,				-- data de nascimento do funcion�rio
	cargo varchar(50)NOT NULL,					-- cargo do funcion�rio na institui��o
	salario decimal(10,2) NOT NULL,				-- sal�rio do funcion�rio
	data_admissao date NOT NULL,				-- data de admiss�o do funcion�rio na institui��o
	id_endereco int								-- referencia a id_endereco em endereco - chave estrangeira que referencia o endere�o da institui��o na entidade endereco
	--foreign key (id_endereco) references endereco (id_endereco) -- referencia a id_endereco em endereco - chave estrangeira que referencia o endere�o do funcion�rio na entidade endereco
);

create table departamento(
	id_departamento Int primary key, 
	nome nvarchar (255),
	id_instituicao int,
	descricao nvarchar (2000), 
	responsavel  nvarchar (255)
);

create table contrato(
	id_contrato int primary key,				-- auto-incrementado (chave prim�ria)
	data_contrato date NOT NULL,				-- Data de assinatura do contrato
	tipo_contrato nvarchar(50) NOT NULL,		-- Tipo de contrato (bolsa, est�gio, etc.)
	status_contrato nvarchar(50) NOT NULL		-- Status do contrato (ativo, inativo, etc.)
);


create table endereco(
	id_endereco int primary key,				-- int auto-incrementado (chave prim�ria)
	logradouro nvarchar(255) NOT NULL,			-- nome da rua, avenida, etc.
	numero nvarchar(10) NOT NULL,				-- n�mero do endere�o
	complemento nvarchar(100) NULL,				-- complemento do endere�o (apartamento, bloco, etc.)
	bairro nvarchar(100) NOT NULL,				-- bairro do endere�o
	cidade nvarchar(100) NOT NULL,				-- cidade do endere�o
	uf nchar(2) NOT NULL,						-- estado (unidade federativa) do endere�o
	cep nvarchar(8)	NOT NULL					-- c�digo de Endere�o Postal
);

create table curso(
	id_curso int primary key,					-- incrementado (chave prim�ria)
	nome nvarchar(255) NOT NULL,				-- nome do curso
	descricao nvarchar (2000) NOT NULL,			-- descri��o detalhada do curso
	carga_horaria int NOT NULL,					-- carga hor�ria total do curso
	data_inicio date NOT NULL,					-- data de in�cio do curso
	data_fim date NOT NULL						-- data de t�rmino do curso
);

create table aluno(
	id_aluno int primary key,					-- auto-incrementado (chave prim�ria)
	nome nvarchar(255) NOT NULL,				-- nome do aluno
	cpf nvarchar(11) unique,					-- n�mero de Cadastro de Pessoa F�sica, �nico para cada aluno
	data_nascimento date NOT NULL,				-- data de nascimento do aluno
	telefone nvarchar(20) NOT NULL,				-- n�mero de telefone do aluno
	email nvarchar(255) unique,					-- endere�o de email do aluno, �nico para cada aluno
	id_endereco int								-- referencia a id_endereco em endereco - chave estrangeira que referencia o endere�o do aluno na entidade endereco
);

create table pagamento(
	id_pagamento int primary key,				--auto-incrementado
	data_pagamento date NOT NULL,				-- data do pagamento
	valor_pagamento smallmoney NOT NULL,	    -- armazena pequenos precos 
	numero_parcela Int NOT NULL, 
	observacoes nvarchar(2000) NULL, 
	id_contrato int NOT NULL,					-- referencia a ID_Contrato em Contrato
	id_forma_pagamento int NOT NULL				-- referencia a ID_FormaPagamento em FormaPagamento
	--foreign key (id_contrato) references contrato (id_contrato)
	--foreign key (id_forma_pagamento) references forma_pagamento (id_forma_pagamento)
);

create table forma_pagamento(
	id_forma_pagamento Int primary key,			-- auto-incrementado
	nome nvarchar (50),
	descricao nvarchar(2000)
);

