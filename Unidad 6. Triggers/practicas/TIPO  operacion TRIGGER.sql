-- TRIGGER QUE SE LANCE EN UN INSERT, UPDATE OR DELETE

--INDICARÁ LA OPERACIÓN REALIZADA, INTRODUCIÉNDOLA EN LA TABLA HISTÓRICO PACIENTES. INTRODUCIREMOS TAMBIÉN AL FECHA Y EL USUARIO QUE HA REALZIADO LA OPERACIÓN.
-- OPERACIONES POSIBLES:
-- INSERT(INS): insertar el nuevo registro.
-- UPDATE(UPD): insertar el viejo
-- O DELETE(DLT): insertar el viejo

CREATE TRIGGER TR_PACIENTES_OP
ON PACIENTES
AFTER UPDATE, INSERT, DELETE
AS
BEGIN
SET NOCOUNT ON
    DECLARE @FECHA DATETIME, @OPERACION CHAR(3), @USUARIO NVARCHAR(20), @CODIGO SMALLINT, @NOMBRE NVARCHAR(30), @DIRECCION NVARCHAR(100)

    SET @FECHA = GETDATE()
    SET @USARIO = CURRENT_USER
    SET @OPERACION = (CASE
        WHEN EXISTS (SELECT * FROM INSERTED) AND EXISTS (SELECT * FROM DELETED)
            THEN 'UPD'
        WHEN EXISTS (SELECT * FROM INSERTED) 
            THEN 'INS'
        WHEN EXISTS (SELECT * FROM DELETED)
            THEN 'DLT'
        ELSE NULL
        END)

    IF(@OPERACION = 'UPD' or @OPERACION = 'DLT')
        BEGIN
            INSERT INTO HTCO_PACIENTES SELECT CODIGO, NOMBRE, DIRECCION, @OPERACION, @USUARIO, @FECHA
            FROM DELETED
        END
    ELSE IF(@OPERACION = 'INS')
        BEGIN
            INSERT INTO HTCO_PACIENTES SELECT CODIGO, NOMBRE, DIRECCION, @OPERACION, @USUARIO, @FECHA 
            FROM INSERTED
        END
END











CREATE TRIGGER TR_PACIENTES_OP
ON PACIENTES
AFTER UPDATE, INSERT, DELETE
AS
BEGIN
SET NOCOUNT ON
    DECLARE @FECHA DATETIME, @OPERACION CHAR(3), @USUARIO  @CODIGO SMALLINT, @NOMBRE NVARCHAR(30), @DIRECCION NVARCHAR(100), 

    SET @FECHA = GETDATE()
    SET @USER = CURRENT_USER
    SET @OPERACION = (CASE
        WHEN EXISTS (SELECT * FROM INSERTED) AND EXISTS (SELECT * FROM DELETED)
            THEN 'UPD'
        WHEN EXISTS (SELECT * FROM INSERTED) 
            THEN 'INS'
        WHEN EXISTS (SELECT * FROM DELETED)
            THEN 'DLT'
        ELSE NULL
        END)

    IF(@OPERACION = 'UPD' or @OPERACION = 'DLT')
        BEGIN
            INSERT INTO HTCO_PACIENTES SELECT CODIGO, NOMBRE, DIRECCION, @OPERACION, @USUARIO, @FECHA
            FROM DELETED
        END
    ELSE IF(@OPERACION = 'INS')
        BEGIN
            INSERT INTO HTCO_PACIENTES SELECT CODIGO, NOMBRE, DIRECCION, @OPERACION, @USUARIO, @FECHA 
            FROM INSERTED
        END
END