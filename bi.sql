--create database proiect
go
use proiect 
go

if OBJECT_ID('Vanzare') is not null
	drop table Vanzare
go
if OBJECT_ID('Stoc') is not null
	drop table Stoc
go
if OBJECT_ID('Autovehicul') is not null
	drop table Autovehicul
go

if OBJECT_ID('Specificatii_Tehnice') is not null
	drop table Specificatii_Tehnice
go
if OBJECT_ID('Dotari') is not null
	drop table Dotari
go
if OBJECT_ID('Model') is not null
	drop table Model
go
if OBJECT_ID('Marca') is not null
	drop table Marca
go
create table Marca(
ID int primary key identity(1,1),
Nume varchar(100) unique,
An_Infiintare date
)
go
create table Model(
ID int primary key identity(1,1),
Nume varchar(100) ,
ID_Marca int  references Marca(ID),
An_Fabricatie date
)
go
create table Dotari(
ID int primary key identity(1,1),
Clima  int check(Clima in (0,1)),
Incalzire_Scaune  int check(Incalzire_Scaune in (0,1)),
Senzor_Parcare  int check(Senzor_Parcare in (0,1)),
Cotiera  int check(Cotiera in (0,1)),
Navigatie  int check(Navigatie in (0,1)),
)
go
create table Specificatii_Tehnice(
ID int primary key identity(1,1),
Capacitate_Motor int,
Cutie_Viteza varchar(100),
Caroserie varchar(100),
Combustibil varchar(100),
Nr_Trepte int,
Putere int
)
go
create table Autovehicul(
ID int primary key identity(1,1),
ID_Specificatii_Tehnice int  references Specificatii_Tehnice(ID),
ID_Dotari int references Dotari(ID),
ID_Model int references Model(ID),
Pret int
)
go
create table Stoc(
ID int primary key identity(1,1),
ID_Autovehicul int references Autovehicul(ID),
Nr_Autovehicule int
)
go
create table Vanzare(
ID int primary key identity(1,1),
ID_Autovehicul int references Autovehicul(ID),
Data_Vanzare date
)
go
create or alter procedure usp_populate_database as
	insert into Marca (nume, an_infiintare) values
		('Audi', convert(date,'1909-07-16',23)),
        ('BMW', convert(date,'1916-07-16',23)),
        ('Mercedes-Benz', convert(date,'1920-07-16',23)),
		 ('Porsche', convert(date,'1931-07-16',23)),
		  ('Tesla', convert(date,'2003-07-16',23))
	
	insert into Model(Nume,ID_Marca,An_Fabricatie) values
	('A5',1,convert(date,'2013-07-16',23)),
	('A5',1,convert(date,'2016-07-16',23)),
	('X5',2,convert(date,'2016-07-16',23)),
	('X6',2,convert(date,'2014-07-16',23)),
	('CLS',3,convert(date,'2018-07-16',23)),
	('S',3,convert(date,'2018-07-16',23)),
	('911',4,convert(date,'2017-07-16',23)),
	('R8',1,convert(date,'2019-07-16',23)),
	('X',1,convert(date,'2019-07-16',23))
	
	insert into Dotari(Clima,Incalzire_Scaune,Senzor_Parcare,Cotiera,Navigatie) values
	(1,1,1,1,1),
	(0,0,0,0,0),
	(1,0,0,1,0),
	(1,0,1,1,1)

	insert into Specificatii_Tehnice(Capacitate_Motor,Cutie_Viteza,Caroserie,Combustibil,Nr_Trepte,Putere) values
	(1995,'Manuala','Break','Diesel',5,175),
	(2000,'Manuala','Break','Benzina',5,131),
	(2500,'Automata','Berlina','Diesel',5,200),
	(2200,'Manuala','Break','Diesel',5,175),
	(3000,'Automata','Break','Electric',5,416)
	
	insert  into Autovehicul(ID_Specificatii_Tehnice,ID_Dotari,ID_Model,Pret) values
	(1,1,1,14000),
	(1,2,1,14500),
	(2,1,2,12000),
	(5,1,9,80000)
	insert into Stoc(ID_Autovehicul,Nr_Autovehicule) values
	(1,100),
	(2,50),
	(3,75),
	(4,5)
	insert into Vanzare(ID_Autovehicul,Data_Vanzare) values
	(1,convert(date,'2020-02-16',23)),
	(4,convert(date,'2020-01-16',23))

go

exec usp_populate_database
go