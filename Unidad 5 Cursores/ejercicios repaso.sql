/*Ejercicio 1. Recorre la tabla de pizzas y para cada una de ella encuentra el ingrediente
más empleado, así como el cliente que más veces la ha comprado. La tabla de pizzas la
tendréis que recorrer mediante un cursor y posteriormente obtener la información
restante mediante procedimientos y/o funciones*/

--FUNCTION calcula ingrediente mas usado y cliente que mas la ha comprado

create function ingrediente (@Npizza varchar(20))
returns varchar(20)
as
begin
	declare @ingrediente varchar(25)
	select top 1 @ingrediente = ingredient 
	from preparation
	where @Npizza = Npizza
	order by quantity desc

return @ingrediente
end


--PRUEBA FUNCIONAMIENTO
declare @test varchar(20)
set @test = dbo.ingrediente('Simple')
print @test
--FUNCION 2 cliente que más veces la ha comprado

--CONSULTA
select top (1) c.nombre, s.clientCod, count(*)as Ncompras 
from sales s
inner join client c on c.clientCod = s.clientCod
where Npizza = @Npizza
group by  c.nombre, s.clientCod
order by Ncompras desc
------------------------------------------
------------------------------------------
CREATE FUNCTION ClientesMasCompras (@Npizza varchar(25))
RETURNS varchar(45)
AS
    BEGIN 
    declare @nombre varchar(45) ,@clientCod int
    select top (1) @nombre= c.nombre, @clientCod = s.clientCod, count(*)as Ncompras 
    from sales s
    inner join client c on c.clientCod = s.clientCod
    where Npizza = @Npizza
    group by  c.nombre, s.clientCod
    order by Ncompras desc
    
    RETURN @nombre
    END


--CURSOR (recorre la tabla pizzas)
declare @Npizza varchar(20),
        @nombre varchar(45), 
        @ingrediente varchar(25)

declare recorrepizzas CURSOR
FOR 
    select p.Npizza, c.nombre, pre.ingredient 
    FROM pizzas p
    INNER JOIN sales s ON s.Npizza = p.Npizza
    INNER JOIN preparation pre ON pre.Npizza = p.Npizza
    INNER JOIN client c ON c.clientCod = s.clientCod
OPEN recorrepizzas
FETCH recorrepizzas INTO  @Npizza, @nombre, @ingrediente
WHILE(@@FETCH_STATUS = 0)
    BEGIN
        set @ingredientemasusado = dbo.ingrediente(@Npizza)
        FETCH recorrepizzas INTO  @Npizza, @nombre, @ingre
        PRINT @nombre+space(10)+@Npizza+space(10)+@ingredientemasusado
     END
 CLOSE recorrepizzas
 DEALLOCATE recorrepizzas    


/*Ejercicio 2. Muestra los pacientes que han asistido al médico al menos alguna vez en el mes
de octubre de 2019. Realiza esto mediante un cursor. Posteriormente, muestra la
enfermedad/enfermedades que ha padecido en esas visitas.*/

--CURSOR PACIENTES
select nombre,codigo from pacientes
--iteracion
--almacenar @nombre, @codigo
-- imprimir @nombre, codigo

		--CURSOR PARA VISITAS
		select enfermedad from visitas where codpaciente =@codigo
		--imprimir enfermedades
        --Cerrar cursor visitas

--cerrar cursor pacientes        

--consulta
select  codigo,nombre
from pacientes
inner join visitas on CODPACIENTE = codigo
where MONTH(fecha)= 10 and year(fecha)=2019
group by codigo,nombre


--CURSOR

DECLARE


DECLARE PacientesMesOctubre CURSOR
FOR
    select  codigo,nombre, enfermedad
    from pacientes
    inner join visitas on CODPACIENTE = codigo
    where MONTH(fecha)= 10 and year(fecha)=2019
    group by codigo,nombre

OPEN  PacientesMesOctubre
FETCH PacientesMesOctubre INTO @codigo, @nombre, @enfermedad