/*
De manera similar a la función escalar que has creado anteriormente, 
crear una función en línea que muestre el nombre del paciente y el
 importe de todas las visitas con y sin IVA para el paciente número 2.
*/

CREATE FUNCTION CalcularImporteMasImpuestos 
( @codP smallint) -- Lista de parámetros
RETURNS TABLE
AS
RETURN 
    (
    select P.NOMBRE,sum(importe) AS [IMPORTE TOTAL],
    sum(importe)*1.21 AS [TOTAL CON IVA] 
    from visitas as V 
    INNER JOIN PACIENTES as P ON P.CODIGO=V.CODIGO 
    where [Codigo Paciente]=@codP
    GROUP BY NOMBRE 
    )
 
/* *************** script PRINCIPAL  ***************************************** */

declare @codPac smallint
set @codPac=2

select * from CalcularImporteMasImpuestos(@codPac)

 

