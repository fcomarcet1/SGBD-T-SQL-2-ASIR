-- Ejercicio para entender las transacciones anidadas

USE TEMPDB
GO
CREATE TABLE Cabecera(id int, fecha Datetime)
GO
CREATE TABLE Detalle(CabeceraId int, linea int NOT NULL, Cantidad decimal(8,2) NOT NULL)
GO
CREATE TABLE Auditoria(id int identity, fecha Datetime NOT NULL)

--- Vamos a ejecutar este script paso a paso para ir comprendiendo como funcionan las transacciones
-- =====================================================
--     Funcionamiento del ROLLBACK
-- ======================================================

-- visualizamos la variable @@TRANCOUNT para ver que no hay transacciones
SELECT @@TRANCOUNT

-- Abrimos una transaccion
BEGIN TRAN
-- Insertamos datos
	INSERT INTO Cabecera VALUES (1,GETDATE())
	INSERT INTO Detalle VALUES (1,1,100)
	
-- Mostramos las transacciones abiertas(1)
	SELECT @@TRANCOUNT
-- Abrimos una transaccion nueva
	BEGIN TRAN

	--	visualizamos la variable @@TRANCOUNT para ver que se incrementó en 1
    SELECT @@TRANCOUNT

-- Hacemos un rollback
	ROLLBACK TRAN

--	Verificamos que la variable @@TRANCOUNT vale 0, luego se ha hecho un rollback de todas las transacciones
    SELECT @@TRANCOUNT
	
	go
	
-- =====================================================
--     Funcionamiento del COMMIT
-- ======================================================

-- visualizamos la variable @@TRANCOUNT para ver que no hay transacciones
SELECT @@TRANCOUNT

-- Abrimos una transaccion
BEGIN TRAN
-- Insertamos datos
	INSERT INTO Cabecera VALUES (1,GETDATE())
	INSERT INTO Detalle VALUES (1,1,100)
-- Mostramos las transacciones abiertas(1)
	SELECT @@TRANCOUNT
	BEGIN TRAN

	--	visualizamos la variable @@TRANCOUNT para ver que se incrementó en 1
    SELECT @@TRANCOUNT
	
	INSERT INTO Auditoria (fecha) VALUES (GETDATE())
	-- hacemos commit
	COMMIT TRAN
	
--	Verificamos que la variable @@TRANCOUNT se ha decrementado en 1
    SELECT @@TRANCOUNT
		-- hacemos el último commit
	COMMIT TRAN
	--	Verificamos que la variable @@TRANCOUNT vale ahora 0
    SELECT @@TRANCOUNT