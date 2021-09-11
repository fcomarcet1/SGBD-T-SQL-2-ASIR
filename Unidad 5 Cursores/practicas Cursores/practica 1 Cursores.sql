/*Ejercicio 1
Crear un script con un cursor que imprima un mensaje diferente
según el gasto médico de cada paciente.
Si el gasto médico es inferior a 200 €, deberá mostrar BAJO, 
MEDIO entre 200€ y 400€ 
ALTO superior a 400€. El script debe mostrar el mensaje en una sola línea con el siguiente formato:
Nombre_Paciente Gasto XXXX.*/

--consulta
select codigo, nombre ,sum(importe)as ImporteTotalVisitas 
from pacientes
inner join visitas on CODPACIENTE = CODIGO
group by nombre, codigo

--CURSOR
SET NOCOUNT ON;
DECLARE @codigo SMALLINT,
		@nombre NVARCHAR(25), 
		@importetotal INT

DECLARE importepacientes CURSOR 
FOR
	SELECT p.codigo, p.nombre, SUM(v.importe)AS importetotal 
	FROM pacientes p 
	INNER JOIN visitas v ON p.codigo=v.CODPACIENTE 
	GROUP BY p.codigo,p.nombre

OPEN importepacientes
FETCH importepacientes INTO @codigo, @nombre, @importetotal
PRINT 'CODIGO------NOMBRE-----GASTO'
WHILE(@@FETCH_STATUS = 0)
	BEGIN
		IF (@importetotal < 200)
			BEGIN
				PRINT CAST(@codigo AS NVARCHAR(15)) + space(7) + @nombre + space(7) + 'BAJO'
			END
		ELSE IF (@importetotal >= 200 AND @importetotal <= 400)
			BEGIN
				PRINT CAST(@codigo AS NVARCHAR(15)) + space(7) + @nombre + space(7) + 'MEDIO'
			END
		ELSE IF (@importetotal>400)	
			BEGIN
				PRINT CAST(@codigo AS NVARCHAR(15)) + space(7) + @nombre + space(7) + 'ALTO'
			END
		FETCH importepacientes INTO @codigo, @nombre, @importetotal
	END
CLOSE importepacientes
DEALLOCATE importepacientes

/*Ejercicio 2
Modifica el script anterior, para que además en la misma línea a continuación muestre el importeTotal del
gasto. Nombre_Paciente Gasto XXXX: Media yyyy €
Para ello tendremos que utilizar el conversor de tipo:
CAST (@variable AS TIPODATO).*/

--consulta
select codigo, nombre ,sum(importe)as ImporteTotalVisitas 
from pacientes
inner join visitas on CODPACIENTE = CODIGO
group by nombre, codigo


--cursor
SET NOCOUNT ON;
DECLARE @codigo SMALLINT, 
		@nombre NVARCHAR(30), 
		@importetotal INT,
		@gastomedio int
DECLARE importetotalpacientes CURSOR 
FOR
SELECT p.codigo, p.nombre, SUM(v.importe)AS importetotal,(select avg(importe)from visitas ) 
	FROM pacientes p 
	INNER JOIN visitas v ON p.codigo=v.CODPACIENTE 
	GROUP BY p.codigo,p.nombre

OPEN importetotalpacientes
FETCH importetotalpacientes INTO @codigo, @nombre, @importetotal,@gastomedio
PRINT 'CODIGO-----NOMBRE-----GASTO-----GASTO MEDIO'
WHILE(@@FETCH_STATUS=0)
	BEGIN
		FETCH importetotalpacientes INTO @codigo, @nombre, @importetotal,@gastomedio
		IF (@importetotal < 200)
			BEGIN
				PRINT CAST(@codigo AS NVARCHAR(15)) + space(7) + @nombre + space(7) 
				+ CAST(@importetotal AS NVARCHAR(15))+space(7) + 'BAJO' +space(7)
                + CAST(@gastomedio AS NVARCHAR(15))
			END
		ELSE IF (@importetotal >= 200 AND @GASTO <= 400)
			BEGIN
				PRINT CAST(@codigo AS NVARCHAR(15)) + space(7) + @nombre + space(7) 
				+ CAST(@importetotal AS NVARCHAR(15))+space(7) + 'MEDIO' +space(7)
                + CAST(@gastomedio AS NVARCHAR(15))
			END
		ELSE IF(@importetotal>400)
			BEGIN
				PRINT CAST(@codigo AS NVARCHAR(15)) + space(7) + @nombre + space(7) 
				+ CAST(@importetotal AS NVARCHAR(15))+space(7) + 'ALTO' +space(7)
                + CAST(@gastomedio AS NVARCHAR(15))
			END
    FETCH importetotalpacientesImpar INTO @codigo, @nombre, @importetotal,@gastomedio        
	END
CLOSE importetotalpacientes
DEALLOCATE importetotalpacientes  

/*Ejercicio 3
Modifica el 2 script, para que muestre con el mismo formato anterior el listado los pacientes cuyo código
de paciente es impar.*/

--consulta
SELECT p.codigo, p.nombre, SUM(v.importe)AS importetotal,(select avg(importe)from visitas ) 
	FROM pacientes p 
	INNER JOIN visitas v ON p.codigo=v.CODPACIENTE 
    WHERE p.codigo %2 = 1
	GROUP BY p.codigo,p.nombre

--CURSOR
SET NOCOUNT ON;
DECLARE @codigo SMALLINT, 
		@nombre NVARCHAR(30), 
		@importetotal INT,
		@gastomedio int

DECLARE importetotalpacientesImpar CURSOR 
FOR
SELECT p.codigo, p.nombre, SUM(v.importe)AS importetotal,(select avg(importe)from visitas ) 
	FROM pacientes p 
	INNER JOIN visitas v ON p.codigo=v.CODPACIENTE 
    WHERE p.codigo %2 = 1
	GROUP BY p.codigo,p.nombre

OPEN importetotalpacientesImpar
FETCH importetotalpacientes INTO @codigo, @nombre, @importetotal,@gastomedio
PRINT 'CODIGO-----NOMBRE-----GASTO-----GASTO MEDIO'
WHILE(@@FETCH_STATUS=0)
	BEGIN
		IF (@importetotal < 200)
			BEGIN
				PRINT CAST(@codigo AS NVARCHAR(15)) + space(7) + @nombre + space(7) 
				+ CAST(@importetotal AS NVARCHAR(15))+space(7) + 'BAJO' +space(7)
                + CAST(@gastomedio AS NVARCHAR(15))
			END
		ELSE IF (@importetotal >= 200 AND @GASTO <= 400)
			BEGIN
				PRINT CAST(@codigo AS NVARCHAR(15)) + space(7) + @nombre + space(7) 
				+ CAST(@importetotal AS NVARCHAR(15))+space(7) + 'MEDIO' +space(7)
                + CAST(@gastomedio AS NVARCHAR(15))
			END
		ELSE IF(@importetotal>400)
			BEGIN
				PRINT CAST(@codigo AS NVARCHAR(15)) + space(7) + @nombre + space(7) 
				+ CAST(@importetotal AS NVARCHAR(15))+space(7) + 'ALTO' +space(7)
                + CAST(@gastomedio AS NVARCHAR(15))
			END
    FETCH importetotalpacientesImpar INTO @codigo, @nombre, @importetotal,@gastomedio    
	END
CLOSE importetotalpacientesImpar
DEALLOCATE importetotalpacientesImpar  

/*Ejercicio 4
Realiza un script con un cursor, que muestre para todos los pacientes cuyo código es impar, nombre,
número total de visitas y el importe de la visita más cara*/

--CONSULTA
SELECT p.codigo, p.nombre, COUNT(V.numvisita)AS Numvisitas
        ,MAX(importe)AS importeMax
FROM PACIENTES p 
INNER JOIN visitas v ON p.codigo=V.codpaciente
WHERE codigo %2 = 1
GROUP BY p.codigo, p.nombre






--CURSOR
DECLARE @codigo SMALLINT, 
        @nombre NVARCHAR(30), 
        @visitas INT,
        @importemax INT

DECLARE ImportePacientesMax CURSOR 
FOR
    SELECT p.codigo, p.nombre, COUNT(v.numvisita)AS Numvisitas
           ,MAX(IMPORTE)AS ImporteMax
    FROM pacientes p 
    INNER JOIN VISITAS V ON P.codigo=v.codpaciente 
    WHERE p.codigo %2 = 1
    GROUP BY p.codigo, p.nombre
OPEN ImportePacientesMax
FETCH ImportePacientesMax INTO @codigo, @nombre, @visitas, @importemax
PRINT 'CODIGO-----NOMBRE-----NºVISITAS-----CONSULTA MAX IMPORTE'
WHILE(@@FETCH_STATUS = 0)
	BEGIN
		PRINT CAST(@COD AS NVARCHAR(10)) + space(7)+ @nombre + space(7) 
        + CAST(@visitas AS NVARCHAR(10)) + space(7) + CAST(@importemax AS NVARCHAR(10))

		FETCH ImportePacientesMax INTO @codigo, @nombre, @visitas, @importemax
	END
CLOSE ImportePacientesMax
DEALLOCATE ImportePacientesMax