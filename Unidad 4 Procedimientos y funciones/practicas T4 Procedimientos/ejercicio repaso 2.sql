create function nombrepelicula
(
@codsocio int,
@codstock int
)
returns nvarchar(20)
as
begin
	declare @titulo nvarchar(20)
	
	select @titulo=titulo 
	from peliculas p
	inner join STOCK stk on stk.CODIGO_PELICULA = p.codigo
	inner join alquiler a on a.codigo_stock = stk.CODIGO
	where CODIGO_SOCIO = @codsocio and codigo_stock = @codstock
	return @titulo
end	