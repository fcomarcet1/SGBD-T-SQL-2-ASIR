 

BEGIN TRANSACTION Update1turno
    UPDATE tblpacientes
    SET intTurno = 4
    WHERE btdiabetico = 1 AND intTurno= 3
IF(@@error <> 0) /*Existe error*/
    BEGIN
        ROLLBACK TRANSACTION update1turno
        PRINT 'Error no se actualizo el sistema'
    END        
ELSE /*No existe error*/
    BEGIN 
        COMMIT TRANSACTION update1turno
        print 'Se actulizo el registro correctamente'
    END

GO

BEGIN TRANSACTION insertarVisitas
    INSERT INTO tblvisitas (intCodigoPaciente, dtmFecha, strEnfermedad , intImporte)
    SELECT intCodigoPaciente, GETDATE(),strEnfermedad as revision_medica, intImporte=50
    FROM tblpacientes
    INNER JOIN tblvisitas on intCodigopaciente = intCodigo
    WHERE intTurno = 3
 IF(@@error <> 0) /*Existe error*/
    BEGIN
        ROLLBACK TRANSACTION insertarVisitas
        PRINT 'Error no se insertaron los datos'
    END        
ELSE /*No existe error*/
    BEGIN 
        COMMIT TRANSACTION insertarVisitas
        print 'Se insertaron los datos correctamente'
    END 

GO
BEGIN TRANSACTION Update2Turno
    UPDATE tblpacientes
    SET intTurno = 1
    WHERE intTurno = 3
IF(@@error <> 0) /*Existe error*/
    BEGIN
        ROLLBACK TRANSACTION insertarVisitas
        PRINT 'Error no se actualizaron los datos'
    END        
ELSE /*No existe error*/
    BEGIN 
        COMMIT TRANSACTION insertarVisitas
        print 'Se actualizaron los datos correctamente'
    END     




GO
BEGIN TRANSACTION actualizarTurno40años
    UPDATE tblpacientes
    SET intTurno = 5
    WHERE YEAR(dtmFechanac)<1979
IF(@@error <> 0) /*Existe error*/
    BEGIN
        ROLLBACK TRANSACTION actualizarTurno40años
        PRINT 'Error no se actualizaron los datos'
    END        
ELSE /*No existe error*/
    BEGIN 
        COMMIT TRANSACTION actualizarTurno40años
        print 'Se actualizaron los datos correctamente'
    END     

GO


DECLARE @dtmFechanac DATE,
        @Npacientes1 int,
        @Npacientes2 int

BEGIN TRANSACTION Npacientes1

/*En esta variable almacenamos el nº de pacientes con +50 años nos devuelte un valor entero */
SET @Npacientes1 =(SELECT COUNT(*) FROM tblpacientes WHERE YEAR(dtmFechanac)<1969)
                  
     IF(@@error <> 0) /*Existe error*/
         BEGIN
            ROLLBACK TRANSACTION Npacientes1
            PRINT 'Error en la variable @Npacientes1'
        END        
    ELSE /*No existe error*/
        BEGIN 
            COMMIT TRANSACTION Npacientes1
        END     
 GO              
BEGIN TRANSACTION Npacientes2

/*En esta variable almacenamos el nº de pacientes con +60 años */
SET @Npacientes2 =(SELECT COUNT(*) FROM tblpacientes WHERE YEAR(dtmFechanac)<1959)

    IF(@@error <> 0) /*Existe error*/
         BEGIN
            ROLLBACK TRANSACTION Npacientes2
            PRINT 'Error en la variable @Npacientes2'
        END        
    ELSE /*No existe error*/
        BEGIN 
            COMMIT TRANSACTION Npacientes2
        END     
GO
BEGIN TRANSACTION actualizacionimporte
IF(@Npacientes1 > 4)
    BEGIN 
        UPDATE TOP(3) tblvisitas
        SET intImporte = intImporte * 1.20
        IF(@@error <> 0) /*Existe error*/
            BEGIN
                ROLLBACK TRANSACTION actualizacionimporte
                PRINT 'Error en la actualizacion del importe'
            END        
        ELSE /*No existe error*/
             BEGIN 
                COMMIT TRANSACTION actualizacionimporte
            END     
         END
ELSE IF(@Npacientes2 > 4)
    BEGIN
        IF(@@error <> 0) /*Existe error*/
            BEGIN
                ROLLBACK TRANSACTION actualizacionimporte
                PRINT 'Error '
            END        
        ELSE /*No existe error*/
            BEGIN 
                COMMIT TRANSACTION actualizacionimporte
                PRINT'Pacientes con +60 años no se actualizo nada'
            END                
    END
GO


BEGIN TRANSACTION CreacionTabla

CREATE TABLE PeliculasMasVistas 
    (
        Codigo INT PRIMARY KEY IDENTITY(1,1),
        Titulo NVARCHAR(40),
        Categoria NVARCHAR(20),
        NumAlquileres INT,
        PrecioAlquiler MONEY
    )
    IF(@@error <> 0) /*Existe error*/
        BEGIN
            ROLLBACK TRANSACTION CreacionTabla
            PRINT 'Error no se creo la nueva tabla'
        END        
    ELSE /*No existe error*/
        BEGIN 
            COMMIT TRANSACTION actualizarTurno40años
            print 'Se creo la nueva tabla correctamente'
        END     
GO


 


BEGIN TRANSACTION insercionPeliculas
    INSERT INTO tblpeliculas (strTitulo)
    VALUES('Casablanca'),('Rambo2')
    IF(@@error <> 0) /*Existe error*/
        BEGIN
            ROLLBACK TRANSACTION insercionPeliculas
            PRINT 'Error al insertar la pelicula'
        END        
    ELSE /*No existe error*/
        BEGIN 
            COMMIT TRANSACTION insercionPeliculas
            print 'Peliculas insertadas con exito'
        END     
GO


BEGIN TRANSACTION actualizarPrecio
UPDATE tblpeliculas
SET mnyPrecioalquiler = mnyPrecioalquiler * 0.95
WHERE intCodigocategoria IN (select top 1 intCodigocategoria, count(*) as Ntotalcategoria 
                            from tblpeliculas
                            group by intCodigocategoria
                            order by Ntotalcategoria desc

                            )
IF(@@error <> 0) /*Existe error*/
        BEGIN
            ROLLBACK TRANSACTION actualizarPrecio
            PRINT 'Error al actualizar precios'
        END        
    ELSE /*No existe error*/
        BEGIN 
            COMMIT TRANSACTION actualizarPrecio
            print 'Precio actualizado con exito'
        END     
GO                           




BEGIN TRANSACTION insert5peliculasmasvistas

INSERT INTO  PeliculasMasVistas (Codigo, Titulo, Categoria,PrecioAlquiler)
select top 5  p.intCodigo, p.strTitulo,p.intCodigocategoria,p.mnyPrecioalquiler
from tblalqulier a
inner join tblstock s  on a.intCodigostock = s.intCodigo
inner join tblpeliculas p on s.intCodigopelicula = p.intCodigo
group by  p.intCodigo, p.strTitulo,p.intCodigocategoria, p.mnyPrecioalquiler
order by numAlquileres
IF(@@error <> 0) /*Existe error*/
        BEGIN
            ROLLBACK TRANSACTION insert5peliculasmasvistas
            PRINT 'Error al insertar la pelicula'
        END        
    ELSE /*No existe error*/
        BEGIN 
            COMMIT TRANSACTION insert5peliculasmasvistas
            print 'Peliculas insertadas con exito'
        END     
GO




--e) Actualizar para las 5 películas más vistas el número máximo de días a 2.*/

BEGIN TRANSACTION actualizar5peliculasmasvistas
UPDATE tblpeliculas
SET intMaximodias = intMaximodias + 2
WHERE intCodigocategoria IN (select top 1 intCodigocategoria, count(*) as Ntotalcategoria 
                            from tblpeliculas
                            group by intCodigocategoria
                            order by Ntotalcategoria desc

                            )
IF(@@error <> 0) /*Existe error*/
        BEGIN
            ROLLBACK TRANSACTION actualizarPrecio
            PRINT 'Error al actualizar precios'
        END        
    ELSE /*No existe error*/
        BEGIN 
            COMMIT TRANSACTION actualizarPrecio
            print 'Precio actualizado con exito'
        END     
GO                           