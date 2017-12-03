--Modelo Relacional
DROP SCHEMA Palcos CASCADE;
CREATE SCHEMA Palcos;
SET search_path to Palcos;

CREATE TABLE Patrocinador(
	cod						serial,
	nome					varchar(40),
	contribuicao			money CHECK (contribuicao > 0)
);

CREATE TABLE Edição(
	numero					serial,
	arrecadacao				money,
	ano						numeric(4,0) CHECK (ano > 0),
	n_pessoas				int CHECK (n_pessoas > 0)
);

CREATE TABLE Equipamento(
	nome					varchar(40),
	tipo					varchar(20)--colocar o check dos tipos de equipamentos
);
CREATE TABLE Midia(
	nome					varchar(40),
	tipo					varchar(10) check(tipo = 'DVD' OR tipo = 'CD'/*se tiver mais alguma coisa coloca kk*/)
);

CREATE TABLE Instrumento(
	cod,
	nome_instrumento		varchar(40),
	tipo					--lmitar o dominio com check
);

CREATE TABLE Artista(
	nome					varchar(40),
	nacionalidade			varchar(20)
);

CREATE TABLE Hotel (
	nome					varchar(40),
	endereço				,
	telefone				,
	cod_banda (Banda.cod)	
);

CREATE TABLE Banda(
	cod						,
	nome					varchar(40),
	gênero					--limitar o dominio
);

CREATE TABLE Apresentacao(
	apresentador(Banda.cod)	,
	cod_palco (Palco.cod)	,
	inicio					timestramp,
	fim						timestramp
);

CREATE TABLE Palco(
	nome_palco				varchar(40),
	cod						,
	Responsavel				,
	CONSTRAINT fk_palco FOREIGN KEY responsabel REFERENCES funcionario(cpf)
);

CREATE TABLE Patrocina(
	patroc					,
	edicao					,
	CONSTRAINT fk_patrocinador FOREIGN KEY patroc REFERENCES patrocinador(cod),
	CONSTRAINT fk_edicao FOREIGN KEY edicao REFERENCES edicao(numero)
);

CREATE TABLE Produz (
	midia					,
	tipo					,
	num_ed					,
	CONSTRAINT fk_edicao FOREIGN KEY num_ed REFERENCES edicao(numero),
	CONSTRAINT fk_tmidia FOREIGN KEY tipo REFERENCES midia(tipo),
	CONSTRAINT fk_nmidia FOREIGN KEY midia REFERENCES nidia(nome)
);

CREATE TABLE Realizada_em(
	ed (edicao.num_edicao),
	apresentador(Apresentacao.apresentador), 
	palco (Apresentacao.Cod_palco),
	inicio(apresentacao.hora_inicio),
	fim(apresentacao.hora_fim)
	CONSTRAINT fk_edicao 	FOREIGN KEY ed REFERENCES edicao(numero),
	CONSTRAINT fk_presenter FOREIGN KEY apresentador REFERENCES apresentacao(apresentador),
	CONSTRAINT fk_palco 	FOREIGN KEY palco REFERENCES apresentacao(cod_palco)
	CONSTRAINT fk_edicao 	FOREIGN KEY
	CONSTRAINT fk_edicao 	FOREIGN KEY
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
	cpf,
	nome,
	sexo,
	funcao,
	palco(Palco.cod)
);


CREATE TABLE Trabalha(
	palco(Palco.cod),
	cpf (Funcionario.cpf)
);