-- Criando um banco de dados
create database instagram;
-- Usando o banco de dados criado
use instagram;
-- Criando uma tabela no instagram
create table usuario(
	id_usuario nchar (30) primary key,
	foto_usuario varbinary,
	bio_usuario nchar(150)
);

create table conta(
	cpf_usuario char(11) primary key,
	id_usuario nchar (30),
	nome nchar(30),
	data_nascimento date, 
	email_usuario nchar(30),
	data_criacao datetime,
	senha_usuario varchar(30),
	foreign key (id_usuario) references usuario (id_usuario)
);

create table perfil_verificado(
	id_perfil_verificado int primary key,
	id_usuario nchar(30),
	status_perfil nchar(150),
	verificado bit,
	foreign key (id_usuario) references usuario(id_usuario)
);
create table conta_coimercial(
	id_conta_comercial int primary key,
	id_usuario nchar(30),
	info_comerciais nchar(150),
	desempenho bigint,
	comercial bit,
	foreign key (id_usuario) references usuario(id_usuario)

);

create table conta_beta(
	id_conta_beta int primary key,
	id_usuario nchar(30),
	status_beta bit,
	foreign key (id_usuario) references usuario(id_usuario)
);

create table curtida(
	id_curtida int primary key,
	data_curtida date,
	id_usuario nchar (30)
	foreign key (id_usuario) references usuario(id_usuario)

);

create table follow(
	id_follow bigint primary key,
	follow bit,
	unfollow bit
);
create table following_follow(
	id_following bigint primary key,
	id_usuario nchar(30),
	follow bit,
	unfollow bit,
	foreign key (id_usuario) references usuario(id_usuario)
);

create table direct_msg(
	id_direct_msg int primary key,
	conteudo nchar(1000),
	data_hora datetime,
	flag_exclusao bit,
	anexo bit,
	status_direct_msg bit
);

create table recebimento_msg_usuario(
	id_recebimento int primary key,
	id_direct_msg int,
	id_usuario nchar(30),
	foreign key (id_usuario) references usuario(id_usuario),
	foreign key (id_direct_msg) references direct_msg(id_direct_msg)	
);

create table story(
	id_story int primary key,
	storys bit,
	interacao bit 
);

create table user_story_association(
	id_user_story_association int primary key,
	id_story int,
	id_usuario nchar(30),
	foreign key (id_story) references story(id_story),
	foreign key (id_usuario) references usuario(id_usuario)
);

create table comentario(
	id_comentario int primary key,
	data_comentario date,
	texto_comentario nchar(2200) 
);

create table interacao_usuario_comentario(
	id_interacao int primary key,
	id_usuario nchar(30),
	id_comentario int,
	foreign key (id_usuario) references usuario(id_usuario),
	foreign key (id_comentario) references comentario(id_comentario)
);

create table localizacao(
	id_localizacao int primary key,
	cidade nchar(30)
);

create table postagem(
	id_postagem int primary key,
	id_localizacao int,
	foto_postagem varbinary,
	legenda nchar(2200),
	data_publi datetime,
	foreign key (id_localizacao) references localizacao(id_localizacao)
);

create table publicacao_usuario_postagem(
	id_publicacao int primary key,
	id_postagem int,
	id_usuario nchar(30),
	foreign key (id_usuario) references usuario(id_usuario),
	foreign key (id_postagem) references postagem(id_postagem)
);

create table comentar_postagem(
	id_comentar int primary key,
	id_postagem int,
	id_comentario int,
	foreign key (id_comentario) references comentario(id_comentario),
	foreign key (id_postagem) references postagem(id_postagem)
);
