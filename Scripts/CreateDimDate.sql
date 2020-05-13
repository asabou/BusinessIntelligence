use ShowroomCars

if OBJECT_ID('DimData') is not null
	drop table DimData
go

create table DimData(
	DataSK int primary key identity(1,1),
	Data_Vanzare date,
	Zi int,
	Zi_Nume varchar(10),
	Luna int,
	Luna_Nume varchar(15),
	An int,		
)
go