/*----------------------------------
TRIGGER DML
Crearemos un disparador que cuando actualicemos 
el turno de los pacientes de Alicante, nos almacene los datos
antiguos de los mismos en una tabla llamada HPacAlicante*/

CREATE TRIGGER TR_PACIENTESup
ON PACIENTES 
AFTER UPDATE
AS 
BEGIN
  -- SET NOCOUNT ON impide que se generen mensajes de texto con cada instrucción 
SET NOCOUNT ON
  IF UPDATE(turno) -- Solo si se actualiza Turno
  BEGIN 
    if object_Id('HPac_Alicante')is null
	begin
	 create table HPac_Alicante 
	 (codigo smallint, nombre nvarchar(30),
	 direccion nvarchar(20),ciudad nvarchar(15), telefono nvarchar(10),diabetico bit,
	 fechanac datetime, turno smallint, fechaReg datetime)
	end
	INSERT INTO HPac_Alicante SELECT codigo,nombre,direccion,ciudad, 
	telefono,diabetico,fechanac, turno,getdate() FROM DELETED
  END

END
