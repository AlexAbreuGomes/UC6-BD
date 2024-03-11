-- Criando um banco de dados
create database instagram;
-- Usando o banco de dados criado
use instagram;
-- Criando uma tabela no instagram
create table conta(
	cpf_usuario char(11) primary key,
	nome nchar(30),
	data_nascimento date, 
	email_usuario nchar(30),
	data_criacao datetime,
	senha_usuario varchar(30)
);
create table usuario(
	id_usuario nchar (30),
	foto_usuario varbinary,
	bio_usuario nchar(150)
);
create table perfil_verificado(
	id_perfil_verificado int,
	status_perfil nchar(150),
	verificado bit
);
create table conta_coimercial(
	id_conta_comercial int,
	info_comerciais nchar(150),
	desempenho bigint,
	comercial bit
);
create table conta_beta(
	id_conta_beta int,
	status_beta bit
);
create table curtida(
	id_curtida int,
	data_curtida date
);
create table following_follow(
	id_following bigint,
	follow bit,
	unfollow bit
);
create table follow(
	id_follow bigint,
	follow bit,
	unfollow bit
);
create table recebimento_msg_usuario(
	id_recebimento int
	
);
create table direct_msg(
	id_direct_msg int,
	conteudo nchar(1000),
	data_hora datetime,
	flag_exclusao bit,
	anexo bit,
	status_direct_msg bit
);
create table user_story_association(
	id_user_story_association int
);
create table story(
	id_story int,
	storys bit,
	interacao bit 
);
create table interacao_usuario_comentario(
	id_interacao int
);
create table comentario(
	id_comentario int,
	data_comentario date,
	texto_comentario nchar(2200) 
);
create table publicacao_usuario_postagem(
	id_publicacao int
);
create table postagem(
	id_postagem int,
	foto_postagem varbinary,
	legenda nchar(2200),
	data_publi datetime
);
create table localizacao(
	id_localizacao int,
	cidade nchar(30)
);
create table comentar_postagem(
	id_comentar int
);

create table teste(
	id_teste int, 
	teste nchar(11)
);
