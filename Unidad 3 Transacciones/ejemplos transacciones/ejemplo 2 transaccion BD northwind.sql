/*Ejercicios

Usando la base de datos Northwind*/
use Northwind
go

/*Ejercicio 01: Insertar un registro en la tabla Region usando transacción. (Ver Insertar registros)*/
Begin transaction InsertaRegion
insert into Region ([RegionID], [RegionDescription])
values (30,’Lima’)
if @@ERROR <> 0
Begin
Rollback Transaction InsertaRegion
Print ‘Anulada… no se insertó’
End
Else — No hay error
Begin
Commit Transaction InsertaRegion
Print ‘Se insertó la región’
End
go

--Ejercicio 02: Crear un Store Procedure (Ver procedimientos almacenados) para insertar una región.
Create procedure spRegionInserta
(
@RegionID int,
@RegionDescription nvarchar(50)
)
As
Begin transaction InsertaRegion
insert into Region ([RegionID], [RegionDescription])
values (@RegionID,@RegionDescription)
if @@ERROR <> 0
Begin
Rollback Transaction InsertaRegion
End
Else — No hay error
Begin
Commit Transaction InsertaRegion
End
go

--Ejercicio 03: Crear un trigger en la tabla Region que no permita insertar un registro con la descripción duplicada.
 (Ver Triggers)
if exists (select * from sys.triggers where name = ‘trRegionNoPermiteDuplicados’)
Begin
Drop trigger trRegionNoPermiteDuplicados
End
go
Create trigger trRegionNoPermiteDuplicados
on Region for Insert, update
As
Begin
if (select count(*) from Region, inserted
where Region.RegionDescription = inserted.RegionDescription)>1
Begin
Rollback Transaction
Print ‘Ya existe una región con el nombre insertado’
End
Else
Begin
Print ‘Se insertó el registro, mensaje desde Trigger’
End
End
go

--Ejercicio 04: Este código muestra transacciones anidadas. Tiene en cuenta el registro de una Factura y el detalle de la misma.
Begin transaction GuardaFactura
…
…
… Instrucciones para guardar la factura
Begin Transaction GuardaDetalleFactura
Declare @vDetalle nchar(1) = ‘S’
…
If @@ERROR = 0 — Error al guardar el detalle
Begin
Commit tran GuardaDetalleFactura
End
Else
Begin
Set @vDetalle = ‘E’
Rollback tran GuardaDetalleFactura
End
— Comprueba error al guardar el detalle
if @vDetalle = ‘E’
Begin
Rollback tran GuardaFactura
End
Else
Begin
Commit tran GuardaFactura
End
go