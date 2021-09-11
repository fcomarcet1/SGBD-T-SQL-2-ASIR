--DECLARAR VARIABLES

DECLARE @diabetico BIT
DECLARE @contador int
DECLARE @nombre nvarchar(30)

--Asignacion valores a variables

SET @diabetico = 1
SET @contador = 30001

WHILE (@contador <= 30099)
	BEGIN
		IF(EXISTS (SELECT * FROM tblpacientes
					 WHERE intCodigo = @contador AND btDiabetico = @diabetico))
			BEGIN
				SELECT @nombre=strNombre FROM tblpacientes 
					WHERE intCodigo = @contador AND btDiabetico = @diabetico

				PRINT cast(@contador as nvarchar(6)) + '  ' + @nombre
			END
		SET @contador = @contador + 1
	END



