/*Crear una función escalar para la base de datos clínica,
 que calcule el importe total con IVA  de cada una de las visitas del 
 paciente código 30006.
*/
 --IMPRIMIR:El paciente(nombre) se ha gastado un importe total de :
--FUNCION
create function Importe_total_iva 
(@codpaciente int)
RETURNS decimal(6,2)
AS
	begin 
		declare @importetotal decimal(6,2)

		select @importetotal = SUM(importe)*1.21
		from VISITAS
		where CODPACIENTE = @codpaciente
        
		return @importetotal
	end
-- ---------------------------------------------------------------------------
Declare @codpaciente smallint, 
        @nombre nvarchar(30)
        @importeTotal decimal(6,2)

set @codP=30006
set @impTotal=dbo.CalcularImporte(@codP) -- llamada a la función

    select @nombre=nombre from pacientes
    where CODIGO=@codpaciente

print 'El paciente '+@nombre+' se ha gastado '+cast(@impTotal as nvarchar)
