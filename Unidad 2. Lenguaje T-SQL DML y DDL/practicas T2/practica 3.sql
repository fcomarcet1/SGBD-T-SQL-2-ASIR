/*EJERCICIO 1. Para la BD clínicaBD, crear una variable que contenga el CODIGO de una
persona, comprobar si existe ese Paciente, si no existe mostrar un mensaje de error
"ERROR, PACIENTE INEXISTENTE".*/

--DECLARACION DE VARIABLES
DECLARE @codigo smallint

--ASIGNACION DE VALORES A LAS VARIABLES
SET @codigo=30099

--BUCLE DE CONTROL
IF(EXISTS(SELECT * FROM tblpacientes WHERE intCodigo=@Codigo))
    BEGIN
        PRINT 'EXISTE EL PACIENTE'
    END

ELSE
    BEGIN
         PRINT ' "ERROR, PACIENTE INEXISTENTE'
    END    



/*EJERCICIO2. Para la BD clínica BD, tenemos que crear un script en transactSQL en el que
mostraremos el gentilicio de los pacientes de código entre 1 y 10. (Para ello haz un
consulta de los nombres de las ciudades, para luego poder sacar el gentilicio.) Tenéis
que utilizar obligatoriamente todas las estructuras de control que conocéis. (IF,CASE y
WHILE).*/

/*NOTA he sustituido los codigos del 1 al 10 por del 30001 al 30099 ya que asi recorre la tabla de pacientes de la base de dats clinica*/

--DECLARACION DE VARIABLES
DECLARE @strCiudad NVARCHAR(15), @gentilicio NVARCHAR(15), @contador int
       


--ASIGNACION DE VALORES A LAS VARIABLES
SET @contador = 30001


SET @gentilicio =(SELECT strCiudad = 
                                    (CASE
                                    WHEN (strCiudad='ALICANTE') THEN 'ALICANTINO'
                                    WHEN (strCiudad='SAN JUAN') THEN 'SANJUANERO'
                                    WHEN (strCiudad='EL CAMPELLO') THEN 'CAMPELLERO'
                                    WHEN (strCiudad='MUTXAMEL') THEN 'MUCHAMELERO'
                                    WHEN (strCiudad='VILLAJOYOSA') THEN 'VILERO'
                                 
                                    ELSE
                                    'GENTILICIO NO ENCONTRADO'
                                    END)
                                    FROM tblpacientes)

WHILE(@contador < 30099)
    BEGIN 
        IF(EXISTS(SELECT * FROM tblpacientes 
                  WHERE intCodigo=@contador))
                BEGIN 
                    SELECT strCiudad=@strCiudad 
                    FROM tblpacientes 
                    WHERE intCodigo=@contador 

                    PRINT CAST(@contador AS NVARCHAR(6))+'  '+ @gentilicio
                END

    SET @contador = @contador + 1
    END




/*EJERCICIO3. Para la BD clínica BD, mostrad para todos los pacientes que no son
diabéticos, mostrar su nombre y apellido y su turno. Si el paciente no tiene turno
asignado, mostrar 'NO PERTENECE A NINGÚN TURNO'.*/

DECLARE @diabetico BIT, @contador int, @nombre nvarchar(30), @turno int 

--Asignacion valores a variables

SET @diabetico = 0
SET @contador = 30001
set @turno= 2


WHILE (@contador <= 30099)
	BEGIN
		IF(exists(SELECT * FROM tblpacientes 
	                WHERE intCodigo = @contador 
                    AND btDiabetico = @diabetico))
	    BEGIN
            SELECT @nombre=strNombre FROM tblpacientes 
	        WHERE intCodigo = @contador AND btDiabetico = @diabetico 
             AND intTurno = @turno

	        PRINT cast(@contador as nvarchar(6)) + '  ' + @nombre + '  ' + cast(@turno as nvarchar(1))        
	    END
		

		SET @contador = @contador + 1
	END





