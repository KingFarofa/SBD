--Modelo Relacional
DROP SCHEMA Palcos CASCADE;
CREATE SCHEMA Palcos;
SET search_path to Palcos;

CREATE TABLE Patrocinador(
	cod						integer,
	nome					varchar(40),
	contribuicao			money CHECK (contribuicao > 0),
	CONSTRAINT patrocinador_pk PRIMARY KEY (cod)
);

CREATE TABLE Edição(
	numero					serial,
	arrecadacao				money,
	ano						numeric(4,0) CHECK (ano > 0),
	n_pessoas				int CHECK (n_pessoas > 0),
	CONSTRAINT edicao_pk PRIMARY KEY (numero)
);

CREATE TABLE Equipamento(
	nome					varchar(40),
	tipo					varchar(20),--colocar o check dos tipos de equipamentos
	CONSTRAINT equipamento_pk PRIMARY KEY (nome)
);
CREATE TABLE Midia(
	nome					varchar(40),
	tipo					varchar(10) check(tipo = 'DVD' OR tipo = 'CD'/*se tiver mais alguma coisa coloca kk*/),
	CONSTRAINT midia_pk PRIMARY KEY (nome,tipo)
);

CREATE TABLE Instrumento(
	cod						integer,
	nome_instrumento		varchar(40),
	tipo					varchar(20),--colocar o check dos tipos de equipamentos
	CONSTRAINT Instrumento_pk PRIMARY KEY (cod)
);

CREATE TABLE Artista(
	nome					varchar(40),
	nacionalidade			varchar(20),
	CONSTRAINT artista_pk PRIMARY KEY (nome)
);

CREATE TABLE Hotel (
	nome					varchar(40),
	endereço				varchar(120),
	telefone				varchar(15),
	cod_banda 				integer,
	CONSTRAINT hotel_fk FOREIGN KEY (cod_banda) REFERENCES Banda(cod),
	CONSTRAINT hotel_pk1 PRIMARY KEY (cod_banda),
	CONSTRAINT hotel_pk PRIMARY KEY (telefone)
);

CREATE TABLE Banda(
	cod						integer,
	nome					varchar(40),
	gênero					--limitar o dominio com o CHECK,
	CONSTRAINT banda_pk PRIMARY KEY (cod)
);

CREATE TABLE Apresentacao(
	apresentador			integer,
	cod_palco 				integer,
	inicio					timestramp,
	fim						timestramp
	CONSTRAINT apresentacao_fk FOREIGN KEY (apresentador) REFERENCES Banda(cod),
	CONSTRAINT apresentacao_fk1 FOREIGN KEY (cod_palco) REFERENCES Palco(cod),
	CONSTRAINT apresentacao_pk PRIMARY KEY (apresentador),
	CONSTRAINT apresentacao_pk1 PRIMARY KEY (cod_palco),
	CONSTRAINT apresentacao_pk2 PRIMARY KEY (inicio),
	CONSTRAINT apresentacao_pk3 PRIMARY KEY (fim)
);

CREATE TABLE Palco(
	nome_palco				varchar(40),
	cod						integer,
	Responsavel				varchar(11),
	CONSTRAINT fk_palco FOREIGN KEY (responsavel) REFERENCES funcionario(cpf),
	CONSTRAINT pk_palco PRIMARY KEY (cod),
	CONSTRAINT pk_palco1 PRIMARY KEY (responsabvel)
);

CREATE TABLE Patrocina(
	patroc					integer,
	edicao					integer,
	CONSTRAINT fk_patrocinador FOREIGN KEY patroc REFERENCES patrocinador(cod),
	CONSTRAINT fk_edicao FOREIGN KEY edicao REFERENCES edicao(numero),
	CONSTRAINT pk_patrocina PRIMARY KEY (patroc),
	CONSTRAINT pk_patrocina1 PRIMARY KEY (edicao)
	
);

CREATE TABLE Produz (
	midia					varchar(40),
	tipo					varchar(10),
	num_ed					integer,
	CONSTRAINT fk_edicao FOREIGN KEY num_ed REFERENCES edicao(numero),
	CONSTRAINT fk_tmidia FOREIGN KEY tipo REFERENCES midia(tipo),
	CONSTRAINT fk_nmidia FOREIGN KEY midia REFERENCES nidia(nome),
	CONSTRAINT pk_produz PRIMARY KEY (midia,tipo),
	CONSTRAINT pk_produz PRIMARY KEY (num_ed)
);

CREATE TABLE Realizada_em(
	ed 						integer,
	apresentador			integer, 
	palco 					integer,
	inicio					timestramp,
	fim						timestramp,
	CONSTRAINT fk_realiza 	FOREIGN KEY ed 				REFERENCES edicao(numero),
	CONSTRAINT fk_realiza1 	FOREIGN KEY apresentador 	REFERENCES apresentacao(apresentador),
	CONSTRAINT fk_realiza2 	FOREIGN KEY palco 			REFERENCES apresentacao(cod_palco),
	CONSTRAINT fk_realiza3 	FOREIGN KEY inicio 			REFERENCES apresentacao(inicio),
	CONSTRAINT fk_realiza4 	FOREIGN KEY fim 			REFERENCES apresentacao(fim),
	CONSTRAINT pk_realiza  (banda),
	CONSTRAINT pk_realiza1 (apresentador),
	CONSTRAINT pk_realiza2 (palco),
	CONSTRAINT pk_realiza3 (inicio),
	CONSTRAINT pk_realiza4 (fim)
);

CREATE TABLE Utiliza(
	data_ap (apresentacao.data),
	equipamento (equipamento.nome)
);

CREATE TABLE Toca_em(
	artista (artista.nome),
	banda(banda.cod)
);

CREATE TABLE Toca (
	artista(artista.nome),
	insts (instrumento.cod)
);

CREATE TABLE Apresenta (
	banda (Banda.cod),
	palco (Palco.cod),
	apresentador(Apresentacao.apresentador), 
	palco (Apresentacao.Cod_palco),
	Data(apresentacao.data),
	inicio(apresentacao.hora_inicio),
	fim(apresentacao.hora_fim)
);

CREATE TABLE Funcionario(
	cpf						varchar(11),
	nome					varchar(40),
	sexo					char,
	funcao					varchar(120),
	palco(Palco.cod)		integer,
);


CREATE TABLE Trabalha(
	palco(Palco.cod),
	cpf (Funcionario.cpf)
);