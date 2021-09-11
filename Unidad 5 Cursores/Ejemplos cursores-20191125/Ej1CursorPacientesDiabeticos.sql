/*
Crearemos un cursor para recorrer los 5 primeros los PACIENTES NO diabéticos.
*/

-- Declaramos todas las variables dónde recuperaremos la información de la select

Declare @codigo smallint, @nombre nvarchar(30), @direccion nvarchar(20), 
@ciudad nvarchar(15), @telefono nvarchar(10)

Declare @cont smallint



-- Declaramos el cursor
Declare cursorPacientes cursor for 
select codigo, nombre, direccion, ciudad, telefono from pacientes where diabetico=0

--Apertura del cursor 
OPEN cursorPacientes  

--Lectura de la primera fila del cursor 
FETCH cursorPacientes INTO @codigo, @nombre, @direccion, @ciudad, @telefono
set @cont=1
print 'CODIGO   Nombre         Direccion    Ciudad  Telefono'
WHILE(@@FETCH_STATUS= 0 && @cont<=5)  --Mientras se hayan recuperado los datos del cursor correctametne
BEGIN 
print cast(@codigo as nvarchar)+'  '+@nombre+'  '+@direccion+'  '+@ciudad+'  '+@telefono
--Lectura de la siguiente fila de un cursor 
--Obtener el siguiente
FETCH cursorPacientes INTO @codigo, @nombre, @direccion, @ciudad, @telefono
set @cont=@cont+1

-- Fin del bucle WHILE 
END 

-- Cerramos el cursor 
CLOSE cursorPacientes

--Libera los recursos del cursor 
DEALLOCATE cursorPacientes

