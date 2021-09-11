/*Para aquellos pacientes que tienen más de 3 visitas, muestra por pantalla sus visitas,
incrementando el importe un 20% de aquellas que sean por ‘Gripe’. 
Si son por ‘Úlcera’, se deberá incrementar un 40%.

Al procedimiento que se llamará en el script principal se le pasará el código de Paciente 
y no devolverá nada, simplemente imprimirá por pantalla cada visita de cada paciente.

Desde el script principal será desde donde se imprima por pantalla la siguiente información:
Código Paciente - Nombre Paciente - Nº Visitas
*/

-- PROCEDIMEINTO
CREATE PROCEDURE procvisitas @codpaciente smallint
AS
DECLARE @CONT INT, 
		@MAX INT,
		@ENFER NVARCHAR(25),
		@IMPOR INT

SELECT @CONT = MIN(NUMVISITA), @MAX = MAX(NUMVISITA) 
FROM VISITAS 
WHERE CODPACIENTE = @codpaciente

PRINT space(2) + '- Visitas:'

WHILE (@CONT <= @MAX)
	BEGIN
		IF(EXISTS(SELECT * FROM VISITAS 
		WHERE NUMVISITA = @CONT 
		AND CODPACIENTE=@codpaciente))

		BEGIN
			SELECT @ENFER=ENFERMEDAD, @IMPOR=IMPORTE 
			FROM VISITAS WHERE NUMVISITA = @CONT

			IF (@ENFER like 'Gripe')
				BEGIN
					SET @impor = @impor * 1.2
				END
			ELSE IF(@ENFER like'Úlcera')
				BEGIN
					SET @impor = @impor * 1.4
				END
			PRINT space(6) + ' * ' + CAST(@CONT AS NVARCHAR(5)) 
			+ '      ' +  @ENFER + '      ' + CAST(@IMPOR AS NVARCHAR(10))
		END
			SET @CONT += 1
	END

	
-- SCRIPT PRINCIPAL
DECLARE @CONT INT,
		@MAX INT,
		@NOMBRE NVARCHAR(30),
		@NVISITAS INT

SELECT @CONT=MIN(CODIGO),@MAX=MAX(CODIGO) FROM PACIENTES

PRINT 'Cod. Paciente  -   Nombre   -     NºVisitas'
PRINT '----------------------------------------'

WHILE (@CONT<=@MAX)
	BEGIN
	 IF (EXISTS(SELECT v.CODPACIENTE FROM PACIENTES p 
	 inner join VISITAS v ON v.CODPACIENTE = p.CODIGO
	 WHERE CODPACIENTE = @CONT
	 GROUP BY v.CODPACIENTE
	 HAVING COUNT(*) > 3))
	 
		BEGIN
			SELECT @NOMBRE = NOMBRE FROM PACIENTES 
			WHERE CODIGO =  @CONT
			PRINT CAST(@CONT AS NVARCHAR(6)) + space(8)+ @NOMBRE
			EXEC procvisitas @cont
		END
	SET @CONT += 1
	END