/*
Crearemos un cursor para recorrer todos
los registros de la tabla PACIENTES
*/

-- Declaramos todas las variables dónde recuperaremos la información de la select

Declare @codigo smallint, @nombre nvarchar(30), @direccion nvarchar(20), 
@ciudad nvarchar(15), @telefono nvarchar(10)

-- Declaramos el cursor
Declare cursorPacientes cursor for 
select codigo, nombre, direccion, ciudad from pacientes

--Apertura del cursor 
OPEN cursorPacientes  

--Lectura de la primera fila del cursor 
FETCH cursorPacientes INTO @codigo, @nombre, @direccion, @ciudad
print 'CODIGO   Nombre         Direccion    Ciudad  Telefono'
WHILE(@@FETCH_STATUS= 0)  --Mientras se hayan recuperado los datos del cursor correctametne
BEGIN 
print cast(@codigo as nvarchar)+'  '+@nombre+'  '+@direccion+'  '+@ciudad
--Lectura de la siguiente fila de un cursor 
--Obtener el siguiente
FETCH cursorPacientes INTO @codigo, @nombre, @direccion, @ciudad

-- Fin del bucle WHILE 
END 

-- Cerramos el cursor 
CLOSE cursorPacientes

--Libera los recursos del cursor 
DEALLOCATE cursorPacientes

