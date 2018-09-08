

CREATE TABLE Empresas (
	nome varchar(80),
	capital_social int(12),
	morada_sede varchar(80),
	contato_ECOFCUL int(8),
	contatos_públicos int(8),
	tipo varchar(10),
	PRIMARY KEY (nome)
	);
	
CREATE TABLE interessada_em (
	nome varchar(30),
	PRIMARY KEY(nome),
	FOREIGN KEY(nome) REFERENCES Empresas(nome)
	);
	
	
CREATE TABLE  Empresas_distribuidoras (
	nome varchar(30),
	PRIMARY KEY(nome),
	FOREIGN KEY(nome) REFERENCES Empresas(nome) ON DELETE CASCADE
	);


CREATE TABLE Empresas_produtoras (
	nome varchar(30),
	PRIMARY KEY(nome),
	FOREIGN KEY(nome) REFERENCES Empresas(nome) ON DELETE CASCADE
	);
	
CREATE TABLE competem (
	nome varchar(30),
	competição smallint,
	PRIMARY KEY(nome),
	FOREIGN KEY(nome) REFERENCES Empresas(nome)
	);

CREATE TABLE distribuem (
	nome varchar(30),
	designação_genérica varchar(80),
	PRIMARY KEY(nome,designação_genérica ),
	FOREIGN KEY(nome) REFERENCES Empresas_distribuidoras(nome),
	FOREIGN KEY(designação_genérica) REFERENCES Produtos(designação_genérica)
	);

CREATE TABLE produzem (
	nome varchar(30),
	designação_genérica varchar(80),
	PRIMARY KEY(nome,designação_genérica ),
	FOREIGN KEY(nome) REFERENCES Empresas_produtoras(nome),
	FOREIGN KEY(designação_genérica) REFERENCES Produtos(designação_genérica)
	);


CREATE TABLE são_constituídos_por (
	designação_genérica varchar(80),
	nome varchar(80),
	PRIMARY KEY(nome, designação_genérica),
	FOREIGN KEY(designação_genérica) REFERENCES Produtos(designação_genérica),
	FOREIGN KEY(nome) REFERENCES Elementos(nome)
	);
    
CREATE TABLE Elementos (
	nome varchar(30),
	id int(5) NOT NULL,
	riscos_de_saúde int(1),
	pegada_ecológica int(1),
	defesa_de_direitos_humanos int(1),
	PRIMARY KEY(id),
    FOREIGN KEY(nome) REFERENCES Produtos(nome)
	);
	
CREATE TABLE Especialistas (
	id_nacional int(10) not null,
	email varchar(30),
	nome_completo varchar(35) not null,
	morada varchar (50),
	telefone int(9),
	senha_acesso varchar(18),
	nacionalidade varchar(15) default 'portuguesa',
	PRIMARY KEY(id_nacional)
	);

CREATE TABLE regista_dados_sobre (
	id_nacional int(10) not null,
	designação_genérica varchar(80),
    nome varchar(30),
	PRIMARY KEY(id_nacional, designação_genérica),
    foreign key(nome) references Produtos,
	FOREIGN KEY(id_nacional) REFERENCES Especialistas(id_nacional),
	FOREIGN KEY(designação_genérica) REFERENCES Produtos(designação_genérica)
	);
	
CREATE TABLE regista_dados_sobre (
	id_nacional int(10) not null,
	nome varchar(30),
	PRIMARY KEY(id_nacional, nome),
	FOREIGN KEY(id_nacional) REFERENCES Especialistas(id_nacional),
	FOREIGN KEY(nome) REFERENCES Empresas(nome)
	);
	
CREATE TABLE tipo_de_envolvimento (
	id_nacional int(10) not null,
	nome varchar(30),
	envolvimento smallint,
	PRIMARY KEY(id_nacional,nome),
	FOREIGN KEY(id_nacional) REFERENCES Especialistas(id_nacional),
	FOREIGN KEY(nome) REFERENCES Empresas(nome)
	);

CREATE TABLE Consumidores (
	email varchar(30),
	password varchar(18),
	PRIMARY KEY(email)
	);

CREATE TABLE consomem (
	email varchar(30),
	designação_genérica varchar(80),
	PRIMARY KEY (email, designação_genérica),
	FOREIGN KEY(email) REFERENCES Consumidores(email),
	FOREIGN KEY(designação_genérica) REFERENCES Produtos(designação_genérica)
	);

CREATE TABLE preenchem (
	email varchar(30),
	data varchar(15),
	PRIMARY KEY(email, data),
	FOREIGN KEY(email) REFERENCES Consumidores(email),
	FOREIGN KEY(data) REFERENCES Registo(data)
	);
	
CREATE TABLE Registo (
	data varchar(15),
	produto_consumido varchar(25)
	);

CREATE TABLE possuem_agregado_familiar (
	data_de_nascimento char(10) not null,
	sexo char(1),
	email varchar(35),
	PRIMARY KEY(data_de_nascimento,email),
	FOREIGN KEY(email) REFERENCES Consumidores(email) ON DELETE CASCADE
	);

	
	
INSERT INTO Empresas (nome, capital_social, morada_da_sede, contactos_ecofcul, contactos_publicos,tipo)
	VALUES ('ferrari',100000,'Av. maria de rebelo 97', 'maria: 199''sandra:125','andre:128''rui:783')




	
	
