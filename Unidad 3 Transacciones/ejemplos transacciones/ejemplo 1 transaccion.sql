DECLARE @Monto DECIMAL(18,2),
@CuentaADecrementar VARCHAR(12),
@CuentaAIncrementar VARCHAR(12) 

/* Asignamos el monto de la transacción y las cuentas a afectar*/

SET @Monto = 1900 
SET @CuentaADecrementar = '20161206'
SET @CuentaAIncrementar = '20161207' 

BEGIN TRANSACTION 
BEGIN TRY

/* Descontamos el monto de la cuenta a decrementar */
UPDATE CUENTAS 
SET SALDO = SALDO - @Monto 

WHERE NUMCUENTA = @CuentaADecrementar 

/* Registramos el movimiento */
INSERT INTO MOVIMIENTOS (IDCUENTA, SALDO_ANTERIOR, SALDO_POSTERIOR,IMPORTE, FXMOVIMIENTO)

/* Incrementamos el monto de la cuenta a incrementar */
UPDATE CUENTAS 
SET SALDO = SALDO + @Monto 
WHERE NUMCUENTA = @CuentaAIncrementar 

/* Registramos el movimiento */
INSERT INTO MOVIMIENTOS (IDCUENTA, SALDO_ANTERIOR, SALDO_POSTERIOR, IMPORTE, FXMOVIMIENTO)

/* Confirmamos la transaccion*/
COMMIT TRANSACTION 

END TRY

BEGIN CATCH

/* Ocurrió un error, deshacemos los cambios*/ 
ROLLBACK TRANSACTION
PRINT 'Ha ocurrido un error!'

END CATCH



Los puntos de recuperación (SavePoints) permiten manejar las transacciones por pasos, pudiendo hacer rollbacks hasta un punto marcado por el savepoint y no por toda la transacción.

Ejemplo:

 
BEGIN TRAN 

UPDATE Clientes SET Estado = 'Inactivo' WHERE iddepartamento = 1020 

UPDATE Clientes SET Estado = 'DeBaja' WHERE iddepartamento=7025

SAVE TRANSACTION Punto1 -- Guardamos la transaccion (Savepoint)

UPDATE Clientes SET Descripcion = 'Ninguna' WHERE idcliente=5896

-- Este ROLLBACK afecta solo a las instrucciones posteriores al savepoint Punto1.

ROLLBACK TRANSACTION Punto1 

-- Confirmamos la transaccion

COMMIT