  CREATE TABLE historicoPac (
	CODIGOHIST int IDENTITY(1,1) PRIMARY KEY
	CODIGO_PACIENTE smallint,
	NOMBRE nvarchar(30),
	DIRECCION nvarchar(100),
	OPERACION char(3),
	USUARIO nvarchar(20),
	FECHA datetime)

/*Indicará la operación realizada, introduciéndola en 
la tabla historicoPac. Introduciremos también la fecha,
y el usuario que ha realizado la operación.
OPERACIONES POSIBLES:
	-- INS: Insertar el nuevo registro
	-- UPD: Insertar el viejo
	-- DLT: Insertaré el viejo
*/
CREATE TRIGGER TR_PACIENTES_OP
ON PACIENTES 
AFTER UPDATE, INSERT, DELETE
AS 
BEGIN
SET NOCOUNT ON 
    DECLARE @fecha DATETIME, @operacion CHAR(3), @usuario NVARCHAR(20)
	DECLARE @codigo smallint, @nombre NVARCHAR(30),
		@direccion nvarchar(100)

	SET @fecha = GETDATE()
	SET @usuario = CURRENT_USER
	
    SET @operacion = (CASE 
		WHEN EXISTS(SELECT * FROM INSERTED) 
			AND EXISTS(SELECT * FROM DELETED)
			THEN 'UPD'  -- Set Action to Updated.
        WHEN EXISTS(SELECT * FROM INSERTED)
			THEN 'INS'  -- Set Action to Insert.
        WHEN EXISTS(SELECT * FROM DELETED)
			THEN 'DLT'  -- Set Action to Deleted.
        ELSE NULL -- Skip. It may have been a "failed delete".   
    END)

	IF (@operacion = 'DLT' or @operacion = 'UPD')
		BEGIN
			INSERT INTO historicoPac SELECT codigo, nombre, direccion,
				@operacion, @usuario, @fecha
				FROM DELETED
		END
	ELSE IF (@operacion = 'INS')
		BEGIN
			INSERT INTO historicoPac SELECT codigo, nombre, direccion,
				@operacion, @usuario, @fecha
				FROM INSERTED
		END
  END