--Modelo Relacional


CREATE TABLE Patrocinador(
	cod,
	nome,
	contribuicao
);

CREATE TABLE Edição(
	numero,
	arrecadacao,
	ano,
	n_pessoas
);

CREATE TABLE Equipamento(
	nome,
	tipo
);
CREATE TABLE Midia(
	nome,
	tipo
);

CREATE TABLE Instrumento(
	cod,
	nome_instrumento,
	tipo
);

CREATE TABLE Artista(
	nome,
	nacionalidade);

CREATE TABLE Hotel (
	nome,
	endereço,
	telefone,
	cod_banda (Banda.cod)
);

CREATE TABLE Banda(
	cod,
	nome,
	gênero
);

CREATE TABLE Apresentacao(
	apresentador(Banda.cod),
	cod_palco (Palco.cod),
	data,
	hora_inicio,
	hora_fim);

CREATE TABLE Palco(
	nome_palco,
	cod,
	Responsavel(Funcionario.cpf)
);

CREATE TABLE Patrocina(
	patroc (Patrocinador.cod),
	edicao (edicao.numero)
);

CREATE TABLE Produz (
	midia (Midia.nome),
	tipo(Midia.tipo),
	num_ed(edicao.Numero)
);

CREATE TABLE Realizada_em(
	ed (edicao.num_edicao),
	apresentador(Apresentacao.apresentador), 
	palco (Apresentacao.Cod_palco),
	Data(apresentacao.data),
	inicio(apresentacao.hora_inicio),
	fim(apresentacao.hora_fim)
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