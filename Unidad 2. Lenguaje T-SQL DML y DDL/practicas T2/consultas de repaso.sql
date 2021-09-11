SELECT
    1. Muestra el Nombre y Teléfono de mis pacientes

    SELECT strNombre,strTelefono
    FROM tblPacientes;

	
    2. Mostrar dos columnas: Nombre y Residencia (que tendrá la siguiente sintaxis: C/ Sol, 23 (Alicante)), compuesta por la dirección más la Ciudad del Paciente. El título de la 2ª columna deberá aparecer como Residencia.

    3. Mostrar aquellos Pacientes que no tienen Teléfono o no son de Alicante

    4. Crear una tabla llamada CopiaPacientesAlicante para los Pacientes de Alicante que han realizado alguna Visita (los pacientes que han hecho una visita, sólo deben aparecer una vez)


    5. Mostrar el 25% de las visitas realizadas por Pacientes de Alicante en el último semestre del año.

CONSULTAS DE AGRUPAR
    6. Importe total gastado en Visitas por Pacientes que no son de Alicante

Importe total gastado en Visitas por cada paciente de los que no son de Alicante.
    7. Cuantas visitas se han realizado cada mes

    8. Muestra los pacientes que se han gastado más de 50 € en visitas

    9. Mostrar la siguiente información: Año, Nombre, Media, Suma; para aquellas visitas no se han realizado en agosto y la media esta comprendida entre 50 y 100 €

CONSULTAS DE MANIPULACIÓN DE DATOS

INSERT INTO "nombre_tabla" ("columna1", "columna2", ...)VALUES ("valor1", "valor2", ...);

INSERT INTO "tabla1" ("columna1", "columna2", ...) SELECT "columna3", "columna4", ... FROM "tabla2";
INSERT
    10. Suponer que existe una tabla llamada ResumenPacientes, con la siguiente estructura NOMBRE, AÑO, TOTALGASTADO. A continuación, añadir la suma de lo gastado por los pacientes en el año 2018.


UPDATE "nombre_tabla"
SET "columna_1" = [nuevo valor]
WHERE "condición";
UPDATE

DELETE FROM "nombre_tabla"
WHERE "condición";
DELETE
    11. Para hacer este ejercicio, crear una copia de la tabla Pacientes mediante SQL llamada CopiaPacientes, y a continuación borra de CopiaPacientes aquellos pacientes que tengan una G en su nombre.
CREATE TABLE NOMBRETABLA AS (SELECT )