/*Ejercicio 1
Crear un script para la base de datos clínica, que utilice un cursor que recorra todos los pacientes
que no son de Alicante. Dicho cursor deberá obtener el código del paciente, el nombre y el
importe total de la suma de todas las visitas que ha realizado dicho paciente.
Además, el cursor deberá llamar a un procedimiento almacenado llamado NumVisitas, 
el cual recibirá como parámetro el código del paciente y devolverá el 
número total de visitas que ha realizado dicho paciente.
Una vez haya obtenido el cursor el número de visitas y los datos correspondientes del paciente
imprimirá por pantalla, la siguiente información:
Código: xx
Nombre: xxxx
Suma: xxxxxx(importeTotal)
Tipo: XXXXXXX
----------------------------------------------------------------------------
Para saber el tipo, tendremos que consultar el valor devuelto por el procedimiento NumVisitas,
que será el siguiente: Si el paciente tiene más de 1 visita, el tipo mostrado será “BUENO”, en otro
caso, no mostrará nada, en blanco.*/

--PROCEDURE
GO
IF OBJECT_ID ('dbo.Numvisitas') IS NOT NULL  
    DROP PROCEDURE dbo.Numvisitas;  
GO
CREATE PROCEDURE NumVisitas
    @codigo int,
    @Nvisitas int OUTPUT
AS
SET NOCOUNT ON
    SELECT @Nvisitas = COUNT(*)
    FROM visitas
    WHERE codpaciente = @codigo
RETURN

/*EXECUTE Numvisitas @codigo,@Nvisitas OUTPUT
PRINT CAST(@Nvisitas as nvarchar(20))*/


--Consulta
---------------------------------------------------------
SELECT p.codigo, p.nombre, SUM(v.importe) AS [Importe Total]
FROM pacientes p
INNER JOIN visitas v ON v.codpaciente = p.codigo
WHERE p.ciudad NOT LIKE 'ALICANTE'
GROUP BY p.codigo, p.nombre

--CURSOR
-----------------------------------------------------------
DECLARE @codigo INT,
        @nombre NVARCHAR(30),
        @importeTotal INT 

DECLARE PacientesNoAlicante CURSOR
FOR
    SELECT p.codigo, p.nombre, SUM(v.importe) 
    FROM pacientes p
    INNER JOIN visitas v ON v.codpaciente = p.codigo
    WHERE p.ciudad NOT LIKE 'ALICANTE'
    GROUP BY p.codigo, p.nombre

OPEN PacientesNoAlicante 
FETCH PacientesNoAlicante INTO @codigo, @nombre, @importeTotal 
WHILE(@@FETCH_STATUS = 0)
    BEGIN 
        DECLARE @Nvisitas int
        EXEC Numvisitas @codigo, @Nvisitas OUTPUT
        PRINT 'CODIGO:' + cast(@codigo as nvarchar(10))
        PRINT 'NOMBRE:' + @nombre
        PRINT 'SUMA:' + cast(@importeTotal as nvarchar(10))+'(Importe Total)'
        IF(@Nvisitas > 1)
            BEGIN 
                PRINT 'TIPO:BUENO'
                PRINT '------------------------------------------------------'
                PRINT space(10)
            END
        ELSE 
            BEGIN 
                PRINT 'TIPO:'
                PRINT '------------------------------------------------------'
                PRINT space(10)         
            END
        FETCH PacientesNoAlicante INTO @codigo, @nombre, @importeTotal 
    END
CLOSE PacientesNoAlicante
DEALLOCATE PacientesNoAlicante 

/*Ejercicio 2
Crear un script para la base de datos clínica, que utilice un cursor que recorra todos los pacientes
que son de Alicante. 
Para cada paciente, el cursor anterior utilizará otro cursor para visualizar
todas las visitas de dicho paciente. Éste último cursor, deberá obtener el código del paciente del
primer cursor y obtendrá la fecha y el importe cada visita que ha realizado dicho paciente.
Además, el cursor primero deberá llamar a un procedimiento almacenado llamado GastoMedio,
el cual recibirá como parámetro el código del paciente y devolverá 
la media del gasto total de todas las visitas que ha realizado dicho paciente.
Una vez haya obtenido mediante los cursores el cursor el número de visitas y los datos
correspondientes del paciente imprimirá por pantalla, la siguiente información:
Código: xx
Nombre: xxxx
Tipo: Diabetico
        Fecha Visita 1 :
        Enfermedad:
        Importe:
        Fecha Visita 2 :
        Enfermedad:
        Importe:
Gasto Total: xxx
Gasto Medio: xxxx

Código: xx
Nombre: xxxx
Tipo: NO Diabetico
        Fecha Visita 1 :
        Enfermedad:
        Importe:
        Fecha Visita 2 :
        Enfermedad:
        Importe:
Gasto Total: xxx
Gasto Medio: xxxx
----------------------------------------------------------------------------
Si el paciente es diabético, deberá aparecer el mensaje correspondiente.
*/
--PROCEDURE
---------------------------------------------------------------------------
GO
IF OBJECT_ID ('dbo.GastoMedio') IS NOT NULL  
    DROP PROCEDURE dbo.GastoMedio;  
GO
CREATE PROCEDURE GastoMedio
    @codigo INT,
    @gastomedio INT OUTPUT
AS
SET NOCOUNT ON
    SELECT  @gastomedio = AVG(importe)
    FROM visitas
    WHERE codpaciente = @codigo
    GROUP BY codpaciente
RETURN
GO

--EXECUTE GastoMedio @codigo,@gastomedio OUTPUT
--PRINT cast(cast @gastomedio as nvarchar(20))
-----------------------------------------------------------------------------

--CURSOR

DECLARE @codigo INT,
        @nombre NVARCHAR(20),
        @gastoTotal INT,
        @tipo BIT
		
DECLARE PacientesAlicante CURSOR
FOR
    SELECT p.codigo, p.nombre, p.diabetico, SUM(v.importe) 
    FROM pacientes p
    INNER JOIN visitas v ON v.codpaciente = p.codigo
    WHERE p.ciudad  LIKE 'ALICANTE'
    GROUP BY p.codigo, p.nombre, p.diabetico

OPEN PacientesAlicante
FETCH PacientesAlicante INTO @codigo, @nombre, @tipo, @gastoTotal
WHILE(@@FETCH_STATUS = 0)
    BEGIN
        DECLARE @gastomedio int 
        EXECUTE GastoMedio @codigo,@gastomedio OUTPUT
		PRINT 'Código:' + cast(@codigo as nvarchar(20))        
		PRINT 'Nombre:' + @nombre
        IF(@tipo = 1)
            BEGIN 
			    PRINT 'DIABETICO'
            END
         ELSE
			BEGIN
			    PRINT 'NO DIABETICO'
             END
             --2º cursor
		        DECLARE @fecha date,
					    @enfermedad nvarchar(25), 
					    @importe int,
					    @contador int,
					    @codpaciente int

                SET @contador = 0
				SET @codpaciente = @codigo
				DECLARE PacientesVisitas CURSOR
				FOR
					SELECT fecha, enfermedad, importe
					FROM visitas
					where CODPACIENTE = @codpaciente

				OPEN PacientesVisitas
				FETCH PacientesVisitas INTO @fecha, @enfermedad, @importe
				WHILE(@@FETCH_STATUS = 0)
				    BEGIN  
						PRINT space(7)+'Fecha Visita:'+cast(@contador as nvarchar(3))+ cast(@fecha as nvarchar(15))
						PRINT space(7)+'Enfermedad:' + @enfermedad
						PRINT space(7)+'Importe:' + cast(@importe as nvarchar(15))
						PRINT space(10)
						FETCH PacientesVisitas INTO @fecha, @enfermedad, @importe
						SET @contador = @contador + 1 
				    END
				CLOSE PacientesVisitas
				DEALLOCATE PacientesVisitas  

PRINT 'Gasto Total:' + cast(@gastoTotal as nvarchar(20))
PRINT 'Gasto medio:' + cast(@gastomedio as nvarchar(20))
PRINT SPACE(10)
PRINT '-------------------------------------------------------------------'
PRINT '-------------------------------------------------------------------'
FETCH PacientesAlicante INTO @codigo, @nombre, @tipo, @gastoTotal
    END
CLOSE PacientesAlicante
DEALLOCATE PacientesAlicante

/*Ejercicio 3
Para una base de datos llamada SERVICIO TÉCNICO.
TÉCNICOS(Dni, Nombre, Ciudad, salario)
REPARACIONES(Id, Fecha, Dni_Tecnico, Concepto, Importe)
Crear un cursor que recorra la siguiente consulta:
NOMBRE DEL TÉCNICO, CIUDAD, NUM_REPARACIONES
Para cada línea del cursor se debe realizar:
     Si el número de reparaciones del técnico es >5 debe:
        1. Imprimir el mensaje de: TÉCNICO EXCELENTE
        2. Aumentar el Salario del técnico en un 20%.
     Ejecutar un Procedimiento Almacenado, donde le pasaremos la Ciudad y nos devuelva la Media del Importe de las reparaciones correspondientes a esa Ciudad.
     Si la media devuelta por el procedimiento almacenado es menor que el Salario, debe realizar lo siguiente:
        1. - Insertar en la tabla TÉCNICOS_DEL_AÑO(que suponemos que existe), el Nombre del técnico, la Media, el Salario y la fecha en la que se realiza la inserción
    
 Mostrar por pantalla:
TÉCNICO: XXXXXXXXXXXX(Nombre)
SALARIO: XXXXX
MEDIA DEL IMPORTE: XXXX (Media devuelta por el procedimiento)*/

--Script creacion tablas e insercion de datos en DB SERVICIO TECNICO

USE [SERVICIO TECNICO]
GO
/****** Object:  Table [dbo].[REPARACIONES]    Script Date: 16/12/2019 18:08:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[REPARACIONES](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[dni_tecnico] [nvarchar](25) NULL,
	[fecha] [date] NULL,
	[concepto] [nvarchar](25) NULL,
	[importe] [money] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TECNICOS]    Script Date: 16/12/2019 18:08:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TECNICOS](
	[dni] [nvarchar](25) NOT NULL,
	[nombre] [nvarchar](25) NULL,
	[ciudad] [nvarchar](15) NULL,
	[salario] [money] NULL,
PRIMARY KEY CLUSTERED 
(
	[dni] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TECNICOS_DEL_AÑO]    Script Date: 16/12/2019 18:08:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TECNICOS_DEL_AÑO](
	[nombre] [nvarchar](25) NOT NULL,
	[media] [money] NULL,
	[salario] [money] NULL,
	[fecha] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[REPARACIONES] ON 

INSERT [dbo].[REPARACIONES] ([Id], [dni_tecnico], [fecha], [concepto], [importe]) VALUES (1, N'48330190Z', CAST(N'2019-12-31' AS Date), N'cambio ruedas', 500.0000)
INSERT [dbo].[REPARACIONES] ([Id], [dni_tecnico], [fecha], [concepto], [importe]) VALUES (2, N'79456123H', CAST(N'2018-06-25' AS Date), N'cambio aceite', 600.0000)
INSERT [dbo].[REPARACIONES] ([Id], [dni_tecnico], [fecha], [concepto], [importe]) VALUES (3, N'98654321Y', CAST(N'2019-11-03' AS Date), N'cambio pastillas freno', 250.0000)
INSERT [dbo].[REPARACIONES] ([Id], [dni_tecnico], [fecha], [concepto], [importe]) VALUES (4, N'48330190Z', CAST(N'2019-11-30' AS Date), N'cambio pastillas freno', 350.0000)
INSERT [dbo].[REPARACIONES] ([Id], [dni_tecnico], [fecha], [concepto], [importe]) VALUES (5, N'48330190Z', CAST(N'2018-06-15' AS Date), N'cambio luna', 450.0000)
INSERT [dbo].[REPARACIONES] ([Id], [dni_tecnico], [fecha], [concepto], [importe]) VALUES (6, N'79456123H', CAST(N'2019-05-04' AS Date), N'cambio motor', 9000.0000)
INSERT [dbo].[REPARACIONES] ([Id], [dni_tecnico], [fecha], [concepto], [importe]) VALUES (7, N'41258963G', CAST(N'2019-06-04' AS Date), N'equilibrado ruedas', 150.0000)
INSERT [dbo].[REPARACIONES] ([Id], [dni_tecnico], [fecha], [concepto], [importe]) VALUES (8, N'98654321Y', CAST(N'2018-06-04' AS Date), N'cambio asientos', 3000.0000)
INSERT [dbo].[REPARACIONES] ([Id], [dni_tecnico], [fecha], [concepto], [importe]) VALUES (9, N'36587741E', CAST(N'2018-01-15' AS Date), N'cambio ruedas', 500.0000)
INSERT [dbo].[REPARACIONES] ([Id], [dni_tecnico], [fecha], [concepto], [importe]) VALUES (10, N'35478994S', CAST(N'2019-08-04' AS Date), N'cambio aceite', 780.0000)
INSERT [dbo].[REPARACIONES] ([Id], [dni_tecnico], [fecha], [concepto], [importe]) VALUES (11, N'98654321Y', CAST(N'2018-03-15' AS Date), N'cambio luna', 850.0000)
INSERT [dbo].[REPARACIONES] ([Id], [dni_tecnico], [fecha], [concepto], [importe]) VALUES (12, N'13456789L', CAST(N'2018-09-15' AS Date), N'cambio ruedas', 900.0000)
INSERT [dbo].[REPARACIONES] ([Id], [dni_tecnico], [fecha], [concepto], [importe]) VALUES (13, N'41258963G', CAST(N'2019-01-25' AS Date), N'cambio motor', 8500.0000)
INSERT [dbo].[REPARACIONES] ([Id], [dni_tecnico], [fecha], [concepto], [importe]) VALUES (14, N'79456123H', CAST(N'2018-06-04' AS Date), N'equilibrado ruedas', 750.0000)
INSERT [dbo].[REPARACIONES] ([Id], [dni_tecnico], [fecha], [concepto], [importe]) VALUES (15, N'48330190Z', CAST(N'2018-05-04' AS Date), N'reparacion pinchazo', 100.0000)
INSERT [dbo].[REPARACIONES] ([Id], [dni_tecnico], [fecha], [concepto], [importe]) VALUES (16, N'48330190Z', CAST(N'2017-05-04' AS Date), N'cambio bateria', 80.0000)
INSERT [dbo].[REPARACIONES] ([Id], [dni_tecnico], [fecha], [concepto], [importe]) VALUES (17, N'48330190Z', CAST(N'2017-12-04' AS Date), N'equilibrado neumaticos', 250.0000)
INSERT [dbo].[REPARACIONES] ([Id], [dni_tecnico], [fecha], [concepto], [importe]) VALUES (18, N'48330190Z', CAST(N'2018-10-15' AS Date), N'cambio bateria', 80.0000)
INSERT [dbo].[REPARACIONES] ([Id], [dni_tecnico], [fecha], [concepto], [importe]) VALUES (19, N'48330190Z', CAST(N'2018-06-27' AS Date), N'cambio llantas', 300.0000)
SET IDENTITY_INSERT [dbo].[REPARACIONES] OFF
INSERT [dbo].[TECNICOS] ([dni], [nombre], [ciudad], [salario]) VALUES (N'13456789L', N'felix', N'campello', 789.0000)
INSERT [dbo].[TECNICOS] ([dni], [nombre], [ciudad], [salario]) VALUES (N'21458792A', N'pepe', N'campello', 800.0000)
INSERT [dbo].[TECNICOS] ([dni], [nombre], [ciudad], [salario]) VALUES (N'35478994S', N'jose', N'villajoyosa', 750.0000)
INSERT [dbo].[TECNICOS] ([dni], [nombre], [ciudad], [salario]) VALUES (N'36587741E', N'maria', N'benidorm', 980.0000)
INSERT [dbo].[TECNICOS] ([dni], [nombre], [ciudad], [salario]) VALUES (N'41258963G', N'luis', N'alicante', 1000.0000)
INSERT [dbo].[TECNICOS] ([dni], [nombre], [ciudad], [salario]) VALUES (N'48330190Z', N'frank', N'villajoyosa', 1000.0000)
INSERT [dbo].[TECNICOS] ([dni], [nombre], [ciudad], [salario]) VALUES (N'79456123H', N'mateo', N'villajoyosa', 1100.0000)
INSERT [dbo].[TECNICOS] ([dni], [nombre], [ciudad], [salario]) VALUES (N'98654321Y', N'alberto', N'altea', 450.0000)
ALTER TABLE [dbo].[REPARACIONES]  WITH CHECK ADD  CONSTRAINT [fk_reparacionestecnicos] FOREIGN KEY([dni_tecnico])
REFERENCES [dbo].[TECNICOS] ([dni])
GO
ALTER TABLE [dbo].[REPARACIONES] CHECK CONSTRAINT [fk_reparacionestecnicos]
GO

--PROCEDURE

GO
IF OBJECT_ID ('dbo.ImporteMedioReparaciones') IS NOT NULL  
    DROP PROCEDURE dbo.ImporteMedioReparaciones;  
GO
CREATE PROCEDURE ImporteMedioReparaciones

        @ciudad nvarchar(25),
        @importemedio int OUTPUT
AS
SET NOCOUNT ON
    SELECT  @importemedio = AVG(r.importe)
    FROM reparaciones r
    INNER join tecnicos t on r.dni_tecnico = t.dni
    WHERE ciudad = @ciudad
RETURN
GO


--EXECUTE ImporteMedioReparaciones @ciudad, @importemedio OUTPUT
--PRINT @importemedio

--cursor 
DECLARE @nombre NVARCHAR(30),
        @ciudad NVARCHAR(30),
        @Numreparaciones INT,
        @salario int,
		@dni nvarchar(25)

DECLARE ReparacionesSalario CURSOR
FOR
    select t.dni, t.nombre, t.ciudad, t.salario, count(*) 
    from tecnicos t
	inner join reparaciones r on r.dni_tecnico= t.dni
    group by t.dni,t.nombre, t.ciudad, t.salario 

OPEN ReparacionesSalario
FETCH ReparacionesSalario INTO @dni, @nombre, @ciudad, @salario, @Numreparaciones
WHILE(@@FETCH_STATUS = 0)
    BEGIN 
	set nocount on
    DECLARE @importemedio int   
    EXECUTE ImporteMedioReparaciones @ciudad, @importemedio OUTPUT
    IF(@importemedio < @salario)
        BEGIN 
            INSERT INTO TECNICOS_DEL_AÑO (nombre, media, salario, fecha)
            VALUES (@nombre, @importemedio, @salario, getdate())
        END
	PRINT 'Nº Reparaciones:'+ cast(@Numreparaciones as nvarchar(10))
    IF(@Numreparaciones > 5)
        BEGIN 
            PRINT 'TECNICO EXCELENTE'
            SET @salario = @salario * 1.20 
        END
    PRINT 'TECNICO:'+@nombre
    PRINT 'SALARIO:'+cast(@salario as nvarchar(20))
    PRINT 'IMPORTE:'+cast(@importemedio as nvarchar(20))
	--print space(7)
	print '-----------------------------------------------------------------'
	print '-----------------------------------------------------------------'
	FETCH ReparacionesSalario INTO @dni, @nombre, @ciudad, @salario, @Numreparaciones
    END
CLOSE ReparacionesSalario
DEALLOCATE ReparacionesSalario        

--select * from tecnicos_del_año     
       






