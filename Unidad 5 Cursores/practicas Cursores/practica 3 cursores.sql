/*EJERCICIO 1. Realiza un script con un cursor que muestre todo el dinero ganado en un
mes para cada una de las pizzas. El mes que se mostrará será el que más pizzas se haya
comprado de ese tipo concreto. Puedes utilizar internamente funciones y
procedimientos.*/

IF OBJECT_ID ('dbo.beneficioPizzafavorita') IS NOT NULL  
    DROP PROCEDURE dbo.beneficioPizzafavorita;  
GO

CREATE PROCEDURE beneficioPizzafavorita
    @Npizza VARCHAR(20), 
    @beneficioTotal DECIMAL(4,2) OUTPUT 

AS

DECLARE  @mes int ,@beneficioTotal INT

SELECT TOP 1 @beneficioTotal = SUM(p.price),@mes = datepart(MONTH from s.date2) 
FROM pizzas p
INNER JOIN sales s on p.Npizza = s.Npizza
WHERE s.Npizza LIKE @Npizza
GROUP BY datepart(MONTH from s.date2)
ORDER BY SUM(p.price) DESC
 
--DECLARE @Npizza nvarchar(20), @beneficioTotal int  
--EXECUTE dbo.beneficioPizzafavorita @Npizza, @beneficioTotal  OUTPUT 
--PRINT CAST(@beneficioTotal as nvarchar(10))
GO
--CURSOR
DECLARE @Npizza VARCHAR(20),
        @mes INT,
        @importetotal INT

DECLARE BeneficiosMesPizzas CURSOR
FOR
        SELECT TOP 1  (s.Npizza) ,
	    DATEPART(MONTH FROM s.date2), --as mes, 
        SUM(p.price) --as[Importe Total]
        FROM sales s
        inner join pizzas p on s.Npizza =p.Npizza
        GROUP BY  s.Npizza,DATEPART(MONTH FROM s.date2)
		ORDER BY SUM(p.price)

OPEN BeneficiosMesPizzas
FETCH BeneficiosMesPizzas INTO @Npizza, @mes, @importetotal
WHILE(@@FETCH_STATUS = 0)
    BEGIN
        --declare @mesletras nvarchar(10)
        --set @mesletras = (SELECT DATENAME(datepart, @mes)); 
		DECLARE  @beneficioTotal decimal(4,2)  
		EXECUTE dbo.beneficioPizzafavorita @Npizza, @beneficioTotal  OUTPUT 
		PRINT 'MES:'+cast(@mes as nvarchar(20))
		PRINT 'PIZZA:'+@Npizza
		PRINT 'BENEFICIO:'+cast(@beneficioTotal as nvarchar(20))
		PRINT space(1)
    FETCH BeneficiosMesPizzas INTO @Npizza, @mes, @importetotal
    END       
CLOSE BeneficiosMesPizzas
DEALLOCATE BeneficiosMesPizzas


/*EJERCICIO 2. Realiza un script con un cursor en el que se muestren todas las películas
que han obtenido al menos un 10 de calificación por alguno de los socios. Además,
deberás mostrar el socio que la calificó con esta nota.*/

--CURSOR
GO
USE videoclub
GO
DECLARE @titulo nvarchar(40),
        @codigo int,
        @codigo_socio int,
		@nombre nvarchar(40)

DECLARE PeliculasCalificacion10 CURSOR
FOR
    select p.titulo, a.codigo_socio, s.codigo, s.nombre
    from peliculas p
    inner join STOCK stk on stk.CODIGO_PELICULA = p.codigo
    inner join alquiler a on a.codigo_stock = stk.CODIGO
	inner join socios s on a.CODIGO_SOCIO = s.CODIGO
    where CALIFICACION = 10

OPEN PeliculasCalificacion10
FETCH PeliculasCalificacion10 INTO @titulo, @codigo_socio, @codigo, @nombre
PRINT '**--------Peliculas con Calificacion de 10--------**'
PRINT '-----------------------------------------------------'
WHILE(@@FETCH_STATUS = 0)
    BEGIN		
		PRINT 'Titulo:' + @titulo
		PRINT 'Socio nº:' + cast(@codigo as nvarchar(20))+space(3)+@nombre
		print space(1)
		FETCH PeliculasCalificacion10 INTO @titulo, @codigo_socio, @codigo,  @nombre
    END
CLOSE PeliculasCalificacion10
DEALLOCATE PeliculasCalificacion10 


/*EJERCICIO 3. Muestra los socios que hayan alquilado al menos una película y
posteriormente muestra las categorías de las que han obtenido películas.*/

--SOLUCION
/*Vamos a realizar un cursor que recorra las tabla socio-alquiver para mostrar socios
con + 1 alquiler.
Las categorias las obtendremos de otro cursor
*/

--CURSOR
DECLARE @codigo INT,
        @nombre NVARCHAR(22),
        @apellidos NVARCHAR(22),
        @Nalquileres INT

DECLARE sociosalquiler CURSOR
FOR
    SELECT  s.codigo,s.nombre,s.apellido, count(*) --as Nalquileres
    from socios s
    inner join alquiler a on CODIGO_SOCIO = codigo
    group by codigo,nombre,apellido
    having count(*)>1

OPEN  sociosalquiler   
FETCH  sociosalquiler INTO @codigo, @nombre, @apellido, @Nalquileres
WHILE(@@FETCH_STATUS = 0)
    BEGIN
    PRINT 'Socio nº:' + cast(@codigo as nvarchar(20))+space(3)
    PRINT 'Nombre:'+@nombre
    PRINT 'Apellidos:'+@apellido
    print space(1)
         --2º cursor
            DECLARE @codigosocio INT, @nombrecategoria NVARCHAR(25)
            DECLARE CategoriasSocio CURSOR
            FOR
                SELECT a.CODIGO_SOCIO, c.nombre
                FROM alquiler a
                INNER JOIN stock stk ON stk.codigo= a.codigo_socio
                inner join peliculas p on p.codigo = stk.CODIGO_PELICULA
                inner join categoria c on c.codigo = p.CODIGO_CATEGORIA
                where CODIGO_SOCIO = @codigo 
            OPEN  CategoriasSocio
            FETCH  CategoriasSocio INTO @codigosocio, @nombrecategoria 
            WHILE(@@FETCH_STATUS = 0)
                BEGIN 
                PRINT 'CATEGORIA:'+@nombrecategoria
                
                FETCH  CategoriasSocio INTO @codigosocio, @nombrecategoria 
                END
            CLOSE CategoriasSocio
            DEALLOCATE CategoriasSocio  
    FETCH  sociosalquiler INTO @codigo, @nombre, @apellido, @Nalquileres
    END
CLOSE sociosalquiler
DEALLOCATE sociosalquiler


/*EJERCICIO 4. Vamos a realizar un pequeño programa que analice si nos sale rentable
tener a ciertos pacientes en nuestro seguro médico. Para ello, tendremos que añadir un
campo a la tabla PACIENTES que se llamará ‘TARIFA’ y será de tipo DECIMAL (8, 2).
A este campo le indicaremos como valor por defecto 50€.

A partir de aquí, crear un cursor que recorra la siguiente consulta:
NOMBRE PACIENTE, CIUDAD, NUM_VISITAS
Para cada línea del cursor se debe realizar:
     Si el número de visitas de pacientes es > 4 debe:
        1. Imprimir el mensaje de: PACIENTE PROBLEMÁTICO
        2. Aumentar la tasa mínima a cobrar por el paciente un 20%.

     Ejecutar un Procedimiento Almacenado, donde le pasaremos la Ciudad y nos
    devuelva la media del Importe de las visitas correspondientes a pacientes de esa
    Ciudad.

     Si la media devuelta por el procedimiento almacenado es mayor que 250, debe
    realizar lo siguiente:
        1. Insertar en la tabla PACIENTES_PROBLEMATICOS (que tendremos que
        crear), el Nombre del paciente y su código, la media del importe de
        visitas, la tarifa y la fecha en la que se realiza la inserción.

 Mostrar por pantalla:
PACIENTE: XXXXXXXXXXXX(Nombre)
TARIFA: XXXXX
MEDIA DEL IMPORTE: XXXX (Media devuelta por el procedimiento)*/

ALTER TABLE pacientes ADD tarifa decimal(8,2)

CREATE TABLE  PACIENTES_PROBLEMATICOS
    (
        codigo INT PRIMARY KEY,
        nombre nvarchar(25),
        mediaimporte decimal(5,2),
        tarifa decimal (5,2),
        fecharegistro date

    )

--STORED PROCEDURE(SP)

USE clinica;
GO
IF OBJECT_ID ('dbo.Mediaimporte') IS NOT NULL  
    DROP PROCEDURE dbo.Mediaimporte;  
GO
CREATE PROCEDURE Mediaimporte
    @ciudad nvarchar(25),
    @mediavisitas decimal(8,2) OUTPUT
AS
    
    SELECT @mediavisitas = AVG(importe)
    FROM visitas
    INNER JOIN pacientes on codpaciente = codigo
    WHERE ciudad = @ciudad 
GO

--DECLARE @mediavisitas int
--EXECUTE dbo.Mediaimporte 'ALICANTE',  @mediavisitas  OUTPUT
--PRINT  'MEDIA IMPORTE VISITAS:'+cast(@mediavisitas as nvarchar(20))

--CURSOR
DECLARE @nombre NVARCHAR(25),
        @ciudad NVARCHAR(25),
        @Nvisitas int,
        @tarifa decimal(8,2),
		@codigo int,
        @tarifaup decimal(8,2)

DECLARE RentabilidadPacientes CURSOR
FOR
    SELECT codigo,nombre, ciudad, COUNT(*),tarifa
    FROM pacientes
    INNER JOIN visitas ON codpaciente = codigo
    group by codigo,nombre,ciudad,tarifa

OPEN RentabilidadPacientes
FETCH RentabilidadPacientes INTO @codigo, @nombre, @ciudad, @Nvisitas, @tarifa
WHILE(@@FETCH_STATUS = 0)
    BEGIN 
        PRINT 'PACIENTE:'+@nombre
            IF(@Nvisitas > 4)
                BEGIN
                    PRINT 'PACIENTE PROBLEMATICO'
                    SET @tarifaup = @tarifa * 1.20
                    PRINT 'TARIFA:'+CAST(@tarifa as nvarchar(10))
                    --print space(1)
                END
            ELSE
                BEGIN 
                    PRINT 'TARIFA:'+cast(@tarifa as nvarchar(25))
                END    
        DECLARE @mediavisitas INT
        EXECUTE dbo.Mediaimporte @ciudad,  @mediavisitas  OUTPUT
            IF(@mediavisitas > 250)
                BEGIN 
                    INSERT INTO PACIENTES_PROBLEMATICOS (codigo, nombre, mediaimporte, tarifa, fecharegistro)
                    VALUES(@codigo, @nombre, @mediavisitas, @tarifa, GETDATE())
                END
        PRINT 'MEDIA IMPORTE VISITAS:'+CAST(@mediavisitas as NVARCHAR(20))
        PRINT '*********************************************'
        print space(1)

	FETCH RentabilidadPacientes INTO @codigo, @nombre, @ciudad, @Nvisitas, @tarifa
    END
CLOSE RentabilidadPacientes
DEALLOCATE RentabilidadPacientes
