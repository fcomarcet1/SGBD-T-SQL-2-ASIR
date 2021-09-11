--FUNCIÓN REPASO CLASE
-- Primero declaramos las variables
DECLARE @contador INT,
        @max INT,
        @nombre NVARCHAR(25),
        @isvip BIT 

SELECT @contador = MIN(CODIGO), @max = MAX(CODIGO) FROM socios

PRINT 'CÓDIGO SOCIO    -    NOMBRE SOCIO    -    CLIENTE VIP'

WHILE (@contador <= @max)
    BEGIN
        IF(EXISTS(SELECT * FROM socios WHERE CODIGO = @contador))
            BEGIN
                SELECT @nombre = nombre, @isvip = CLIENTEVIP 
                FROM socios WHERE CODIGO = @contador

                SET @titulo = MINCALIFICAC(@contador,'VHS')--llamada a la funcion
                    IF (@ISVIP = 1)
                        BEGIN
                            PRINT CAST(@contador AS NVARCHAR(6)) + SPACE(9) + @nombre 
                            + SPACE(9) + 'SI'
                        END
                    ELSE
                        BEGIN
                            PRINT CAST(@contador AS NVARCHAR(6)) + SPACE(9) + @nombre 
                            + SPACE(9) + 'NO'
                        END
                PRINT CAST(@contador AS NVARCHAR(6)) + SPACE(7) 
                + @nombre
            END
        SET @contador = @contador + 1
    END

--PRIMERO VER COMO ESTAN ORGANIZADAS LAS TABLAS ALQUILER, PELICULAS Y STOCK
--OBTENER LA PELICULA CON MENOS CALIFICACIÓN POR CADA SOCIO



CREATE FUNCTION MINCALIFICA   (@CODIGOSOCIO INT, @CODIGOSTOCK INT)
RETURNS  NVARCHAR(40)
AS
BEGIN

    DECLARE @titulo NVARCHAR(40), @CALIFICA INT
    SELECT TOP 1 @CALIFICA=CALIFICACION, @titulo=P.TITULO 
    FROM ALQUILER A 
    INNER JOIN STOCK ST ON ST.CODIGO=A.CODIGO_STOCK     
    INNER JOIN PELICULAS P ON P.CODIGO=ST.CODIGO_PELICULA
    WHERE CODIGO_SOCIO=@CODIGOSOCIO AND FORMATO=@CODIGOSTOCK
    ORDER BY CALIFICACION ASC

    RETURN @titulo
END
