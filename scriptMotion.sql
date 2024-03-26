DROP DATABASE IF EXISTS  motion;
CREATE DATABASE IF NOT EXISTS  motion;
use motion;

CREATE TABLE Pitstop_Oficina(
    idOficina INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    cnpj VARCHAR(255) NOT NULL,
    cep VARCHAR(20) NOT NULL,
    numero VARCHAR(255),
    complemento VARCHAR(255),
    hasBuscar BOOLEAN
);

CREATE TABLE Pitstop_Gerente(
    idGerente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    sobrenome VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    senha VARCHAR(255),
    `status` VARCHAR(255) NOT NULL,
    fkOficina INT NOT NULL,
    FOREIGN KEY (fkOficina) REFERENCES Pitstop_Oficina(idOficina)
);


CREATE TABLE Pitstop_Cliente (
    idCliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    email VARCHAR(255),
    fkOficina INT NOT NULL,
    FOREIGN KEY (fkOficina) REFERENCES Pitstop_Oficina(idOficina)
);

CREATE TABLE Pitstop_Mecanico(
	idMecanico INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    telefone VARCHAR(50),
    fkOficina INT NOT NULL,
    FOREIGN KEY (fkOficina) REFERENCES Pitstop_Oficina(idOficina)
);

CREATE TABLE Pitstop_Veiculo (
    idVeiculo INT PRIMARY KEY AUTO_INCREMENT,
    placa VARCHAR(20) NOT NULL,
    marca VARCHAR (255) NOT NULL,
    modelo VARCHAR(255) NOT NULL,
    anoFabricacao INT NOT NULL,
    cor VARCHAR(50) NOT NULL
);

CREATE TABLE Pitstop_ClienteVeiculo (
	fkCliente INT,
    fkVeiculo INT,
    PRIMARY KEY (fkCliente, fkVeiculo),
    FOREIGN KEY (fkCliente) REFERENCES Pitstop_Cliente(idCliente),
    FOREIGN KEY (fkVeiculo) REFERENCES Pitstop_Veiculo(idVeiculo)
);

CREATE TABLE Pitstop_OrdemDeServico (
    idOrdem INT PRIMARY KEY AUTO_INCREMENT,
    dataInicio DATE NOT NULL,
    dataFim DATE,
    `status` VARCHAR(255) NOT NULL,
    descontos DECIMAL(10, 2),
    valorTotal DECIMAL(10, 2) NOT NULL,
    token VARCHAR(255) NOT NULL,
    garantia VARCHAR(255),
    observacoes VARCHAR(255),
    fkOficina INT NOT NULL,
    fkVeiculo INT NOT NULL,
    fkMecanico INT,
    FOREIGN KEY (fkOficina) REFERENCES Pitstop_Oficina(idOficina),
    FOREIGN KEY (fkVeiculo) REFERENCES Pitstop_Veiculo(idVeiculo),
    FOREIGN KEY (fkMecanico) REFERENCES Pitstop_Mecanico(idMecanico)
);

CREATE TABLE Pitstop_Servico (
    idServico INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    descricao VARCHAR(255) NOT NULL,
    valorServico DECIMAL(10, 2) NOT NULL,
    garantia DECIMAL (10, 2),
    fkOficina INT,
    FOREIGN KEY (fkOficina) REFERENCES Pitstop_Oficina(idOficina)
);

CREATE TABLE Pitstop_ProdutoEstoque (
    idProduto INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    quantidade INT NOT NULL,
    valorMaoDeObra DECIMAL(10, 2) NOT NULL,
    valorCompra DECIMAL(10, 2) NOT NULL,
    valorVenda DECIMAL(10, 2) NOT NULL,
    localizacao VARCHAR(255),
    garantia VARCHAR(10),
    fkOficina INT,
    FOREIGN KEY (fkOficina) REFERENCES Pitstop_Oficina(idOficina)
);

CREATE TABLE Pitstop_Ordem_Produtos_Servicos (
    fkOrdemServico INT NOT NULL,
    fkProduto INT,
    fkServico INT,
    quantidade INT,
    tipo VARCHAR(255),
    subtotal DOUBLE,
    FOREIGN KEY (fkProduto) REFERENCES Pitstop_ProdutoEstoque(idProduto),
    FOREIGN KEY (fkServico) REFERENCES Pitstop_Servico(idServico),
    FOREIGN KEY (fkOrdemServico) REFERENCES Pitstop_OrdemDeServico(idOrdem)
);

CREATE TABLE Pitstop_Tarefa (
    idTarefa INT PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(255) NOT NULL,
    dtDeadLine DATE,
    `status` VARCHAR(255) NOT NULL,
    fkOficina INT NOT NULL,
    FOREIGN KEY (fkOficina) REFERENCES Pitstop_Oficina(idOficina)
);

CREATE TABLE Pitstop_Financeiro (
    idMovimento INT PRIMARY KEY AUTO_INCREMENT,
    transacao VARCHAR(255) NOT NULL,
    categoria VARCHAR(255) NOT NULL,
    `data` DATE NOT NULL,
    valor DECIMAL(10, 2) NOT NULL,
    formaPagamento VARCHAR(255) NOT NULL,
    fkOficina INT NOT NULL,
    FOREIGN KEY (fkOficina) REFERENCES Pitstop_Oficina(idOficina)
);

CREATE TABLE Buscar_Usuario(
    idUsuario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    sobrenome VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    senha VARCHAR(255) NOT NULL
);

CREATE TABLE Buscar_Avaliacao(
    idAvaliacao INT PRIMARY KEY AUTO_INCREMENT,
    nota DECIMAL (5, 2) NOT NULL,
    comentario VARCHAR(255),
    fkOficina INT NOT NULL,
    fkUsuario INT NOT NULL,
    FOREIGN KEY (fkOficina) REFERENCES Pitstop_Oficina(idOficina),
    FOREIGN KEY (fkUsuario) REFERENCES Buscar_Usuario(idUsuario)
);

CREATE TABLE Buscar_Servico(
    idServico INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    descricao VARCHAR(255),
    fkOficina INT NOT NULL,
    FOREIGN KEY (fkOficina) REFERENCES Pitstop_Oficina(idOficina)
);

CREATE TABLE Buscar_Marca(
	idMarca INT PRIMARY KEY AUTO_INCREMENT
);

CREATE TABLE Buscar_MarcaOficina(
	fkMarca INT,
    fkOficina  INT,
    PRIMARY KEY (fkMarca, fkOficina),
    FOREIGN KEY (fkMarca) REFERENCES Buscar_Marca (idMarca),
    FOREIGN KEY (fkOficina) REFERENCES Pitstop_Oficina (idOficina)
);

CREATE TABLE Buscar_Tp_veiculo(
	idTipo INT PRIMARY KEY AUTO_INCREMENT,
    tipoVeiculo VARCHAR(255) NOT NULL
);


CREATE TABLE Buscar_tpVeiculoOficina(
	fkTpVeiculo INT,
    fkOficina  INT,
    PRIMARY KEY (fkTpVeiculo, fkOficina),
    FOREIGN KEY (fkTpVeiculo) REFERENCES Buscar_Tp_Veiculo (idTipo),
    FOREIGN KEY (fkOficina) REFERENCES Pitstop_Oficina (idOficina)
);
