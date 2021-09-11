CREATE DATABASE test 
USE test

CREATE TABLE tbTablaPruebas 
(
 id  INT PRIMARY KEY IDENTITY(1,1),
 nombre VARCHAR(30),
 cantidad INT
)

CREATE TRIGGER dbo.test ON tbTablaPruebas
AFTER INSERT, UPDATE, DELETE
AS
 SELECT * FROM deleted;
 SELECT * FROM inserted;

*********************************************
INSERT INTO tbTablaPruebas (nombre,cantidad)
VALUES( 'PEDRO' , 200 )

INSERT INTO tbTablaPruebas (nombre,cantidad)
VALUES( 'PEPE', 300 )

INSERT INTO tbTablaPruebas (nombre,cantidad)
VALUES( 'PACO' , 400 )

INSERT INTO tbTablaPruebas (nombre,cantidad)
VALUES( 'JUAN', 1500 )

SELECT * FROM tbTablaPruebas

*********************************************

UPDATE tbTablaPruebas
SET nombre = 'ANTONIO' , cantidad = 10000
WHERE id = 1


update tbTablaPruebas
set cantidad = 25000
where id in (2,4)


INSERT INTO test ( nombre, cantidad)
VALUES 
        ( 1,'jose', 2500),
        ( 2,'gitano', 30000),
        ( 3,'ximo', 50000),
        ( 4,'elena', 70000)
ON DUPLICATE KEY UPDATE 
nombre = VALUES(nombre),
cantidad = VALUES(cantidad);

*********************************************

DELETE FROM tbTablaPruebas
WHERE id = 1

******************************
UPDATE orderSummary 
SET user= 'Jamie' WHERE order_number='AA1410000001' 
IF @@ROWCOUNT=0 
	BEGIN 
		INSERT INTO orderSummary (orderNumber, user)
		VALUES (''AA1410000001' ,'Jamie')

...

UPDATE orderSummary 
SET user= 'Jamie' WHERE order_number='AA1410000020' 
IF @@ROWCOUNT=0 
	BEGIN 
		INSERT INTO orderSummary (orderNumber, user) 
		VALUES (''AA1410000020' ,'Jamie')

MERGE orderSummary AS d
USING (VALUES('AA1410000001'),('AA1410000002'),...,('AA1410000020')) AS s (ordernumber)
ON s.ordernumber = d.order_number
WHEN MATCHED
THEN UPDATE  SET user = 'Jamie'
WHEN NOT MATCHED
THEN INSERT (order_number,user) 
VALUES (s.ordernumber,'Jamie');


select * from tbTablaPruebas

UPDATE tbTablaPruebas 
SET nombre= 'Jamie' WHERE id=1 
IF @@ROWCOUNT=0 
	BEGIN 
		INSERT INTO orderSummary (nombre, cantidad)
		VALUES ('Jamie' ,30000)
	END

UPDATE tbTablaPruebas 
SET nombre= 'eufrasio' WHERE id=2 
IF @@ROWCOUNT=0 
	BEGIN 
		INSERT INTO orderSummary (nombre, cantidad)
		VALUES ('pepe' ,30000)
	END

UPDATE orderSummary 
SET nombre= 'leila' WHERE cantidad=25000 
IF @@ROWCOUNT=0 
	BEGIN 
		INSERT INTO orderSummary (nombre, cantidad)
		VALUES ('leila' ,40000)
	END

	--------------------------

	
CREATE TRIGGER TR_INSERTAR_REGISTRO
AFTER INSERT
ON INVENTARIO_MENUDEO
FOR EACH ROW
BEGIN ATOMIC
INSERT INTO REGISTRO_INVENTARIO (TIPO_ACCION)
VALUES ('INSERT');
END;
