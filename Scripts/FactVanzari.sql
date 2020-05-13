use ShowroomCars
go

if OBJECT_ID('FactVanzari') is not null
	drop table FactVanzari
go

create table FactVanzari(
	
	ModelSK int not null references DimModel(ModelID),
	AutovehiculSK int not null references DimAutovehicul(AutovehiculID),
	DotariSK int not null references DimDotari(DotariID),
	Specificatii_TehniceSK int not null references DimSpecificatii_Tehnice(ID),
	DataSK int not null references DimData(DataID),
	Stoc int,
	Nr_Bucati_Vandute int
	Constraint FactVanzariPK Primary key(ModelSK,AutovehiculSK,DotariSK,Specificatii_TehniceSK,DataSK,Stoc,Nr_Bucati_Vandute)
)
go
select * from FactVanzari
select * from DimModel
select * from DimDotari
select * from DimAutovehicul
select * from DimSpecificatii_Tehnice
select * from DimData