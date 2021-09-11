/* Procedimeinto almacenado que devuelva un parametro de salida
Numero de Pacientes cuyo turno le pasamos como parametro de entrada*/

/*PARAMETROS
SALIDA-> Npacientes
Entrada -> Turno 
*/

/*PROCEDIMIENTO*/
-- Create the stored procedure in the specified schema
CREATE PROCEDURE Turnopacientes @npacientes smallint output, @turno int 

AS
    -- body of the stored procedure
    SELECT  @npacientes = COUNT(*) AS Turno_paciente 
    FROM pacientes 
    WHERE turno=@turno 
GO

/*SCRIPT */
DECLARE @turnop int,
        @npacientes SMALLINT

-- example to execute the stored procedure we just created
EXECUTE Turnopacientes @turnop, @npacientes output 

PRINT cast(@npacientes AS nvarchar(6))
GO


/*Devolver un parametro de salida: Gasto total de un paciente,
 cuyo codigo de paciente le pasamos como parametro de entrada
 
 */

--PARAMETROS
--Entrada-> Codigo de paciente
--Salida-> Gasto Total


--PROCEDIMENTO


-- Create the stored procedure in the specified schema
CREATE PROCEDURE GastoPaciente @codigoPaciente int,  @gastototal money OUTPUT
   
AS
    -- body of the stored procedure
    SELECT @gastototal = SUM(importe)
    FROM visitas
    WHERE codigoPaciente = @codigoPaciente
GO

DECLARE  @codigoPaciente int, @gasto money
-- example to execute the stored procedure we just created
EXECUTE  GastoPaciente @codigoPaciente,@gasto OUTPUT

PRINT cast(@gasto as nvarchar)

--SCRIPT
