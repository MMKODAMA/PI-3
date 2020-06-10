drop database lorentiBD;
create database lorentiBD;
use lorentiBD;

create table cliente(
cli_id integer not null auto_increment,
cli_cpf varchar(11) not null unique,
cli_nome varchar(40) not null,
cli_email varchar(45) not null unique,
cli_sexo char not null,
cli_dataCadastro datetime default current_timestamp,
primary key (cli_id)
);
create table funcionario(
func_id int not null unique auto_increment,
func_nome varchar(40) not null,
func_cpf varchar(11) not null unique,
func_email varchar(45)not null unique,
func_celular varchar (11)not null unique,
func_sexo char not null,
func_filial int ,
func_cargo varchar (40) not null,
func_user varchar (40) not null unique,
func_senha varchar(1000)not null,
primary key (func_id)
);
create table unidade(
unid_id int auto_increment not null unique,
unid_nome varchar(40) not null ,
unid_endereco varchar(50) not null,
unid_estado varchar(2) not null,
primary key (unid_id)
);
create table produto(
prod_id integer auto_increment not null unique,
prod_nome varchar(40) not null,
prod_qtd integer not null,
prod_preco decimal(10,2) not null,
prod_descr varchar(60) ,
prod_filial int,
primary key (prod_id),
foreign key (prod_filial) references unidade(unid_id)
);
create table venda(
venda_id integer auto_increment not null unique,
venda_data_venda datetime default current_timestamp,
venda_func int not null,
venda_val_total numeric(10,2) not null,
venda_cli_id integer not null,
venda_filial int,
primary key (venda_id),
foreign key (venda_func) references funcionario(func_id),
foreign key (venda_cli_id) references cliente(cli_id),
foreign key (venda_filial) references unidade(unid_id)
);
create table itens (
it_produto integer not null,
it_valor_prod numeric(10,2) not null,
it_qtd smallint not null,
it_venda integer not null,
foreign key (it_produto) references produto(prod_id),
foreign key (it_venda) references venda(venda_id)
);

INSERT INTO cliente(cli_cpf, cli_nome, cli_email, cli_sexo) VALUES
('11111111111', 'Carlos Alberto', 'CarlosAlberto@myEmail.com', 'M'),
('22222222222', 'Maria Joana', 'Maria.J@myEmail.com', 'F'),
('33333333333', 'Ana Maria', 'Aninha@myEmail.com', 'F'),
('44444444444', 'Maria Eduarda', 'Maria_2000@myEmail.com', 'X'),
('55555555555', 'Carlos Eduardo', 'Cadu_Silva@myEmail.com', 'M'),
('66666666666', 'Joao Roberto', 'JoaoGordo@myEmail.com', 'M');

INSERT INTO unidade(unid_nome, unid_endereco, unid_estado) VALUES
('Matriz', 'Rua 23 de maio, numero 157','SP'),
('Filial Brasilia', 'Rua Marechal, numero 12','DF'),
('Filial Campo Grande', 'Rua das Matrizas, numero 1280','PB'),
('Filial Joinville', 'Rua Djalma Batista, numero 47','SC'),
('Filial Belo Horizonte', 'Rua Bela Menina, numero 3','MG'),
('Filial Recife', 'Rua Joao Simoes de Souza, numero 430','PE');
INSERT INTO produto(prod_nome, prod_qtd, prod_preco, prod_descr, prod_filial) VALUES
('Sapatilha', 50, 30, 'Sapatilha aberta', 1),
('Chinelo', 50, 15, 'Chinelo de alca', 1),
('Chuteira', 50, 100, 'Chuteira Toperson', 1),
('Sapato Masc', 50, 150, 'Sapato Social Marrom', 1),
('Sapatilha', 50, 30, 'Sapatilha aberta', 2),
('Chinelo', 50, 15, 'Chinelo de alca', 2),
('Chuteira', 50, 100, 'Chuteira Toperson', 2),
('Sapato Masc', 50, 150, 'Sapato Social Marrom', 2),
('Sapatilha', 50, 30, 'Sapatilha aberta', 2),
('Chinelo', 50, 15, 'Chinelo de alca', 3),
('Chuteira', 50, 100, 'Chuteira Toperson', 3),
('Sapato Masc', 50, 150, 'Sapato Social Marrom', 3),
('Sapatilha', 50, 30, 'Sapatilha aberta', 4),
('Chinelo', 50, 15, 'Chinelo de alca', 4),
('Chuteira', 50, 100, 'Chuteira Toperson', 4),
('Sapato Masc', 50, 150, 'Sapato Social Marrom', 5),
('Sapatilha', 50, 30, 'Sapatilha aberta', 5),
('Chinelo', 50, 15, 'Chinelo de alca', 5),
('Chuteira', 50, 100, 'Chuteira Toperson', 6),
('Sapato Masc', 50, 150, 'Sapato Social Marrom', 6);

DELIMITER //
Create Trigger after_vender_item
	after insert on itens for each row
    begin
    update produto set prod_qtd = prod_qtd - new.it_qtd where prod_id = New.it_produto;
    end//
    
DELIMITER ;
insert into funcionario(func_nome,func_cpf,func_email,func_celular,func_sexo,func_filial,func_cargo,func_user,func_senha) values ('fulano','12345678910','email@email.com','123412345','M',2,'DEV','fulanouser','123'),
	('fulana','12345678911','email1@email.com','123412346','F',1,'DEV','fulanauser','123');
    select func_user from funcionario where func_user ='fulanauser';
    select func_senha from funcionario where func_user ='fulanauser';
    select func_user , func_senha from funcionario where func_user = 'fulanouser';
    select * from funcionario;
    Select * from Funcionario where func_user = "testeCript";
    insert into funcionario(func_nome,func_cpf,func_email,func_celular,func_sexo,func_filial,func_cargo,func_user,func_senha) value ('teste','66666666666','email4@email.com','123232345','M',1,'DEV','testeuser','123');