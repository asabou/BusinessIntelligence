use ShowroomCars

if OBJECT_ID('DimDotari') is not null
	drop table DimDotari
go

create table DimDotari(
	DotariID int primary key  ,
	Clima int check(Clima in (1,0)),
	Incalzire_Scaune  int check(Incalzire_Scaune in (0,1)),
	Senzor_Parcare  int check(Senzor_Parcare in (0,1)),
	Cotiera  int check(Cotiera in (0,1)),
	Navigatie  int check(Navigatie in (0,1)),
)
go
select* from DimDotari