-- Criando um banco de dados
create database instagram;
-- Usando o banco de dados criado
use instagram;
-- Criando uma tabela no instagram


create table usuario(
	id_usuario nvarchar (30) primary key,
	--foto_usuario varbinary,
	bio_usuario nchar(150)
);

create table conta(
	cpf_usuario char(11) primary key,
	id_usuario nvarchar (30),
	nome nchar(30),
	data_nascimento date, 
	email_usuario nchar(30),
	data_criacao datetime,
	senha_usuario varchar(30),
	foreign key (id_usuario) references usuario (id_usuario)
);

create table perfil_verificado(
	id_perfil_verificado int primary key,
	id_usuario nvarchar(30),
	status_perfil nchar(150),
	verificado bit,
	foreign key (id_usuario) references usuario(id_usuario)
);
create table conta_comercial(
	id_conta_comercial int primary key,
	id_usuario nvarchar(30),
	info_comerciais nvarchar(150),
	desempenho bigint,
	comercial bit,
	foreign key (id_usuario) references usuario(id_usuario)

);

create table conta_beta(
	id_conta_beta int primary key,
	id_usuario nvarchar(30),
	status_beta bit,
	foreign key (id_usuario) references usuario(id_usuario)
);

create table curtida(
	id_curtida bigint primary key,
	data_curtida date,
	id_usuario nvarchar (30),
	foreign key (id_usuario) references usuario(id_usuario)

);

create table follow(
	id_follow bigint primary key,
	id_usuario nvarchar (30),
	follow bit,
	unfollow bit,
	foreign key (id_usuario) references usuario(id_usuario)
);
create table following_follow(
	id_following bigint primary key,
	id_usuario nvarchar(30),
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
	id_usuario nvarchar(30),
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
	id_usuario nvarchar(30),
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
	--foto_postagem varbinary,
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

insert into usuario(
	id_usuario,      --nvarchar (30) primary key,
	bio_usuario      --nchar(150)
)
values
	('@alex', 'ola'),
	('@daniel','tchau');

insert into direct_msg(
	id_direct_msg,     --int primary key,
	conteudo,          --nchar(1000),
	data_hora,         --datetime,
	flag_exclusao,     --bit,
	anexo,             --bit,
	status_direct_msg  --bit
)
values 
	(1,N'ola','2024-05-05 01:05:00',1,1,0),
	(2,N'tchau','2024-05-06 12:02:00',0,1,1);

 insert into story(
	id_story,   --int primary key,
	storys,     --bit,
	interacao  --bit 
 )
 values 
	 (1,0,1),
	 (2,1,1);
insert into comentario(
	id_comentario, --int primary key,
	data_comentario, --date,
	texto_comentario --nchar(2200) 
	
)
values
	(123,'2024-03-12',N'lindo'),
	(423,'2024-03-11',N'show');

insert into localizacao(
	id_localizacao, --int primary key,
	cidade --nchar(30)
)
values
	(567,N'natal'),
	(148,N'macaiba');

select * from direct_msg;
select * from usuario;
select * from story;
select * from comentario;
select * from localizacao;

insert into conta(
	cpf_usuario,       --char(11) primary key,
	id_usuario,        --nvarchar (30),
	nome,              --nchar(30),
	data_nascimento,   --date, 
	email_usuario,     --nchar(30),
	data_criacao,      --datetime,
	senha_usuario      --varchar(30),
)
values 
('12312312310', '@alex', 'alex', '1995-08-11', 'alex@gnail.con','2013-10-25T20:05:00', '12312320'),
('12312312320', '@daniel', 'daniel', '2000-08-11', 'daniel@gnail.con','2019-10-25T21:05:00', '1231244');

select * from conta;