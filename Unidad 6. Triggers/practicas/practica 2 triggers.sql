/*Ejercicio 1
Crea la tabla PACIENTES_DIABETICOS, que siga la misma estructura que pacientes, pero sin la columna DIABETICO.
Realiza una copia de todos los pacientes diabéticos de la tabla PACIENTES a la tabla PACIENTES_DIABETICOS


Crea un trigger para que cada vez que se inserte un nuevo Paciente diabético se 
añada a la tabla PACIENTES_DIABETICOS.
Además, si se realiza un borrado o modificación sobre la propia tabla PACIENTES, 
también se deberá de comprobar que se modifica en la tabla PACIENTES_DIABÉTICOS.
*/

USE clinica
GO
CREATE TABLE PACIENTES_DIABETICOS
(
    codigo SMALLINT PRIMARY KEY NOT NULL,
    nombre NVARCHAR(30) ,
    direccion NVARCHAR(20) ,
    ciudad NVARCHAR(15) NULL,
    telefono NVARCHAR(10) ,
    fechanac DATE ,
    turno SMALLINT ,
    tarifa DECIMAL(8, 2)
)
GO
INSERT INTO PACIENTES_DIABETICOS
    (codigo ,nombre, direccion ,ciudad,telefono ,fechanac ,turno ,tarifa)
SELECT codigo , nombre, direccion , ciudad, telefono , fechanac , turno , tarifa
FROM PACIENTES
WHERE diabetico = 1

--El trigger se ejecutara cada vez que se ejecute un insert(DML), por tanto -> TRIGGER DML

CREATE TRIGGER TR_PacientesDiabeticos 
ON pacientes 
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    DECLARE @codigo SMALLINT,
                    @nombre NVARCHAR(30) ,
                    @direccion NVARCHAR(20),
                    @ciudad NVARCHAR(15),
                    @telefono NVARCHAR(10),
                    @fechanac DATE,
                    @turno SMALLINT,
                    @tarifa DECIMAL(8,2),
					@diabetico bit,
					@operacion varchar(3)

    IF EXISTS(SELECT * FROM inserted where diabetico = 1 ) AND EXISTS (SELECT * FROM deleted where diabetico = 1)--upd
        BEGIN
        SELECT @codigo=codigo , @nombre=nombre, @direccion=direccion , @ciudad=ciudad,
            @telefono=telefono , @fechanac=fechanac , @turno=turno , @tarifa=tarifa
        FROM inserted

        print 'DATOS MODIFICADOS SON:'+@nombre+space(3)+@direccion+
            space(3)+@ciudad+space(3)+cast(@telefono as nvarchar(20))+space(3)+
            cast(@fecha as nvarchar(20))+space(3)+cast(@turno as nvarchar(20))+space(3)
            +cast(@tarifa as nvarchar(20))
    END
    IF (EXISTS(SELECT * FROM inserted where diabetico = 1) AND NOT EXISTS(SELECT * FROM deleted where diabetico = 1))--INSERT
        BEGIN
        SELECT @codigo=codigo , @nombre=nombre, @direccion=direccion , @ciudad=ciudad,
            @telefono=telefono , @fechanac=fechanac , @turno=turno , @tarifa=tarifa
        FROM inserted

        INSERT INTO PACIENTES_DIABETICOS
            (codigo, nombre, direccion, ciudad, telefono, fechanac, turno, tarifa)
        VALUES(@codigo, @nombre, @direccion, @ciudad, @telefono, @fechanac, @turno, @tarifa)
    END
    IF EXISTS(SELECT *FROM deleted where diabetico = 1) AND NOT EXISTS(SELECT * FROM inserted where diabetico = 1)--DELETE   
            BEGIN
        SELECT @codigo=codigo, @nombre=nombre, @direccion=direccion , @ciudad=ciudad,
            @telefono=telefono , @fechanac=fechanac , @turno=turno , @tarifa=tarifa
        FROM deleted
        print 'DATOS ELIMINADOS SON:'+@nombre+space(3)+@direccion+
                        space(3)+@ciudad+space(3)+cast(@telefono as nvarchar(20))+space(3)+
                        cast(@fecha as nvarchar(20))+space(3)+cast(@turno as nvarchar(20))+space(3)
                        +cast(@tarifa as nvarchar(20))
            END                                  
    ELSE
        BEGIN
        print 'El paciente no es diabetico ,no se almaceno el registro en la tabla PACIENTES_DIABETICOS'
    END
END
/*
INSERT INTO PACIENTES
    (codigo, nombre, direccion, ciudad, telefono,diabetico,fechanac, turno, tarifa)
VALUES(200, 'Pepe', 'abaaa', 'shshs', '5555555', 1, '1900-08-10', 4, 100)

update pacientes 
set nombre = 'Maria  Tuent'
where codigo = 30004

delete from pacientes
where codigo = 200


select *
from pacientes
select *
from PACIENTES_DIABETICOS
*/

/*Ejercicio 2
Crea la tabla HISTORICO_VISITAS en la cual almacenes las visitas de los pacientes que se den de baja en la tabla PACIENTES. 
Esta tabla tendrá los siguientes campos:
a. NVISITA, CODIGO_PACIENTE, FECHA, ENFERMEDAD, IMPORTE, PORCENTAJE, FECHA_BAJA_PACIENTE
Como puedes observar, todos los campos excepto el último serán valores que debas copiar antes de borrar de la tabla VISITAS
para el paciente dado de baja. 
El campo FECHA_BAJA_PACIENTE almacenará la fecha en la que se dio de baja el paciente de la BD.
*/
CREATE TABLE HISTORICO_VISITAS
(
    NVISITA INT ,
    CODIGO_PACIENTE INT PRIMARY KEY,
    FECHA DATETIME,
    ENFERMEDAD NVARCHAR(25) ,
    IMPORTE INT,
    PORCENTAJE INT,
    FECHA_BAJA_PACIENTE DATETIME
)

/*
Dado que hay varios datos solicitados y no se encuentran en la trabla asociada al trigger->pacientes, vamos a implementar
un procedimiento almacenado(SP), que funcionara de la siguiente forma:

    -Dado un codigo de paciente como parametro de entrada que lo obtendrá de la tabla deleted
    -Y como parametros de salida OUTPUT tendremos Nvisita, enfermedad, importe, porcentaje
*/
CREATE PROCEDURE SP_NvisitasAndEnfermedadAnd

	@codigo SMALLINT,
	@Nvisitas INT OUTPUT,
	@enfermedad NVARCHAR(25) OUTPUT,
	@importe INT OUTPUT,
	@porcentaje SMALLINT OUTPUT
AS
	SELECT @Nvisitas = numvisita, @enfermedad=enfermedad, 
			@importe=importe,@porcentaje=porcentajepago
	FROM visitas
	WHERE @codigo = codpaciente

/*
DECLARE @Nvisitas INT, @enfermedad NVARCHAR(20),@importe INT,@porcentaje SMALLINT
EXECUTE SP_NvisitasAndEnfermedad @codigo, @Nvisitas output, @enfermedad output, @importe output, @porcentaje output   
*/

/************************************************************************************
**************************************************************************************/

CREATE TRIGGER TR_BajaVisitasPacientes
ON pacientes
AFTER DELETE
AS
    BEGIN
	SET NOCOUNT ON;
        DECLARE @Nvisitas INT,
                @codigo INT,
                @fecha DATETIME,
                @enfermedad NVARCHAR(25),
                @importe INT,
                @porcentaje INT,
                @fechabaja DATETIME

        SET @fechabaja = GETDATE()
        SELECT  @codigo = codigo, @fecha=fechanac  
        FROM deleted
        --Llamada al SP
        EXECUTE SP_NvisitasAndEnfermedad @codigo, @Nvisitas output, @enfermedad output,
                                                  @importe output, @porcentaje output

        INSERT INTO HISTORICO_VISITAS
              (Nvisita, codigo_paciente, fecha, enfermedad, importe, porcentaje, fecha_baja_paciente)
        VALUES( @Nvisitas, @codigo, @fecha, @enfermedad, @importe, @porcentaje, @fechabaja)
    END

									
--select * from pacientes

/*delete from pacientes
where codigo =30014*/

--select * from historico_visitas



/*
Ejercicio 3
Crear primero la tabla PELÍCULAS_PERDIDAS (codigo, Nombre, Fecha_Baja).
Crea trigger que cuando se añada una película a PELÍCULA _PERDIDAS, la de baja de la tabla películas, 
la elimine de la tabla ALQUILERES, previamente insertando todos los registros donde aparecía dicha película 
en la tabla alquileres en la tabla HISTORICO_ ALQUILERES, que tiene la misma estructura que la tabla alquileres.
*/

CREATE TABLE PELÍCULAS_PERDIDAS
(
    codigo INT PRIMARY KEY, 
    Nombre NVARCHAR(25), 
    Fecha_Baja DATETIME
)

CREATE TABLE Historico_Alquileres
(
    CODIGO_SOCIO INT,
    CODIGO_STOCK INT,
    FECHA_SALIDA DATETIME,
    FECHA_DEVOLUCION DATETIME,
    ESTADO SMALLINT,
    CALIFICACION SMALLINT
)

CREATE TRIGGER TR_InsertPeliculasPerdidas
ON PELÍCULAS_PERDIDAS
AFTER INSERT
AS
    BEGIN 

	  DECLARE @CODIGO_SOCIO INT,
                @CODIGO_STOCK INT,
                @FECHA_SALIDA DATETIME,
                @FECHA_DEVOLUCION DATETIME,
                @ESTADO SMALLINT,
                @CALIFICACION SMALLINT,
				@codigo int



    SELECT @CODIGO_SOCIO = CODIGO_SOCIO, @CODIGO_STOCK=CODIGO_STOCK, @FECHA_SALIDA= FECHA_SALIDA,
            @FECHA_DEVOLUCION = FECHA_DEVOLUCION, @ESTADO = ESTADO, @CALIFICACION= CALIFICACION
    FROM ALQUILER

    INSERT INTO Historico_Alquileres 
            (CODIGO_SOCIO, CODIGO_STOCK, FECHA_SALIDA, FECHA_DEVOLUCION, ESTADO, CALIFICACION)
    VALUES  (@CODIGO_SOCIO,@CODIGO_STOCK,@FECHA_SALIDA,@FECHA_DEVOLUCION,@ESTADO,@CALIFICACION)      

	set @codigo=@CODIGO_SOCIO 


    DELETE FROM peliculas where CODIGO =@CODIGO_SOCIO      
    
    END

insert into peliculas_perdidas 
(codigo, nombre, fecha_baja)
values(2, 'El padrino',getdate())


/*
Ejercicio 4
Crea un trigger, que cuando demos de baja un Socio, compruebe si dicho socio tiene algúna película en su casa
(es decir, la fecha de devolución será nula), y si es así que añada un registro a 
la tabla PELÍCULAS _PERDIDAS (codigo, Nombre, Fecha_Baja),
la fecha de baja será la fecha del sistema en el momento que se de baja el socio.

b)Realiza un trigger para impedir que el usuario pueda modificar una columna de una tabla
*/

CREATE TABLE PELÍCULAS_PERDIDAS 
(   
    codigo INT PRIMARY KEY,
    Titulo NVARCHAR(25),
    Fecha_Baja DATETIME,
)    
/*
Vamos a tener que implementar un SP para obtener dado un codsocio selecione la pelicula (codigopelicula,Nombre, fechabaja)
*/

CREATE PROCEDURE SP_PeliculasSindevolucion

	@codigosocio SMALLINT,
	@codpelicula NVARCHAR(25) OUTPUT,
	@titulo NVARCHAR(25) OUTPUT,
AS
	SELECT @codigopelicula = codigo, @titulo=titulo, 		
	FROM peliculas
	WHERE @codigo = codpaciente

CREATE TRIGGER TR_BajaSocio
ON socios
AFTER DELETE
AS
    BEGIN
    SET NOCOUNT ON
    DECLARE @codigo int, 
			@fechadev datetime,
			@fechabaja datetime,
			@codsocio INT,
			@codigopelicula int,
			@titulo nvarchar(25)

    SET @fechabaja = GETDATE()        
    SELECT @codsocio= codigo FROM deleted
    
    SELECT @fechadev=FECHA_DEVOLUCION 
    FROM alquiler
    WHERE codigo = @codigosocio 
    
    IF EXISTS(SELECT * FROM deleted where @fechadev is null) 
        AND NOT EXISTS(SELECT * FROM inserted where @fechadev is null)--DELETE   
            BEGIN
                select @codigopelicula = p.codigo, @titulo=p.titulo
                from peliculas p
                inner join stock stk on stk.codigo_pelicula=p.codigo
                inner join alquiler a on a.codigo_socio=stk.codigo
                where a.codigo_socio = @codsocio

                INSERT INTO PELÍCULAS_PERDIDAS 
                      (codigo,titulo,fecha_baja)
                VALUES(@codigopelicula, @titulo, @fechabaja)
        
            END    
    
    END


    b)
    ALTER TABLE nombreTabla DROP COLUMN nombreColumna
    
    
    CREATE TRIGGER TR_NODELETEROW
    ON DATABASE
    FOR ALTER_TABLE
    AS
        BEGIN 
        RAISERROR ('No se pudo modificar la tabla ')
        
        END

