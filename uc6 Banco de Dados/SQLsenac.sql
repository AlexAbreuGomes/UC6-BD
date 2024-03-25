create database senac 

use senac

create table instituicao(
	id_instituicao int primary key,				-- auto-incrementado (chave primária)
	nome nvarchar(255) NOT NULL,				-- nome da instituição
	cnpj nvarchar(14)unique,					-- número de Cadastro Nacional da Pessoa Jurídica, (unique) = único para a instituição
	id_endereco int NOT NULL,					-- referencia a id_endereco em endereco - chave estrangeira que referencia o endereço da instituição na entidade endereco
	telefone nvarchar(20) NOT NULL,				-- número de telefone da instituição
	email nvarchar(255) unique					-- endereço de email da instituição, único para a instituição
	--foreign key (id_endereco) references endereco (id_endereco)
);

create table funcionario(
	id_funcionario int primary key,				-- auto-incrementado (chave primária)
	nome nvarchar(255) NOT NULL,				-- nome do funcionário
	cpf nvarchar(11) unique,					-- número de Cadastro de Pessoa Física, único para cada funcionário
	data_nascimento date NOT NULL,				-- data de nascimento do funcionário
	cargo varchar(50)NOT NULL,					-- cargo do funcionário na instituição
	salario decimal(10,2) NOT NULL,				-- salário do funcionário
	data_admissao date NOT NULL,				-- data de admissão do funcionário na instituição
	id_endereco int								-- referencia a id_endereco em endereco - chave estrangeira que referencia o endereço da instituição na entidade endereco
	--foreign key (id_endereco) references endereco (id_endereco) -- referencia a id_endereco em endereco - chave estrangeira que referencia o endereço do funcionário na entidade endereco
);

create table departamento(
	id_departamento Int primary key, 
	nome nvarchar (255),
	id_instituicao int,
	descricao nvarchar (2000), 
	responsavel  nvarchar (255)
);

create table contrato(
	id_contrato int primary key,				-- auto-incrementado (chave primária)
	data_contrato date NOT NULL,				-- Data de assinatura do contrato
	tipo_contrato nvarchar(50) NOT NULL,		-- Tipo de contrato (bolsa, estágio, etc.)
	status_contrato nvarchar(50) NOT NULL		-- Status do contrato (ativo, inativo, etc.)
);


create table endereco(
	id_endereco int primary key,				-- int auto-incrementado (chave primária)
	logradouro nvarchar(255) NOT NULL,			-- nome da rua, avenida, etc.
	numero nvarchar(10) NOT NULL,				-- número do endereço
	complemento nvarchar(100) NULL,				-- complemento do endereço (apartamento, bloco, etc.)
	bairro nvarchar(100) NOT NULL,				-- bairro do endereço
	cidade nvarchar(100) NOT NULL,				-- cidade do endereço
	uf nchar(2) NOT NULL,						-- estado (unidade federativa) do endereço
	cep nvarchar(8)	NOT NULL					-- código de Endereço Postal
);

create table curso(
	id_curso int primary key,					-- incrementado (chave primária)
	nome nvarchar(255) NOT NULL,				-- nome do curso
	descricao nvarchar (2000) NOT NULL,			-- descrição detalhada do curso
	carga_horaria int NOT NULL,					-- carga horária total do curso
	data_inicio date NOT NULL,					-- data de início do curso
	data_fim date NOT NULL						-- data de término do curso
);

create table aluno(
	id_aluno int primary key,					-- auto-incrementado (chave primária)
	nome nvarchar(255) NOT NULL,				-- nome do aluno
	cpf nvarchar(11) unique,					-- número de Cadastro de Pessoa Física, único para cada aluno
	data_nascimento date NOT NULL,				-- data de nascimento do aluno
	telefone nvarchar(20) NOT NULL,				-- número de telefone do aluno
	email nvarchar(255) unique,					-- endereço de email do aluno, único para cada aluno
	id_endereco int								-- referencia a id_endereco em endereco - chave estrangeira que referencia o endereço do aluno na entidade endereco
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

