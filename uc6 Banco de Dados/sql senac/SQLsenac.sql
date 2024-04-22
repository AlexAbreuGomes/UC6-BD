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
	id_endereco int NOT NULL,									-- referencia a id_endereco em endereco - chave estrangeira que referencia o endereço da instituição na entidade endereco
	id_contrato int NOT NULL,
	foreign key (id_endereco) references endereco (id_endereco), -- referencia a id_endereco em endereco - chave estrangeira que referencia o endereço do funcionário na entidade endereco
	foreign key (id_contrato) references contrato (id_contrato)
);

create table professor(
	id_professor Int primary key, 
	nome nvarchar (255) NOT NULL, 
	especializaçao  nvarchar (255) NOT NULL,
	id_funcionario int NOT NULL,
	id_instituicao int NOT NULL,
	foreign key (id_funcionario) references funcionario (id_funcionario),
	foreign key (id_instituicao) references instituicao (id_instituicao)
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
	id_contrato_aluno int primary key,										-- auto-incrementado
	id_contrato int NOT NULL,												-- referencia a ID_Contrato em Contrato
	id_aluno int NOT NULL,													-- referencia a ID_Aluno em Aluno
	foreign key (id_contrato) references contrato (id_contrato),
	foreign key (id_aluno) references aluno (id_aluno)
);

create table contrato_funcionario(
	id_contrato_funcionario int primary key,								-- Inteiro auto-incrementado
	id_contrato Int NOT NULL,												-- referencia a ID_Contrato em Contrato
	id_funcionario Int NOT NULL,											-- referencia a ID_Funcionario em Funcionario
	cargo nvarchar (50),
	salario Decimal (10,2),
	data_admissao date,
	foreign key (id_contrato) references contrato (id_contrato),
	foreign key (id_funcionario) references funcionario (id_funcionario)
);

create table curso(
	id_curso int primary key,					-- incrementado (chave primária)
	nome nvarchar(255) NOT NULL,				-- nome do curso
	descricao nvarchar (2000) NOT NULL,			-- descrição detalhada do curso
	vaga int NOT NULL, 								
	carga_horaria int NOT NULL,					-- carga horária total do curso
	data_inicio date NOT NULL,					-- data de início do curso
	data_fim date NOT NULL,						-- data de término do curso
	turno nvarchar (20)	NOT NULL,
	id_pagamento int,
	id_instituicao int,
	foreign key (id_instituicao) references instituicao (id_instituicao),
	foreign key (id_pagamento) references pagamento (id_pagamento)
);

create table unidade_curricular(
	id_unidade_curricular int primary key,
	nome_uc nvarchar(100) NOT NULL,
	data_inicial date NOT NULL,
	data_fim date NOT NULL,
	id_aluno int NOT NULL,
	id_funcionario int NOT NULL,
	id_curso int NOT NULL,
	foreign key (id_aluno) references aluno (id_aluno),
	foreign key (id_funcionario) references funcionario (id_funcionario),
	foreign key (id_curso) references curso (id_curso)
);

create table turma(
	id_turma int primary key,
	id_unidade_curricular int NOT NULL,
	foreign key (id_unidade_curricular) references unidade_curricular (id_unidade_curricular)
);

create table aluno(
	id_aluno int primary key,									-- auto-incrementado (chave primária)
	nome nvarchar(255) NOT NULL,								-- nome do aluno
	cpf nvarchar(11) unique,									-- número de Cadastro de Pessoa Física, único para cada aluno
	data_nascimento date NOT NULL,								-- data de nascimento do aluno
	telefone nvarchar(20) NOT NULL,								-- número de telefone do aluno
	genero char (1) NOT NULL,
	email nvarchar(255) unique,									-- endereço de email do aluno, único para cada aluno
	id_endereco int NOT NULL,									-- referencia a id_endereco em endereco - chave estrangeira que referencia o endereço do aluno na entidade endereco
	id_contrato int NOT NULL,
	foreign key (id_endereco) references endereco (id_endereco), -- referencia a id_endereco em endereco - chave estrangeira que referencia o endereço do funcionário na entidade endereco
	foreign key (id_contrato) references contrato (id_contrato)
);

create table aluno_comercial(
	id_aluno_comercial int primary key, 					--auto-incrementado
	id_aluno int NOT NULL,									-- referencia a ID_Aluno em Aluno
	id_curso int NOT NULL,
	foreign key (id_aluno) references aluno (id_aluno),
	foreign key (id_curso) references curso (id_curso)
);

create table aluno_psg(
	id_aluno_psg int primary key,								--auto-incrementado
	id_aluno int NOT NULL,
	id_curso int NOT NULL,
	foreign key (id_aluno) references aluno (id_aluno),
	foreign key (id_curso) references curso (id_curso)
);

create table aluno_aprendiz(
	id_aluno_aprendiz int primary key,
	id_aluno int NOT NULL,
	id_curso int NOT NULL,
	foreign key (id_aluno) references aluno (id_aluno),
	foreign key (id_curso) references curso (id_curso)
);

create table pagamento(	
	id_pagamento int primary key,								--auto-incrementado
	data_pagamento date NOT NULL,								-- data do pagamento
	valor_pagamento smallmoney NOT NULL,						-- armazena pequenos precos 
	numero_parcela Int , 
	observacoes nvarchar(2000) NULL, 
	id_contrato int NOT NULL,									-- referencia a ID_Contrato em Contrato
	foreign key (id_contrato) references contrato (id_contrato)
);

create table pag_pix(
	id_pag_pix int primary key,
	id_pagamento int NOT NULL,
	foreign key (id_pagamento) references pagamento (id_pagamento),
);

create table pag_especie(
	id_pag_especie int primary key,
	id_pagamento int NOT NULL,
	foreign key (id_pagamento) references pagamento (id_pagamento),
);

create table pag_cartao(
	id_pag_cartao int primary key,
	id_pagamento int NOT NULL,
	foreign key (id_pagamento) references pagamento (id_pagamento),
);

create table pag_debito(
	id_pag_debito int primary key,
	id_pag_cartao int,
	foreign key (id_pag_cartao) references pag_cartao (id_pag_cartao)
);

create table curso_tec(
	id_curso_tec  int primary key,								-- auto-incrementado
	area_tecnica  nvarchar(50) NOT NULL,						-- area do curso
	id_curso  Int NOT NULL,										-- referencia a ID_Curso em Curso
	foreign key (id_curso) references curso (id_curso)
);

create table curso_livre(
	id_curso_livre Int primary key,								-- auto-incrementado
	id_curso  Int NOT NULL,										-- referencia a ID_Curso em Curso
	foreign key (id_curso) references curso (id_curso)
);

create table idioma(
	id_idioma int primary key,					        -- auto-incrementado
	nivel_proficiencia nvarchar (50) NOT NULL,
	id_curso int NOT NULL,										-- referencia a ID_Curso em Curso
	foreign key (id_curso) references curso (id_curso)
);

create table curso_ingles(
	id_curso_ingles int primary key,
	id_idioma int NOT NULL,
	foreign key (id_idioma) references idioma(id_idioma)
);

create table curso_italiano(
	id_curso_italiano int primary key,
	id_idioma int NOT NULL,
	foreign key (id_idioma) references idioma(id_idioma)
);

create table curso_espanhol(
	id_curso_espanhol int primary key,
	id_idioma int NOT NULL,
	foreign key (id_idioma) references idioma(id_idioma)
);

create table curso_alemao(
	id_curso_alemao int primary key,
	id_idioma int NOT NULL,
	foreign key (id_idioma) references idioma(id_idioma)
);

create table curso_frances(
	id_curso_frances int primary key,
	id_idioma int NOT NULL,
	foreign key (id_idioma) references idioma(id_idioma)
);

