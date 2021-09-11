--DECLARAR VARIABLES

DECLARE @diabetico BIT
DECLARE @contador int
DECLARE @nombre nvarchar(30)

SET @diabetico = 1
SET @contador = 30001

WHILE (@contador <= 30099)
	BEGIN
		IF(EXISTS (SELECT * FROM PACIENTES WHERE CODIGO = @contador AND DIABETICO = @diabetico))
			BEGIN
				SELECT @nombre=NOMBRE FROM PACIENTES WHERE CODIGO = @contador AND DIABETICO = @diabetico
				PRINT cast(@contador as nvarchar(6)) + '  ' + @nombre
			END
		SET @contador += 1
	END