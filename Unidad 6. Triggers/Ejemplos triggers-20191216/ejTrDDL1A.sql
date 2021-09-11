/*----------------------------------
TRIGGER DDL para la BD clínica que no permita borrar ninguna tabla de la BD.
*/

CREATE TRIGGER TR_SEGURIDADB
ON DATABASE FOR ALTER_TABLE
AS 
BEGIN
RAISERROR ('No está permitido modificar la estructura de las tablas !' , 16, 1)
ROLLBACK TRANSACTION 
END
