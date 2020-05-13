use ShowroomCars
if OBJECT_ID('DimSpecificatii_Tehnice') is not null
	drop table DimSpecificatii_Tehnice
go

create table DimSpecificatii_Tehnice(
	
	ID int  primary key,
	Capacitate_Motor int,
	Cutie_Viteza varchar(100),
	Caroserie varchar(100),
	Combustibil varchar(100),
	Nr_Trepte int,
	Putere int
)
go