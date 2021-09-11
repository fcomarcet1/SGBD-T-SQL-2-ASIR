/*
Ejercicio 1
Para la BD clínica, crear un script con un procedimiento almacenado que para cada paciente, 
muestre el número de visitas que ha realizado. Para ello recorreremos 
la tabla pacientes y llamaremos al procedimiento que nos devolverá el número de visitas que
ha realizado el paciente. El script principal primero mostrará el valor de la
variable visitas antes del paso al procedimiento y después mostrará el nombre 
del paciente y el número de visitas realizadas.*/

--PROCEDIMIENTO
--Dado un codigopaciente(P_in) obtenemos el nº visitas Nvisitas(P_out)
GO

IF OBJECT_ID ('dbo.visitaspaciente') IS NOT NULL  
    DROP PROCEDURE dbo.visitaspaciente;  

GO

CREATE PROCEDURE visitaspaciente

    @codigopaciente INT,
    @Numvisitas INT OUTPUT
AS
    SET NOCOUNT ON;
    SELECT @Numvisitas = COUNT(*)  
    FROM visitas 
    WHERE codpaciente = @codigopaciente
RETURN
GO    

/*
EXECUTE visitaspaciente (30004,@Numvisitas OUTPUT)
PRINT CAST(@Numvisitas as NVARCHAR(4))
*/

---------------------------------------------------------
--SCRIPT

DECLARE @contador INT,
        @nombre NVARCHAR(30),
        @codigopaciente INT, 
        @Numvisitas INT,
        @max int


set @contador = (SELECT min(CODIGO) from pacientes)
set @max = (SELECT max(CODIGO) from pacientes)


WHILE (@contador <= @max)
	BEGIN
		IF(EXISTS (SELECT * FROM PACIENTES WHERE CODIGO = @contador))
			BEGIN
				Print cast(@Numvisitas as nevarchar(5))
				SELECT @nombre=NOMBRE FROM PACIENTES WHERE CODIGO = @contador
				SET @codigopaciente =(SELECT top(1) codpaciente
                                        FROM visitas 
                                        WHERE codpaciente = @contador)
				EXECUTE visitaspaciente @codigopaciente, @Numvisitas OUTPUT
				PRINT cast(@codigopaciente as nvarchar(6)) + '  ' +cast(@Numvisitas as nvarchar(2))+ '  '  + @nombre
				  
			END
		SET @contador += 1
	END


/*Ejercicio 2 sencillo
Crear un script que utilice procedimientos almacenados y la Base de Datos CLÍNICA.
El programa debe consta de dos partes (script principal y procedimiento almacenado).
Debe recorrer todos los registros de la tabla PACIENTES, y para cada paciente, 
ejecutar el siguiente procedimiento almacenado que debe recibir como 
parámetro el CODIGO del paciente, e imprimir el gasto total de cada paciente 
y el NUMERO DE VISITAS que ha realizado cada paciente.
Después recorrer todos los registros de pacientes y de ejecutar el procedimiento almacenado, 
debe mostrar en la pantalla el CODIGO, NOMBRE y SUMA_IMPORTE de los todos los pacientes.*/

--PROCEDIMEINTO


IF OBJECT_ID ( 'dbo.PacientesGasto') IS NOT NULL  
    DROP PROCEDURE dbo.PacientesGasto;  

GO
CREATE PROCEDURE PacientesGasto  @codpaciente int, @Numvisitas int OUTPUT, @GastoTotal money OUTPUT

AS
    SET NOCOUNT ON
    SELECT @Numvisitas = COUNT(*), @GastoTotal = SUM(importe) 
    FROM visitas
    WHERE codpaciente = @codpaciente

GO

--SCRIPT

DECLARE @contador INT,
        @nombre NVARCHAR(30),
        @codigopaciente INT, 
        @Numvisitas INT,
		@GastoTotal int,
        @max int


set @contador = (SELECT min(CODIGO) from pacientes)
set @max = (SELECT max(CODIGO) from pacientes)

PRINT' CODIGO-------- NOMBRE ------- SUMA_IMPORTE'

WHILE (@contador <= @max)
	BEGIN
		IF(EXISTS (SELECT * FROM PACIENTES WHERE CODIGO = @contador))
			BEGIN
				
				SELECT @nombre=NOMBRE FROM PACIENTES WHERE CODIGO = @contador
				SET @codigopaciente =(SELECT top(1) codpaciente
                                        FROM visitas 
                                        WHERE codpaciente = @contador)

				EXECUTE PacientesGasto @codigopaciente, @Numvisitas  OUTPUT, @GastoTotal  OUTPUT
				PRINT cast(@contador as nvarchar(6)) + '  ' +cast(@Numvisitas as nvarchar(2)
				)+ '  '  + @nombre+ '       '  + cast(@Gastototal as nvarchar(5))
				  
			END
		SET @contador += 1


 /*Ejercicio 3
Crear un script que utilice procedimientos almacenados y la Base de Datos CLÍNICA. El programa debe
consta de dos partes (script principal y procedimiento almacenado). Debe recorrer todos los registros de
la tabla PACIENTES, y para cada paciente, ejecutar el siguiente procedimiento almacenado que debe
recibir como parámetro el CODIGO del paciente, e imprimir el gasto total de cada paciente y el NUMERO
DE VISITAS que ha realizado cada paciente.
Después recorrer todos los registros de pacientes y de ejecutar el procedimiento almacenado, debe
mostrar en la pantalla el CODIGO, NOMBRE y SUMA_IMPORTE de los todos los pacientes que han gastado
más de la media.
*/ 
--PROCEDIMIENTO
IF OBJECT_ID ( 'dbo.PacientesGasto') IS NOT NULL  
    DROP PROCEDURE dbo.PacientesGasto;  

GO
CREATE PROCEDURE PacientesGasto  @codpaciente int, @Numvisitas int OUTPUT, @GastoTotal money OUTPUT

AS
    SET NOCOUNT ON
    SELECT @Numvisitas = COUNT(*), @GastoTotal = SUM(importe) 
    FROM visitas
    WHERE codpaciente = @codpaciente

GO


--SCRIPT
USE CLINICA
GO
IF OBJECT_ID ( 'dbo.#tmptable') IS NOT NULL  
    DROP table dbo.#tmptable;  

GO
CREATE table #tmptable 
    (
        codigo int,
        nombre nvarchar(20),
        sumaimporte int,
        media int,
        numvisitas int
    )
INSERT INTO #tmptable (codigo, nombre, sumaimporte, media, Numvisitas)

    select codpaciente, nombre ,sum(importe),(select avg(importe) from visitas) as media ,count(*) AS nvisitas 
    FROM visitas
	inner join pacientes on codpaciente = codigo
    group by codpaciente, nombre
    having sum(importe)>avg(importe)

 declare @contador INT,
         @codpaciente int,
         @nombre NVARCHAR(20),
         @GastoTotal int,
		 @Numvisitas int

SELECT @contador = COUNT(*) from #tmptable 

PRINT 'CODIGO - NOMBRE - GASTO TOTAL - NUMERO VISITAS'

WHILE(@contador > 0)
    BEGIN 
		set nocount on
		set @codpaciente = (select top(1) codigo from #tmptable)

		EXECUTE PacientesGastomedia 
            @codpaciente,@GastoTotal OUTPUT,@Numvisitas OUTPUT
        set @nombre = (select top(1) nombre from #tmptable) 
       
        PRINT cast(@codpaciente as nvarchar(6))+'        '+ @nombre
		+'       '+cast(@GastoTotal as nvarchar(6))
        +'       '+cast(@Numvisitas as nvarchar(10))
        
        DELETE top(1) FROM #tmptable
        SELECT @contador = COUNT(*) from #tmptable
    END
GO
DROP TABLE #tmptable        
END
 -----------------------------------------------------------------------------   

/*Ejercicio 3
Crear un script que utilice procedimientos almacenados y la Base de Datos VIDEO CLUB
Para cada uno de los clientes del VideoClub con número de cliente par debe ejecutar 
el procedimiento almacenado siguiente:

El procedimiento recibirá como parámetro el código del cliente
MOSTRARA por pantalla nombre del cliente, código,
total de películas alquiladas y la media de películas que ha alquilado cada socio cada mes*/

--consultas
-----------------------------------------------------------------------
select  so.nombre,so.codigo, count(*) as totalpeliculas ,MONTH(a.FECHA_SALIDA) as mes
from alquiler a
inner join socios so on so.codigo = a.CODIGO_SOCIO
inner join stock stk on stk.codigo = a.CODIGO_STOCK
group by so.nombre, so.codigo,MONTH(a.FECHA_SALIDA)
order by  MONTH(a.FECHA_SALIDA) asc 

-----
select a.codigo_socio,s.nombre, month(a.fecha_salida) as mes,avg(a.codigo_socio) as media, count(*) as nalquiler
from socios  s
inner join alquiler  a on s.codigo=a.codigo_socio
group by a.codigo_socio,s.nombre, month(a.fecha_salida)
order by a.codigo_socio,month(a.fecha_salida)
-----------------------------------------------------------------------------

--PROCEDIMEINTO
GO
 IF OBJECT_ID ('dbo.clientesvideoclub') IS NOT NULL
    DROP PROCEDURE dbo.clientesvideoclub
GO

CREATE PROCEDURE clientesvideoclub 
    @codsocio int,
    @nombre nvarchar(20) OUTPUT,
    @codigo int OUTPUT,
    @totalpeliculas int OUTPUT,
    @media int OUTPUT

    AS

    declare @nombre nvarchar(20),
            @codigo int,
            @totalpeliculas int

    set  @totalpeliculas = (select  count(*) , MONTH(FECHA_SALIDA) 
                            from alquiler
                            WHERE codigo_socio = @codsocio
                            group by MONTH(a.FECHA_SALIDA)
                            order by  MONTH(a.FECHA_SALIDA) asc)

    select @nombre = nombre from socios WHERE codigo = @codsocio
    select @codigo = codigo from socios WHERE codigo = @codsocio
    set @codsocio = @codigo


--EXECUTE clientesvideoclub @codsocio, @nombre OUTPUT, @codigo OUTPUT, @totalpeliculas OUTPUT


--sCRIPT

DECLARE @contador INT,
        @max int,
        @codsocio int, 
        @nombre nvarchar(20), 
        @codigo int , 
        @totalpeliculas int


SELECT @contador=min(codigo) from socios
SELECT @max = max(codigo)from socios

GO
WHILE(@contador <= @max )

    BEGIN 
        IF(EXISTS (SELECT * FROM SOCIOS WHERE CODIGO % 2 = 0 AND codigo = @contador))
            BEGIN 
               
               EXECUTE clientesvideoclub 
                        @codsocio, 
                        @nombre OUTPUT, 
                        @codigo OUTPUT, 
                        @totalpeliculas OUTPUT
                PRINT @nombre +'space(10)'+cast(@codigo as nvarchar(5))+'space(10)'+
                cast(@totalpeliculas as nvarchar(5))
            END

     set @contador = @contador +1
    END


----------------------------------------------------------------------
----------------------------------------------------------------------
/*
Ejercicio 4
Crear un script que utilice procedimientos almacenados y la Base de Datos Video Club.
Primero averiguar la fecha más antigua y la más reciente de la tabla alquiler.
Una vez calculada las fechas, para cada mes de cada año deberá averiguar 
el socio que más películas ha alquilado en ese mes y en ese caso almacenarlo
en una tabla llamada MEJORES SOCIOS, que tiene la siguiente estructura (Mes, Año, NombreSocio, Nº peliculasAlquiladas).
Tendremos un procedimiento almacenado llamado Ctd_PeliculasSocio.
El procedimiento almacenado se ejecutará para cada socio, año y mes que se le pasa como parámetro.
Dicho procedimiento deberá devolver el número de películas que ha alquilado ese socio en ese mes concreto del año dado.

Para hacer esto, calcularemos para cada socio, el número de películas que ha alquilado cada socio en un mes y año 
(esto es lo que nos devuelve el procedimiento) y lo compararemos con el máximo número de películas
 que un socio ha alquilado ese mes y año, si coincide, entonces lo almacenaremos en la tabla MEJORES SOCIOS.
Después visualizaremos el contenido de la tabla MEJORES SOCIOS.

Ejemplo de resultado:
Mes     Año     NombreSocio     NºpeliculasAlquiladas
1      2010     JUAN LOPEZ           19
2      2010     ANA PÉREZ            24
……………………………..
*/

--Fechas

select min(fecha_salida) from ALQUILER --fecha mas antigua
select max(FECHA_DEVOLUCION) from ALQUILER  --fecha mas reciente


select a.codigo_socio,s.nombre, month(a.fecha_salida) as mes, count(*) as nalquiler
from socios  s
inner join alquiler  a on s.codigo=a.codigo_socio
group by a.codigo_socio,s.nombre, month(a.fecha_salida)
--order by nalquiler ,month(a.fecha_salida) 

