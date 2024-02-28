DROP DATABASE IF EXISTS  motion;
CREATE DATABASE IF NOT EXISTS  motion;
use motion;


CREATE TABLE Oficina(
idOficina INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(255),
cep VARCHAR(20),
numEndereco VARCHAR(10)
);


CREATE TABLE Pitstop_Cliente (
    idCliente INT NOT NULL AUTO_INCREMENT,
    fkOficina INT NOT NULL,
    nome VARCHAR(255) NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(255),
    endereco VARCHAR(255),
    PRIMARY KEY (idCliente)

);

CREATE TABLE Pitstop_Mecanico(
	idMecanico INT PRIMARY KEY AUTO_INCREMENT,
    fkOficina INT NOT NULL,
    nome VARCHAR(255) NOT NULL,
    telefone VARCHAR(50),
    FOREIGN KEY (fkOficina) REFERENCES Oficina(idOficina)
);

CREATE TABLE Pitstop_Veiculo (
    idVeiculo INT NOT NULL AUTO_INCREMENT,
    placa VARCHAR(20) NOT NULL,
    fkCliente INT NOT NULL,
    marca VARCHAR (255),
    modelo VARCHAR(255),
    anoFabricacao YEAR,
    cor VARCHAR(50),
    PRIMARY KEY (idVeiculo, placa),
    FOREIGN KEY (fkCliente) REFERENCES Pitstop_Cliente(idCliente)
);

CREATE TABLE Pitstop_OrdemDeServico (
    idOrdem INT NOT NULL AUTO_INCREMENT,
    fkOficina INT NOT NULL,
    fkVeiculo INT NOT NULL,
    fkMecanico INT,
    dataInicio DATE,
    dataFim DATE,
    descricaoProblema TEXT,
    status VARCHAR(255),
    valorTotal DECIMAL(10, 2),
    PRIMARY KEY (idOrdem),
    FOREIGN KEY (fkOficina) REFERENCES Oficina(idOficina),
    FOREIGN KEY (fkVeiculo) REFERENCES Pitstop_Veiculo(idVeiculo),
    FOREIGN KEY (fkMecanico) REFERENCES Pitstop_Mecanico(idMecanico)
);



CREATE TABLE Pitstop_ProdutoEstoque (
    idProduto INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    fkOficina INT,
    nome VARCHAR(255) NOT NULL,
    descricao TEXT,
    quantidade INT,
    `local` VARCHAR(255),
    precoCompra DECIMAL(10, 2),
    precoVenda DECIMAL(10, 2),
    FOREIGN KEY (fkOficina) REFERENCES Oficina(idOficina)
);

CREATE TABLE Pitstop_Tarefa (
    idTarefa INT PRIMARY KEY AUTO_INCREMENT,
    fkOficina int not null,
    descricao TEXT,
    dataCriacao DATE,
    dataConclusao DATE,
    prioridade VARCHAR(255),
    `status` VARCHAR(255),
    FOREIGN KEY (fkOficina) REFERENCES Oficina(idOficina)
);

CREATE TABLE Pitstop_Financeiro (
    idMovimento INT AUTO_INCREMENT  PRIMARY KEY,
    fkOficina INT,
    tipo VARCHAR(255),
    descricao TEXT,
    `data` DATE,
    valor DECIMAL(10, 2),
    categoria VARCHAR(255),
    formaPagamento VARCHAR(255),
    FOREIGN KEY (fkOficina) REFERENCES Oficina(idOficina)
);