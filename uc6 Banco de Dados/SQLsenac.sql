create database senac 

use senac

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

create table instituicao(
	id_instituicao int primary key,				-- auto-incrementado (chave primária)
	nome nvarchar(255) NOT NULL,				-- nome da instituição
	cnpj nvarchar(14)unique,					-- número de Cadastro Nacional da Pessoa Jurídica, (unique) = único para a instituição
	id_endereco int NOT NULL,					-- referencia a id_endereco em endereco - chave estrangeira que referencia o endereço da instituição na entidade endereco
	telefone nvarchar(20) NOT NULL,				-- número de telefone da instituição
	email nvarchar(255) unique					-- endereço de email da instituição, único para a instituição
	foreign key (id_endereco) references endereco (id_endereco)
);

create table funcionario(
	id_funcionario int primary key,								-- auto-incrementado (chave primária)
	nome nvarchar(255) NOT NULL,								-- nome do funcionário
	cpf nvarchar(11) unique,									-- número de Cadastro de Pessoa Física, único para cada funcionário
	data_nascimento date NOT NULL,								-- data de nascimento do funcionário
	cargo nvarchar(50)NOT NULL,									-- cargo do funcionário na instituição
	salario decimal(10,2) NOT NULL,								-- salário do funcionário
	data_admissao date NOT NULL,								-- data de admissão do funcionário na instituição
	id_endereco int,											-- referencia a id_endereco em endereco - chave estrangeira que referencia o endereço da instituição na entidade endereco
	id_contrato int,
	foreign key (id_endereco) references endereco (id_endereco) -- referencia a id_endereco em endereco - chave estrangeira que referencia o endereço do funcionário na entidade endereco
	foreign key (id_contrato) references contrato (id_contrato)
);

create table professor(
	id_professor Int primary key, 
	nome nvarchar (255), 
	especializaçao  nvarchar (255),
	id_funcionario int,
	id_instituicao int,

);

create table contrato(
	id_contrato int primary key,				-- auto-incrementado (chave primária)
	data_contrato date NOT NULL,				-- Data de assinatura do contrato
	tipo_contrato nvarchar(50) NOT NULL,		-- Tipo de contrato (bolsa, estágio, etc.)
	status_contrato nvarchar(50) NOT NULL,		-- Status do contrato (ativo, inativo, etc.)
	id_instituicao int,
	foreign key (id_instituicao) references instituicao (id_instituicao)
);

create table contrato_aluno(
	id_contrato_aluno int primary key,								-- auto-incrementado
	id_contrato int,												-- referencia a ID_Contrato em Contrato
	id_aluno int,													-- referencia a ID_Aluno em Aluno

);

create table curso(
	id_curso int primary key,					-- incrementado (chave primária)
	nome nvarchar(255) NOT NULL,				-- nome do curso
	descricao nvarchar (2000) NOT NULL,			-- descrição detalhada do curso
	carga_horaria int NOT NULL,					-- carga horária total do curso
	data_inicio date NOT NULL,					-- data de início do curso
	data_fim date NOT NULL,						-- data de término do curso
	id_aluno int NOT NULL						-- id aluno
	foreign key (id_aluno) references aluno (id_aluno)  
);

create table aluno(
	id_aluno int primary key,									-- auto-incrementado (chave primária)
	nome nvarchar(255) NOT NULL,								-- nome do aluno
	cpf nvarchar(11) unique,									-- número de Cadastro de Pessoa Física, único para cada aluno
	data_nascimento date NOT NULL,								-- data de nascimento do aluno
	telefone nvarchar(20) NOT NULL,								-- número de telefone do aluno
	email nvarchar(255) unique,									-- endereço de email do aluno, único para cada aluno
	id_endereco int,											-- referencia a id_endereco em endereco - chave estrangeira que referencia o endereço do aluno na entidade endereco
	id_contrato int,
	foreign key (id_endereco) references endereco (id_endereco), -- referencia a id_endereco em endereco - chave estrangeira que referencia o endereço do funcionário na entidade endereco
	foreign key (id_contrato) references contrato (id_contrato)
);

create table forma_pagamento(
	id_forma_pagamento Int primary key,							-- auto-incrementado
	nome nvarchar (50),
	descricao nvarchar(2000)
);

create table pagamento(	
	id_pagamento int primary key,								--auto-incrementado
	data_pagamento date NOT NULL,								-- data do pagamento
	valor_pagamento smallmoney NOT NULL,						-- armazena pequenos precos 
	numero_parcela Int NOT NULL, 
	observacoes nvarchar(2000) NULL, 
	id_contrato int NOT NULL,									-- referencia a ID_Contrato em Contrato
	id_forma_pagamento int NOT NULL,							-- referencia a ID_FormaPagamento em FormaPagamento
	foreign key (id_contrato) references contrato (id_contrato),
	foreign key (id_forma_pagamento) references forma_pagamento (id_forma_pagamento)
);

create table curso_tec(
	id_curso_tec  int primary key,								-- auto-incrementado
	area_tecnica  nvarchar(50),									--area do curso
	id_curso  Int,												-- referencia a ID_Curso em Curso
	foreign key (id_curso) references curso (id_curso)
	
);

create table curso_livre(
	id_curso_livre Int primary key,								-- auto-incrementado
	id_curso  Int NOT NULL,										-- referencia a ID_Curso em Curso
	foreign key (id_curso) references curso (id_curso)
	
);

create table idioma(
	id_curso_idioma int primary key,					        -- auto-incrementado
	nivel_proficiencia nvarchar (50) NOT NULL,
	id_curso int NOT NULL,										-- referencia a ID_Curso em Curso
	id_pagamento int NOT NULL,
	foreign key (id_curso) references curso (id_curso),
	foreign key (id_pagamento) references pagamento (id_pagamento)

);

create table curso_ingles(
	id_curso_ingles int primary key,
	nivel nvarchar(50) NOT NULL,
	id_idioma int NOT NULL,
	foreign key (id_idioma) references idioma(id_idioma)
);

create table curso_italiano(
	id_curso_italiano int primary key,
	nivel nvarchar(50) NOT NULL,
	id_idioma int NOT NULL,
	foreign key (id_idioma) references idioma(id_idioma)
);

create table curso_espanhol(
	id_curso_espanhol int primary key,
	nivel nvarchar(50) NOT NULL,
	id_idioma int NOT NULL,
	foreign key (id_idioma) references idioma(id_idioma)
);

create table curso_alemao(
	id_curso_alemao int primary key,
	nivel nvarchar(50) NOT NULL,
	id_idioma int NOT NULL,
	foreign key (id_idioma) references idioma(id_idioma)
);

create table curso_frances(
	id_curso_frances int primary key,
	nivel nvarchar(50) NOT NULL,
	id_idioma int NOT NULL,
	foreign key (id_idioma) references idioma(id_idioma)
);

create table aluno_comercial(
	id_aluno_comercial int primary key, 					--auto-incrementado
	id_aluno int NOT NULL,									-- referencia a ID_Aluno em Aluno
	id_pagamento int NOT NULL,
	foreign key (id_aluno) references aluno (id_aluno),
	foreign key (id_pagamento) references pagamento (id_pagamento)
);

create table aluno_psg(
id_aluno_psg int primary key,								--auto-incrementado
id_aluno int NOT NULL,
id_curso int NOT NULL,
foreign key (id_aluno) references aluno (id_aluno),
foreign key (id_curso) references curso (id_curso)
);