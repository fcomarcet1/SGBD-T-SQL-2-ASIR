/* 8. Mediante TransactSQL, programa un script en el que se muestren
por pantalla sólo los pacientes de la tabla Pacientes que sean de Alicante.
La salida deberá ser mostrando los siguientes campos de cada paciente:

Nombre Paciente - Fecha de nacimiento - Teléfono - Ciudad */


DECLARE @contador int,
        @nombre nvarchar(30),
        @ciudad nvarchar(15), 
        @telefono nvarchar(10), 
        @fechanac datetime

SET @ciudad = 'Alicante'
SET @contador = 30001

PRINT 'Nombre Paciente - Fecha Nacimiento - Teléfono - Ciudad'

WHILE (@contador <= 30099)
    BEGIN
        IF(EXISTS (SELECT * FROM PACIENTES WHERE CODIGO = @contador AND Ciudad = @ciudad))
            BEGIN
                SELECT @nombre=NOMBRE, @telefono = telefono, @fechanac = FECHANAC
                FROM PACIENTES WHERE CODIGO = @contador AND CIUDAD = @ciudad

                PRINT @nombre + ' ' + convert(varchar(20), @fechanac, 120)
                + ' ' + @telefono + ' ' + @ciudad
            END
    SET @contador += 1
END