/*
Crear una función escalar para la base de datos clínica, 
que calcule el importe total con IVA  de cada una de las 
visitas del paciente código 30006.
*/
CREATE FUNCTION CalcularImporte 
( @codP smallint) – Lista de parámetros
RETURNS decimal(6,2)
AS
BEGIN
 declare @totacIva decimal(6,2)
 
 select @totacIva=sum(importe)*1.21 
 from visitas where [Codigo Paciente]=@codP
 
RETURN @totacIva
END

/* ************************************************************************ */

declare @codPac smallint, @nombre nvarchar(30)
declare @importeTotal decimal(6,2)

set @codPac=30006

select @nombre=nombre from pacientes
where codigo=@codPac

set @importeTotal=dbo.CalcularImporte(@codPac)

print 'El paciente '+@nombre+' se ha gastado '+ cast(@importeTotal as varchar)+' euros.' 



