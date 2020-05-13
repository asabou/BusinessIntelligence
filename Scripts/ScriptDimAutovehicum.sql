use ShowroomCars

if OBJECT_ID('DimAutovehicul') is not null
	drop table DimAutovehicul
go

create table DimAutovehicul(

	AutovehiculID int primary key ,
	Pret int,
	StartDate date,
	EndDate date
)
go
select * from DimAutovehicul