/*
Crear una función escalar para la base de datos clínica, 
que calcule el importe total con IVA  de cada una de las 
visitas del paciente código 6.
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
declare @minCod smallint,@maxCod smallint

select @minCod=min(codigo), @maxCod=max(codigo) from pacientes

set @codPac=@minCod

while(@codPac<=@maxCod)
begin
    if(exists(select * from pacientes where codigo=@codPac))
	 begin
		select @nombre=nombre from pacientes where codigo=@codPac
		set @importeTotal=dbo.CalcularImporte(@codPac)
		print 'El paciente '+@nombre+' se ha gastado '+ cast(@importeTotal as varchar)+' euros.' 

	 end
	 set @codPac=@codPac+1
end




