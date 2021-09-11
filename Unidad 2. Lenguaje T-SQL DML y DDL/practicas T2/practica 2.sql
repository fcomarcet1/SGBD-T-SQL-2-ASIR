CREATE DATABASE [tienda informatica]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'tienda informatica', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\tienda informatica.mdf' , SIZE = 8192KB , FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'tienda informatica_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\tienda informatica_log.ldf' , SIZE = 8192KB , FILEGROWTH = 65536KB )
GO
USE [tienda informatica]
GO
IF NOT EXISTS (SELECT name FROM sys.filegroups WHERE is_default=1 AND name = N'PRIMARY') ALTER DATABASE [tienda informatica] MODIFY FILEGROUP [PRIMARY] DEFAULT
GO

--CREATE TABLE (Transact-SQL) IDENTITY (propiedad)

--Crea una columna de identidad en una tabla. Esta propiedad se usa con 
--las instrucciones CREATE TABLE y ALTER TABLE de Transact-SQL.
--Las columnas de identidad pueden usarse para generar valores de clave. La propiedad de identidad de una columna garantiza lo siguiente:
--Cada nuevo valor se genera basándose en el valor actual de inicialización e incremento.
--Cada nuevo valor de una transacción determinada es diferente de otras transacciones simultáneas de la tabla.
--La propiedad de identidad de una columna no garantiza lo siguiente:

--Uniqueness of the value (Unicidad del valor): La unicidad debe aplicarse mediante una restricción PRIMARY KEY o UNIQUE,
-- o mediante un índice UNIQUE.

--Consecutive values within a transaction (Valores consecutivos en una transacción): No se garantiza que una transacción que inserta varias filas obtenga valores consecutivos para las filas porque podrían producirse otras inserciones simultáneas en la tabla. Si los valores deben ser consecutivos, la transacción debe usar 
--un bloqueo exclusivo en la tabla o usar el nivel de aislamiento SERIALIZABLE

CREATE TABLE tblFabricantes
(
    intCodigo int IDENTITY NOT NULL, 
    strNombre NVARCHAR(100),

     PRIMARY KEY (intCodigo)

);

CREATE TABLE tblArticulos
(
    intCodigo INT IDENTITY NOT NULL, 
    strNombre NVARCHAR(100),
    intPrecio INT,
    intFabricante INT,

     PRIMARY KEY (intCodigo)
);


ALTER TABLE tblArticulos
ADD CONSTRAINT fk_articulosFabricantes
FOREIGN KEY (intFabricante) REFERENCES tblFabricantes (intCodigo);



--1.1. Obtener los nombres de los productos de la tienda.

SELECT strNombre FROM tblArticulos;


--1.2. Obtener los nombres y los precios de los productos de la tienda.

SELECT strNombre, intPrecio FROM tblArticulos;

--1.3. Obtener el nombre de los productos cuyo precio sea menor o igual a 200 €.

SELECT strNombre FROM tblArticulos
WHERE intPrecio <= 200;


--1.4. Obtener todos los datos de los artículos cuyo precio esté entre los 60€ y los 120 €
--(ambas cantidades incluidas).

SELECT * FROM tblArticulos
WHERE intPrecio BETWEEN 60 AND 120;

SELECT * FROM tblArticulos
WHERE intPrecio >= 60 AND intPrecio <= 120;

--1.5. Obtener el nombre y el precio en pesetas (es decir, el precio en euros multiplicado
--por 166’386)

SELECT strNombre, intPrecio *166.386 AS PrecioEnPesetas 
FROM tblArticulos;


--1.6. Seleccionar el precio medio de todos los productos.

SELECT AVG(intPrecio) FROM tblArticulos

--1.7. Obtener el precio medio de los artículos cuyo código de fabricante sea 2.

SELECT AVG(intPrecio) FROM tblArticulos
WHERE intCodigo = 2;

--1.8. Obtener el número de artículos cuyo precio sea mayor o igual a 180 €.

SELECT COUNT(*) FROM tblArticulos
WHERE intPrecio >= 180;

--1.9. Obtener el nombre y precio de los artículos cuyo precio sea mayor o igual a 180 y
--ordenarlos descendentemente por precio, y luego ascendentemente por nombre.

SELECT strNombre, intPrecio FROM tblArticulos
WHERE intPrecio >= 180
ORDER BY intPrecio DESC ,strNombre;

--1.10. Obtener un listado completo de artículos, incluyendo por cada artículo los datos
--del articulo y de su fabricante.

--Consulta multitabla
--1ºForma
SELECT * FROM tblArticulos, tblFabricantes
WHERE intFabricante = intCodigo;

--2ºForma
SELECT * FROM tblArticulos, tblFabricantes
WHERE tblarticulos.intFabricante = tblFabricantes.intCodigo;

--3ºForma

SELECT * FROM tblArticulos
INNER JOIN tblFabricantes
ON intFabricante = intCodigo;


SELECT * FROM tblArticulos
INNER JOIN tblFabricantes
ON tblArticulos.intFabricante = tblFabricantes.intCodigo;


--1.11. Obtener un listado de artículos, incluyendo el nombre del artículo, su precio, y el
--nombre de su fabricante.
--a-> tblArticulos  f->tblFabricantes
SELECT a.strnombre ,a.precio ,f.strNombre  
FROM tblArticulos
INNER JOIN tblFabricantes
ON a.intFabricante = f.strCodigo;

--1.12. Obtener el precio medio de los productos de cada fabricante, mostrando solo los
--códigos de fabricante.

SELECT AVG(intPrecio),intFabricante
FROM tblArticulos
GROUP BY intFabricante;


--1.13. Obtener el precio medio de los productos de cada fabricante, mostrando el
--nombre del fabricante.

SELECT AVG(intPrecio),tblFabricantes.strNombre
FROM tblArticulos
INNER JOIN tblFabricantes
ON tblArticulos.intFabricante = tblFabricantes.intCodigo
GROUP By tblFabricantes.strNombre

--1.14. Obtener los nombres de los fabricantes que ofrezcan productos cuyo precio
--medio sea mayor o igual a 150€.

SELECT AVG(intPrecio),tblFabricantes.strNombre
FROM tblArticulos
INNER JOIN tblFabricantes
ON tblArticulos.intFabricante = tblFabricantes.intCodigo
GROUP BY tblFabricantes.strNombre
HAVING AVG(intPrecio) >= 150;


1.15. Obtener el nombre y precio del artículo más barato.


1.16. Obtener una lista con el nombre y precio de los artículos más caros de cada
proveedor (incluyendo el nombre del proveedor).


--1.17. Anadir un nuevo producto: Altavoces de 70 € (del fabricante 2)

INSERT INTO tblArticulos (strNombre ,intPrecio ,intFabricante)
VALUES ('Altavoces',70,2);

--1.18. Cambiar el nombre del producto 8 a ’Impresora Laser’

UPDATE tblArticulos
SET strNombre = 'Impresora Laser'
WHERE intCodigo = 8;

--1.19. Aplicar un descuento del 10% (multiplicar el precio por 0’9) a todos los
--productos.

UPDATE tblArticulos
SET intPrecio = IntPrecio * 0.9;

--1.20. Aplicar un descuento de 10 € a todos los productos cuyo precio sea mayor o igual
--a 120 €

UPDATE tblArticulos
SET intPrecio = intPrecio - 10
WHERE intPrecio >= 120;


--2.1. Obtener los apellidos de los empleados 

    select apellidos 
    from empleados;

--2.2. Obtener los apellidos de los empleados sin repeticiones.

	select distict apellidos
	from empleados;

--2.3. Obtener todos los datos de los empleados que se apellidan ’López’.

    SELECT * FROM empleados
    WHERE apellido like 'Lopez';

--2.4. Obtener todos los datos de los empleados que se apellidan ’López’ y los que se
--apellidan ’Pérez’.

    SELECT * FROM empleados
    WHERE apellido = 'Lopez' AND apellido = 'Perez';


    SELECT *
    FROM departamentos
    WHERE apellido IN ('Lopez','Perez');

--2.5. Obtener todos los datos de los empleados que trabajan para el departamento 14.

    SELECT * FROM empleados
    WHERE departamento = 14;    

--2.6. Obtener todos los datos de los empleados que trabajan para el departamento 37 y
--para el departamento 77.

    SELECT * FROM empleados
    WHERE departamento = 37 AND departamento = 77;

    SELECT *
    FROM empleados
    WHERE departamento IN (37,77);

--2.7. Obtener todos los datos de los empleados cuyo apellido comience por ’P’.

    SELECT * FROM empleados
    WHERE apellido like 'p%'

--2.8. Obtener el presupuesto total de todos los departamentos.

    SELECT SUM(presumuesto) 
    FROM departamentos

--2.9. Obtener el número de empleados en cada departamento.

    SELECT departamento,COUNT(*)
    FROM empleados
    GROUP BY departamento;


--2.10. Obtener un listado completo de empleados, incluyendo por cada empleado los
--datos del empleado y de su departamento.

    SELECT *
    FROM empleados 
    INNER JOIN departamentos
    ON e.departamento = d.codigo;
    

--2.11. Obtener un listado completo de empleados, incluyendo el nombre y apellidos del
--empleado junto al nombre y presupuesto de su departamento.

    SELECT e.nombre, e.apellidos, d.nombre, d.presupuesto
    FROM empleados
    INNER JOIN departamentos
    ON e.departamento = d.codigo;

--2.12. Obtener los nombres y apellidos de los empleados que trabajen en
--departamentos cuyo presupuesto sea mayor de 60.000 €.

    SELECT e.nombre, e.apellido
    FROM empleados
    INNER JOIN departamentos
    ON e.departamento = d.codigo
    WHERE presupuesto > 60000;

--2.13. Obtener los datos de los departamentos cuyo presupuesto es superior al
--presupuesto medio de todos los departamentos.

    SELECT * 
    FROM departamentos
    WHERE presupuesto >
                        (
                        SELECT AVG(presupuesto)
                        FROM departamentos
                        )



--2.15. Añadir un nuevo departamento: ‘Calidad’, con presupuesto de 40.000 € y código 11.
--Añadir un empleado vinculado al departamento recién creado: Esther Vázquez,DNI: 89267109.

    INSERT INTO departamentos
    VALUES ('Calidad', 40000, 11)

    INSERT INTO empleados
    VALUES ('Esther', 'Vazquez',' 89267109' )

--2.16. Aplicar un recorte presupuestario del 10% a todos los departamentos.

    UPDATE departamentos
    SET presupuesto = presupuesto * 0.9


--2.17. Reasignar a los empleados del departamento de investigación (código 77) al departamento de informática (código 14).

    UPDATE departamentos
    SET codigo = 14
    WHERE codigo = 77 

--2.18. Despedir a todos los empleados que trabajan para el departamento de informática (código 14).

    DELETE FROM empleados
    WHERE departamento  = 14

--2.19. Despedir a todos los empleados que trabajen para departamentos cuyo presupuesto sea superior a los 60.000 €.

    DELETE FROM empleados 
    WHERE presupuesto IN
                        (
                            SELECT presupuesto 
                            FROM departamentos
                            WHERE presupuesto < 60000
                        )   

--2.20. Despedir a todos los empleados

    DELETE FROM empleados