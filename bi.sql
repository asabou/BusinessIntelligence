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
if OBJECT_ID('Keys') is not null
	drop table Keys
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
	Data_Vanzare date,
	Nr_Bucati int
)
go


create or alter procedure usp_get_random_string @length int, @string varchar(100) out as
	declare @alphabet varchar(36) = 'qwertyuiopasdfghjklzxcvbnm1234567890';
	set @string = '';
	declare @i int = 0;
	while @i < @length
	begin
		declare @pos int = floor(rand()*(36-1+1))+1;
		set @string = @string + substring(@alphabet,@pos,1);
		set @i = @i + 1;
	end
go

create or alter procedure usp_get_random_number @mini int, @maxi int, @number int out as 
	set @number = floor(rand()*(@maxi-@mini+1))+@mini;
go

create or alter procedure usp_populate_Marca as
	declare @i int = 0;
	while @i < 10000
		begin
			declare @string varchar(100) = '';
			declare @number int = 0;
			set @string = 'Marca' + convert(varchar(5),@i);
			declare @year int = 0;
			declare @month int = 0;
			declare @day int = 0;
			exec usp_get_random_number 1900, 2020, @number = @number out;
			set @year = @number;
			exec usp_get_random_number 1, 12, @number = @number out;
			set @month = @number;
			exec usp_get_random_number 1,30, @number = @number out;
			set @day = @number;
			declare @data varchar(10) = '';
			set @data=@data+@year+'-'+@month+'-'+@day;
			insert into Marca values (@string, convert(date,@data,23));
			set @i = @i + 1;
		end
go

create or alter procedure usp_populate_Model as
	declare @i int = 0;
	while @i < 10000
		begin
			declare @string varchar(100) = '';
			declare @number int = 0;
			set @string = 'Model'+convert(varchar(5),@i);
			declare @year int = 0;
			declare @month int = 0;
			declare @day int = 0;
			exec usp_get_random_number 1900, 2020, @number = @number out;
			set @year = @number;
			exec usp_get_random_number 1, 12, @number = @number out;
			set @month = @number;
			exec usp_get_random_number 1,30, @number = @number out;
			set @day = @number;
			declare @data varchar(10) = '';
			set @data=@data+@year+'-'+@month+'-'+@day;
			declare @id_marca int = 0;
			declare @len int = 0;
			set @len = (select count(*) from Marca);
			exec usp_get_random_number 1,@len, @number = @number out;
			set @id_marca = @number;
			insert into Model values (@string,@id_marca, convert(date,@data,23));
			set @i = @i + 1;
		end
go

create or alter procedure usp_populate_Dotari as
	declare @i int = 0;
	while @i < 10000 
	begin
		declare @clima int;
		declare @incalzire int;
		declare @senzorparcare int;
		declare @cotiera int;
		declare @navigatie int;
		declare @number int;
		exec usp_get_random_number 0,1,@number = @number out;
		set @clima = @number;
		exec usp_get_random_number 0,1,@number = @number out;
		set @incalzire = @number;
		exec usp_get_random_number 0,1,@number = @number out;
		set @senzorparcare = @number;
		exec usp_get_random_number 0,1,@number = @number out;
		set @cotiera = @number;
		exec usp_get_random_number 0,1,@number = @number out;
		set @navigatie = @number;
		insert into Dotari values (@clima,@incalzire,@senzorparcare,@cotiera,@navigatie);
		set @i = @i + 1
	end
go

create or alter procedure usp_populate_Specificatii_Tehnice as
	declare @i int = 0;
	while @i < 10000 
	begin
		declare @capmotor int = 0;
		declare @number int;	
		declare @cutie_viteza varchar(100);
		declare @caroserie varchar(100);
		declare @combustibil varchar(100);
		declare @nrtrepte int;
		declare @putere int;
		exec usp_get_random_number 1000,5000,@number = @number out;
		set @capmotor = @number;
		exec usp_get_random_number 0,1,@number = @number out;
		if @number = 0 
			set @cutie_viteza = 'Manuala';
		else
			set @cutie_viteza = 'Automata';
		exec usp_get_random_number 0,1,@number = @number out;
		if @number = 0 
			set @caroserie = 'Break';
		else set @caroserie = 'Berlina';
		exec usp_get_random_number 0,1,@number = @number out;
		if @number = 0
			set @combustibil = 'Benzina';
		else set @combustibil = 'Diesel';
		exec usp_get_random_number 3,7,@number = @number out;
		set @nrtrepte = @number;
		exec usp_get_random_number 90,200,@number = @number out;
		set @putere = @number;
		insert into Specificatii_Tehnice values (@capmotor,@cutie_viteza, @caroserie,@combustibil,@nrtrepte,@putere);
		set @i = @i+1;
	end
go

create or alter procedure usp_populate_Autovehicul as
	declare @i int =0;
	declare @specificatii_tehnice int = 0;
	declare @dotari int = 0;
	declare @model int = 0;
	declare @price int = 0;
	declare @number int = 0;
	while @i < 10000 
	begin
		set @specificatii_tehnice = (select count(*) from Specificatii_Tehnice);
		exec usp_get_random_number 1, @specificatii_tehnice, @number = @number out;
		set @specificatii_tehnice = @number;
		set @dotari = (select count(*) from Dotari);
		exec usp_get_random_number 1, @dotari, @number = @number out;
		set @dotari = @number;
		set @model = (select count(*) from Model);
		exec usp_get_random_number 1,@model, @number = @number out;
		set @model = @number;
		exec usp_get_random_number 1000,100000, @number = @number out;
		set @price = @number;
		insert into Autovehicul values (@specificatii_tehnice,@dotari,@model,@price);
		set @i = @i + 1;
	end
go

create or alter procedure usp_populate_Stoc as
	declare @i int = 0;
	declare @auto int =0;
	declare @number int = 0;
	declare @nrauto int = 0;
	while @i < 10000
	begin
		set @auto = (select count(*) from Autovehicul);
		exec usp_get_random_number 1, @auto, @number = @number out;
		set @auto = @number;
		exec usp_get_random_number 1,1000, @number = @number out;
		set @nrauto = @number;
		insert into Stoc values (@auto,@nrauto);
		set @i = @i + 1;
	end
go

create or alter procedure usp_populate_Vanzare as
	declare @i int = 0;
	declare @number int = 0;
	declare @auto int = 0; 
	declare @year int = 0;
	declare @month int = 0;
	declare @day int = 0;
	declare @nrbucati int = 0;
	while @i < 10000 
	begin
		declare @date varchar(100) = '';
		set @auto = (select count(*) from Autovehicul);
		exec usp_get_random_number 1,@auto, @number = @number out;
		set @auto = @number;
		exec usp_get_random_number 1900,2020, @number = @number out;
		set @year = @number;
		exec usp_get_random_number 1,12, @number = @number out;
		set @month = @number;
		exec usp_get_random_number 1,30,@number = @number out;
		set @day = @number;
		exec usp_get_random_number 1, 1000, @number = @number out;
		set @nrbucati = @number;
		set @date = @date + @year+'-'+@month+'-'+@day;
		insert into Vanzare values (@auto,convert(date, @date,23),@nrbucati);
		set @i = @i + 1;
	end
go
go
create or alter procedure usp_populate_database as
	exec usp_populate_Marca;
	exec usp_populate_Model;
	exec usp_populate_Dotari;
	exec usp_populate_Specificatii_Tehnice;
	exec usp_populate_Autovehicul;
	exec usp_populate_Stoc;
	exec usp_populate_Vanzare;
go

exec usp_populate_database;
