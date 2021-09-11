-- procedimento

/*SELECT codpaciente
FROM visitas 
WHERE codpaciente = 30004
GROUP by codpaciente
HAVING COUNT(*)>3
*/
-- Create the stored procedure in the specified schema
CREATE PROCEDURE visitas
    @codpaciente  int 
    
AS
   DECLARE  @contador int,
            @max int, 
            @enfermedad nvarchar(10),
            @importe int

    SELECT @contador = min(numvisita) from visitas WHERE codpaciente = @codpaciente
    SELECT @max =max(numvisita) from visitas WHERE codpaciente = @codpaciente

    WHILE(@contador <= @max)
        begin 
            if (EXISTS(SELECT * FROM visitas 
                        WHERE numvisita =@codpaciente 
                        AND codpaciente = @contador))
                BEGIN 
                    SELECT enfermedad = @enfermedad, importe = @importe 
                    FROM visitas
                    WHERE numvisita = @contador 
                        IF(@enfermedad like 'gripe')
                            BEGIN
                                SET @importe = @importe *1.2
                            END
                        ELSE IF(@enfermedad like 'ulcera')
                            BEGIN
                                SET @importe = @importe *1.4
                            END
                        PRINT cast(@contador as nvarchar(5))+'    '+ @enfermedad
                        +'       '+cast(@importe as nvarchar(6))       
                END
        SET @contador =@contador+1
        END
GO
-- example to execute the stored procedure we just created
EXECUTE visitas @codpaciente
GO


--SCRIPT

DECLARE @contador INT,
        @max INT,
        @codpaciente INT

SELECT @contador = min(codigo) from pacientes
SELECT @max = max(codigo) from pacientes

PRINT 'CODIGO--------------------- NOMBRE-----------------VISITAS'
WHILE(@contador <= @max)
    BEGIN
        IF(EXISTS(SELECT v.codpaciente FROM pacientes p 
                    INNER JOIN visitas v on codpaciente = codigo
                    WHERE v.codpaciente = @contador 
                    GROUP BY v.codpaciente 
                    HAVING COUNT(*) > 3))

            BEGIN 
                SELECT @nombre = nombre from paciente WHERE codigo = @contador
                EXECUTE visitas
            END      
                   
    END