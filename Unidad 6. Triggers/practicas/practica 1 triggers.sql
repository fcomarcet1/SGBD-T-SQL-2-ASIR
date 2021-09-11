/*
Para la base de datos Video Club:
Ejercicio 1
Crear un trigger que no me permita modificar, ni borrar la estructura de ninguna tabla.
*/
--TRIGGER DDL

CREATE TRIGGER TR_SEGURIDADB
ON DATABASE 
FOR ALTER_TABLE,DROP_TABLE
AS 
BEGIN
RAISERROR ('No está permitido modificar ni borrar las tablas !' , 16, 1)
ROLLBACK TRANSACTION 
END

/*
Ejercicio 3
Crear un trigger que cada vez que se realice una operación de manipulación de datos 
sobre la tabla Alquileres de la base de datos,almacene en una tabla histórico, 
el registro anterior a ser modificado, el usuario que realizó la modificación, 
la fecha y la hora y la operación que se realizó.
*/

--TRIGGER DML

CREATE TRIGGER TR_HistoricoAlquileres
ON alquiler
AFTER UPDATE 
AS
    BEGIN
        SET NOCOUNT ON;
        DECLARE @usuario NVARCHAR(25), 
                @fechaReg DATETIME, 
                @operacion NVARCHAR(3),
				@codigo smallint,
				@nombre NVARCHAR(30),
				@codstock int,
				@fechasalida datetime,
				@fechadevolucion datetime
                
        IF OBJECT_ID('Halquileres')is null
        BEGIN
            CREATE TABLE Halquileres 
                (
                    codigo SMALLINT, 
                    nombre NVARCHAR(30),
                    codstock INT,
                    fechasalida DATETIME,
                    fechadevolucion DATE,
                    estado SMALLINT,
                    calificacion SMALLINT,
                    usuario NVARCHAR(25),
                    fechaReg datetime,
                    operacion nvarchar(25)
                )
        END
        
        SET @fechaReg = GETDATE()
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

        PRINT'Comprobacion tipo Op:'+@operacion
       
        IF (@operacion = 'DLT' or @operacion = 'UPD')
            BEGIN
                INSERT INTO Halquileres SELECT @codigo, @nombre, @codstock,
                    @fechasalida, @fechadevolucion, estado, calificacion,
                    @usuario, @fechaReg, @operacion
                    FROM DELETED
                 ROLLBACK   
            END
     END


/*
Ejercicio 4
Modificar el trigger DDL que has creado previamente para que no me permita 
crear ninguna nueva tabla.
*/

ALTER TRIGGER TR_SEGURIDADBCREATE  
ON DATABASE 
FOR CREATE_TABLE 
AS 
BEGIN
    RAISERROR ('No está permitido crear ninguna nueva tabla !' , 16, 1)
    ROLLBACK TRANSACTION 
END