create database senac 

use senac

create table endereco(


	id_endereco int primary key IDENTITY(1,1),				-- int auto-incrementado (chave primária)
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

<<<<<<< HEAD
=======
-- Inserindo 10 endereços de Natal
INSERT INTO endereco (id_endereco, logradouro, numero, complemento, bairro, cidade, uf, cep) VALUES
(1, 'Rua dos Girassóis', '123', 'Apto. 301', 'Centro', 'Natal', 'RN', '59010000'),
(2, 'Avenida das Palmeiras', '456', 'Casa', 'Pontal', 'Parnamirim', 'RN', '59140000'),
(3, 'Rua da Praia', '789', 'Bloco B', 'Areia Preta', 'Natal', 'RN', '59015000'),
(4, 'Travessa do Sol', '20', 'Fundos', 'Rocas', 'Natal', 'RN', '59016000'),
(5, 'Beco da Esperança', '11', 'Qd. 02', 'Mãe Luíza', 'Parnamirim', 'RN', '59141000'),
(6, 'Alameda dos Ipês', '543', 'Casa A', 'Nova Parnamirim', 'Parnamirim', 'RN', '59142000'),
(7, 'Rua das Flores', '100', 'Loja 1', 'Cidade Alta', 'Natal', 'RN', '59017000'),
(8, 'Avenida João da Silva', '2222', 'Cj. 10', 'Lagoa Nova', 'Natal', 'RN', '59018000'),
(9, 'Rua José de Alencar', '333', 'Sobrado', 'Petrópolis', 'Natal', 'RN', '59019000'),
(10, 'Estrada da Redinha', '4444', 'Sítio Boa Vista', 'Redinha', 'Natal', 'RN', '59020000');

INSERT INTO endereco (id_endereco, logradouro, numero, complemento, bairro, cidade, uf, cep) VALUES
(11, 'Rua dos Coqueiros', '567', 'Apto. 102', 'Ponta Negra', 'Natal', 'RN', '59025000'),
(12, 'Avenida dos Flamboyants', '888', 'Casa', 'Capim Macio', 'Natal', 'RN', '59026000'),
(13, 'Rua das Mangueiras', '1313', 'Bloco C', 'Cidade Verde', 'Parnamirim', 'RN', '59143000'),
(14, 'Travessa das Acácias', '999', 'Fundos', 'Lagoa Seca', 'Natal', 'RN', '59027000'),
(15, 'Beco dos Cajueiros', '25', 'Qd. 05', 'Pajuçara', 'Natal', 'RN', '59028000'),
(16, 'Alameda das Violetas', '321', 'Casa B', 'Emaús', 'Parnamirim', 'RN', '59144000'),
(17, 'Rua dos Antúrios', '777', 'Loja 2', 'Neópolis', 'Natal', 'RN', '59029000'),
(18, 'Avenida das Palmeiras', '444', 'Cj. 20', 'Pitimbu', 'Natal', 'RN', '59030000'),
(19, 'Rua José da Silva', '555', 'Sobrado', 'Candelária', 'Natal', 'RN', '59031000'),
(20, 'Estrada do Cajueiro', '6666', 'Sítio Bela Vista', 'Cidade Nova', 'Natal', 'RN', '59032000'),
(21, 'Rua das Orquídeas', '777', 'Apto. 501', 'Tirol', 'Natal', 'RN', '59033000'),
(22, 'Avenida dos Lírios', '1111', 'Casa', 'Parque das Dunas', 'Natal', 'RN', '59034000'),
(23, 'Travessa das Rosas', '222', 'Bloco D', 'Lagoa Azul', 'Parnamirim', 'RN', '59145000'),
(24, 'Beco dos Ipês', '10', 'Qd. 08', 'Nova Descoberta', 'Natal', 'RN', '59035000'),
(25, 'Alameda dos Cravos', '888', 'Loja 3', 'Potengi', 'Natal', 'RN', '59036000');


select * from endereco

INSERT INTO instituicao (id_instituicao,nome, cnpj, id_endereco, telefone, email) VALUES
(1,'SENAC Natal', '00000000000100', 1, '(84) 40028000', 'natal@rn.senac.br'),
(2,'SENAC Parnamirim', '00000000000200', 2, '(84) 32722200', 'parnamirim@rn.senac.br'),
(3,'SENAC Mossoró', '00000000000300', 3, '(84) 33141400', 'mossoro@rn.senac.br');

select * from instituicao;

INSERT INTO contrato(id_contrato, data_contrato, tipo_contrato, status_contrato, id_instituicao) VALUES 
(1,'2024-05-02','CLT', 'ATIVO', 1),
(2,'2024-06-02','CLT', 'inativo', 1),
(3,'2024-07-02','aluno psg', 'ATIVO', 2),
(4,'2024-08-02','aluno idiomas', 'ATIVO', 3),
(5,'2024-09-02','aprendiz', 'ATIVO', 3);
INSERT INTO contrato(id_contrato,data_contrato, tipo_contrato, status_contrato, id_instituicao) VALUES 
(6, '2024-10-02', 'pagante', 'ATIVO',1);

UPDATE contrato
SET tipo_contrato = 'aluno comercial'
WHERE tipo_contrato = 'aluno idiomas';

DELETE FROM contrato
WHERE id_contrato = 6;

select * from contrato;


INSERT INTO funcionario (id_funcionario, nome, cpf, data_nascimento, cargo, salario, data_admissao, id_endereco, id_contrato) VALUES
    (1, 'João Silva', '12345678901', '1990-05-15', 'Instrutor', 5000.00, '2022-01-10', 1, 1),
    (2, 'Maria Oliveira', '98765432101', '1985-08-20', 'Instrutor', 5200.00, '2021-11-15', 2, 2),
    (3, 'Pedro Santos', '45678912301', '1992-03-30', 'Instrutor', 4800.00, '2021-12-01', 3, 3),
    (4, 'Ana Souza', '78912345601', '1988-11-05', 'Instrutor', 5100.00, '2022-02-20', 4, 1),
    (5, 'Carlos Lima', '65432198701', '1995-07-10', 'Instrutor', 4900.00, '2022-03-05', 5, 1),
    (6, 'José Pereira', '12398745601', '1980-12-25', 'Porteiro', 3000.00, '2022-04-01', 6, 1),
    (7, 'Sandra Oliveira', '98745612301', '1987-09-18', 'Secretário', 3500.00, '2022-05-10', 7, 1),
    (8, 'Fernanda Costa', '78965412301', '1983-04-08', 'Coordenador', 6000.00, '2022-06-15', 8, 1);

UPDATE funcionario
SET id_contrato = 2
WHERE id_contrato = 3;

INSERT INTO funcionario (id_funcionario, nome, cpf, data_nascimento, cargo, salario, data_admissao, id_endereco, id_contrato) VALUES
    (9, 'Laura Oliveira', '98765478901', '1986-02-28', 'Instrutor', 5300.00, '2022-07-20', 9, 1),
    (10, 'Mariana Silva', '45612398701', '1991-06-12', 'Instrutor', 5200.00, '2022-08-10', 10, 1),
    (11, 'Rafael Santos', '65478932101', '1989-09-03', 'Instrutor', 5100.00, '2022-09-05', 11, 1),
    (12, 'Gabriel Oliveira', '12378945601', '1987-11-15', 'Instrutor', 5400.00, '2022-10-15', 12, 1),
    (13, 'Carolina Lima', '32198765401', '1993-04-22', 'Instrutor', 5000.00, '2022-11-20', 13, 1),
    (14, 'Lucas Souza', '98732165401', '1984-08-07', 'Instrutor', 4800.00, '2022-12-01', 14, 1),
    (15, 'Juliana Santos', '65498732101', '1990-12-10', 'Instrutor', 4900.00, '2023-01-10', 15, 1);




select * from funcionario;


INSERT INTO contrato_funcionario (id_contrato_funcionario, id_contrato, id_funcionario, cargo, salario, data_admissao) VALUES
    (1, 1, 1, 'Instrutor', 5000.00, '2022-01-10'),
    (2, 2, 2, 'Instrutor', 5200.00, '2021-11-15'),
    (3, 3, 3, 'Instrutor', 4800.00, '2021-12-01'),
    (4, 1, 4, 'Instrutor', 5100.00, '2022-02-20'),
    (5, 1, 5, 'Instrutor', 4900.00, '2022-03-05'),
    (6, 1, 6, 'Porteiro', 3000.00, '2022-04-01'),
    (7, 1, 7, 'Secretário', 3500.00, '2022-05-10'),
    (8, 1, 8, 'Coordenador', 6000.00, '2022-06-15');

UPDATE contrato_funcionario
SET id_contrato = 2
WHERE id_contrato = 3;


INSERT INTO contrato_funcionario (id_contrato_funcionario, id_contrato, id_funcionario, cargo, salario, data_admissao) VALUES
    (9, 1, 9, 'Instrutor', 5300.00, '2022-07-20'),
    (10, 1, 10, 'Instrutor', 5200.00, '2022-08-10'),
    (11, 1, 11, 'Instrutor', 5100.00, '2022-09-05'),
    (12, 1, 12, 'Instrutor', 5400.00, '2022-10-15'),
    (13, 1, 13, 'Instrutor', 5000.00, '2022-11-20'),
    (14, 1, 14, 'Instrutor', 4800.00, '2022-12-01'),
    (15, 1, 15, 'Instrutor', 4900.00, '2023-01-10');

select * from contrato_funcionario;

-- Inserir alunos com contrato de aluno PSG 
INSERT INTO aluno (id_aluno, nome, cpf, data_nascimento, telefone, genero, email, id_endereco, id_contrato) VALUES
    (1, 'Maria Silva', '12345678901', '2000-01-10', '123456789', 'F', 'maria.silva@example.com', 1, 3),
    (2, 'João Oliveira', '23456789012', '2001-02-15', '234567890', 'M', 'joao.oliveira@example.com', 2, 3),
    (3, 'Ana Santos', '34567890123', '2002-03-20', '345678901', 'F', 'ana.santos@example.com', 3, 3),
    (4, 'Carlos Lima', '45678901234', '2003-04-25', '456789012', 'M', 'carlos.lima@example.com', 4, 3),
    (5, 'Julia Pereira', '56789012345', '2004-05-30', '567890123', 'F', 'julia.pereira@example.com', 5, 3),
    (6, 'Pedro Costa', '67890123456', '2005-06-05', '678901234', 'M', 'pedro.costa@example.com', 6, 3),
    (7, 'Larissa Oliveira', '78901234567', '2006-07-10', '789012345', 'F', 'larissa.oliveira@example.com', 7, 3),
    (8, 'Matheus Souza', '89012345678', '2007-08-15', '890123456', 'M', 'matheus.souza@example.com', 8, 3);
	select * from aluno
-- Inserir alunos com contrato de aluno comercial 
INSERT INTO aluno (id_aluno, nome, cpf, data_nascimento, telefone, genero, email, id_endereco, id_contrato) VALUES
    (9, 'Amanda Silva', '90123456789', '2008-09-20', '901234567', 'F', 'amanda.silva@example.com', 9, 4),
    (10, 'Lucas Oliveira', '01234567890', '2009-10-25', '012345678', 'M', 'lucas.oliveira@example.com', 10, 4),
    (11, 'Mariana Santos', '12345678902', '2010-11-30', '123456789', 'F', 'mariana.santos@example.com', 1, 4),
    (12, 'Gabriel Lima', '23456789013', '2011-12-05', '234567890', 'M', 'gabriel.lima@example.com', 2, 4),
    (13, 'Bianca Pereira', '34567890124', '2012-01-10', '345678901', 'F', 'bianca.pereira@example.com', 3, 4),
    (14, 'Felipe Costa', '45678901235', '2013-02-15', '456789012', 'M', 'felipe.costa@example.com', 4, 4),
    (15, 'Laura Oliveira', '56789012346', '2014-03-20', '567890123', 'F', 'laura.oliveira@example.com', 5, 4),
    (16, 'Rafael Souza', '67890123457', '2015-04-25', '678901234', 'M', 'rafael.souza@example.com', 6, 4);

-- Inserir alunos com contrato de aprendiz 
INSERT INTO aluno (id_aluno, nome, cpf, data_nascimento, telefone, genero, email, id_endereco, id_contrato) VALUES
    (17, 'Isabela Silva', '78901234587', '2016-05-30', '789012345', 'F', 'isabela.silva@example.com', 7, 5),
    (18, 'Guilherme Oliveira', '89012345688', '2017-06-05', '890123456', 'M', 'guilherme.oliveira@example.com', 8, 5),
    (19, 'Lorena Santos', '90123456589', '2018-07-10', '901234567', 'F', 'lorena.santos@example.com', 9, 5),
    (20, 'Thiago Lima', '01234567800', '2019-08-15', '012345678', 'M', 'thiago.lima@example.com', 10, 5);
	select * from aluno


INSERT INTO professor (id_professor, nome, especializaçao, id_funcionario, id_instituicao) VALUES 
    (1, 'João Silva', 'Desenvolvimento Web', 101, 201),
    (2, 'Maria Santos', 'Marketing Digital', 102, 201),
    (3, 'Carlos Oliveira', 'Design Gráfico', 103, 201),
    (4, 'Ana Souza', 'Programação Python', 104, 201),
    (5, 'Fernanda Lima', 'Gestão de Projetos', 105, 201),
    (6, 'Rafaela Costa', 'Administração de Empresas', 106, 201),
    (7, 'Pedro Almeida', 'Fotografia', 107, 201),
    (8, 'Mariana Ferreira', 'Marketing de Conteúdo', 108, 201),
    (9, 'Lucas Santos', 'Análise de Dados', 109, 201),
    (10, 'Camila Oliveira', 'Recursos Humanos', 110, 201),
    (11, 'Marcos Silva', 'Desenvolvimento Mobile', 111, 201),
    (12, 'Amanda Pereira', 'Design de Interiores', 112, 201),
    (13, 'Rodrigo Nunes', 'Gestão Financeira', 113, 201),
    (14, 'Laura Costa', 'Redes Sociais', 114, 201),
    (15, 'Daniel Oliveira', 'Engenharia de Software', 115, 201);

