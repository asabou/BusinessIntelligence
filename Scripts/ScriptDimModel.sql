use ShowroomCars;

if OBJECT_ID('DimModel') is not null
	drop table DimModel

go

create table DimModel(

	ModelID int primary key,
	Nume varchar(100) ,
	An_Fabricatie date,
	Nume_Marca varchar(100),
	
)
go


select * from DimModel

alter table DimModel add An_infiintare_marca date

if OBJECT_ID('DimModel') is not null
	drop table DimModel
else
create table DimModel(
	ModelSK int primary key,
	ModelID int ,
	Nume varchar(100) ,
	An_Fabricatie date,
	Nume_Marca varchar(100),
	
)