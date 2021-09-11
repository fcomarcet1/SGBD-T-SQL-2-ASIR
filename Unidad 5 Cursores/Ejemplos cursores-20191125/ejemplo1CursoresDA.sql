/* Cursor que nos muestre los pacientes DIABÉTICOS de Alicante*/
----Ejemplo 1 Cursores BD Clinica

-- Declaramos las variables dónde almacenaremos los datos obtenidos por el cursor
Declare @codigo smallint, @nombre nvarchar(30), @direccion nvarchar(20), @telefono nvarchar(10)
-- Declaramos el cursor
Declare cpacientes cursor for Select codigo, nombre, direccion, telefono from pacientes
where diabetico=1 and ciudad='Alicante'
-- Abrir el cursor
Open cpacientes
--Obtener los datos del primer registro del cursor 
fetch cpacientes into @codigo, @nombre, @direccion, @telefono
--Comprobamos que hay más registros
-- Mientras queden registros, mostrar datos y obtener datos del siguiente registro
print ' CODIGO		NOMBRE				DIRECCIÓN		TELEFONO'
while(@@fetch_status=0)
begin 
print cast(@codigo as nvarchar) +' '+ @nombre +' '+ @direccion +' '+@telefono
fetch cpacientes into @codigo, @nombre, @direccion, @telefono
end 
-- Una vez que acabamos de recorrer todos los registros 
-- cerrar curor
close cpacientes
-- Liberar memoria del cursor 
deallocate cpacientes

