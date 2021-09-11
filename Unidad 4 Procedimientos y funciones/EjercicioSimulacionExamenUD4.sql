/*Almacena en una nueva tabla los pacientes que son diabéticos
PACIENTESDIABETICOS (Codigo, Nombre, Ciudad, Telefono, Visitas)
Para los de turno 1 tendréis que almacenar el campo visitas, el cuál
lo tendréis que obtener contando las visitas que ha realizado mediante una función
*/
--DDL crear tabla
CREATE TABLE PacientesDiabeticos
(
Codigo smallint PRIMARY KEY,
Nombre nvarchar(30),
Ciudad nvarchar(15),
Telefono nvarchar(10),
Visitas int NULL
)

--Script principal
DECLARE @CONT INT,@MAX INT
DECLARE @NOMBRE NVARCHAR(30), @ciudad nvarchar(15), @turno smallint, @telefono nvarchar(10), 
@visitas int
SELECT @CONT=MIN(CODIGO),@MAX=MAX(CODIGO) FROM PACIENTES

WHILE (@CONT<=@MAX)
	BEGIN
	 IF (EXISTS(SELECT CODIGO FROM PACIENTES WHERE CODIGO = @CONT
		AND DIABETICO = 1))
		BEGIN
			SET @visitas = NULL
			SELECT @NOMBRE = NOMBRE, @ciudad = ciudad, @turno = turno, @telefono = telefono
			FROM PACIENTES WHERE CODIGO = @CONT 
			IF (@turno = 1)
				BEGIN
					SET @visitas = dbo.obtenerVisitas(@cont)
				END
				exec insertarRepaso @cont, @nombre, @ciudad, @telefono, @visitas
		END
		SET @CONT += 1
	END

--Función para obtener las visitas de un paciente
CREATE FUNCTION obtenerVisitas (@codigoPac smallint)
RETURNS int
AS
	BEGIN
		DECLARE @totalvisitas int = 0
			SELECT @totalvisitas = count(*) from visitas where [CODIGO PACIENTE] = @codigoPac
		RETURN @totalvisitas
	END

--Procedimiento
CREATE PROCEDURE insertarRepaso @codigo smallint, @nombre NVARCHAR(30), @ciudad nvarchar(15), @telefono nvarchar(10), 
@visitas int
AS
INSERT INTO PacientesDiabeticos (codigo, nombre, ciudad, telefono, visitas)
 VALUES(@Codigo, @nombre, @ciudad, @telefono, @visitas)

select * from PacientesDiabeticos