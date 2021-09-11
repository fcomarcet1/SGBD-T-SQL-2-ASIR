/*
EJERCICIO 1.
Crear un script en transactSQL que muestre lo siguiente:
Pacientes que han visitado 4 o más veces la clínica:
(Todos los datos de los pacientes)
Pacientes que han visitado 3 o más veces la clínica:
(Todos los datos de los pacientes)
Pacientes que han visitado 2 o más veces la clínica:
(Todos los datos de los pacientes)
*/

--CONSULTAS PARA OBTENER PACIENTES CON N VISITAS.
--Pacientes que han visitado 4 o más veces la clínica

SELECT p.intCodigo, p.strNombre, p.strDireccion, p.strCiudad, p.btDiabetico, p.dtmFechanac, p.intTurno, count(*) as Nvisitas
FROM tblpacientes p
INNER JOIN tblvisitas v ON p.intCodigo = v.intCodigopaciente
group by p.intCodigo, p.strNombre, p.strDireccion,p.strCiudad ,p.btDiabetico,p.dtmFechanac,p.intTurno 
having count(*)>=4


--Pacientes que han visitado 3 o más veces la clínica

SELECT p.intCodigo,p.strNombre, p.strDireccion, p.strCiudad, p.btDiabetico, p.dtmFechanac, p.intTurno, count(*) as Nvisitas
FROM tblpacientes p
INNER JOIN tblvisitas v ON p.intCodigo = v.intCodigopaciente
group by p.intCodigo,p.strNombre, p.strDireccion,p.strCiudad ,p.btDiabetico,p.dtmFechanac,p.intTurno 
having count(*)>=3

--Pacientes que han visitado 2 o más veces la clínica

SELECT p.intCodigo,p.strNombre, p.strDireccion, p.strCiudad, p.btDiabetico, p.dtmFechanac, p.intTurno, count(*) as Nvisitas
FROM tblpacientes p
INNER JOIN tblvisitas v ON p.intCodigo = v.intCodigopaciente
group by p.intCodigo,p.strNombre, p.strDireccion,p.strCiudad ,p.btDiabetico,p.dtmFechanac,p.intTurno 
having count(*)>=2


/*SCRIPT Pacientes que han visitado 4 o más veces la clínica:
(Todos los datos de los pacientes) 
*/

/*DECLARACION DE VARIABLES*/

BEGIN TRY
DECLARE @strNombre NVARCHAR(30),
        @strDireccion NVARCHAR(20),
        @strCiudad NVARCHAR(15),
        @btDiabetico BIT,
        @dtmFechanac DATETIME,
        @intTurno SMALLINT,
        @contador INT
       

create table #tmptable
(
	codigo int,
	nombre nvarchar(20),
	direccion nvarchar(30),
	ciudad nvarchar(30),
	diabetico bit,
	fechanac date,
	Nvisitas int,
	turno int	 
)

insert into #tmptable 
SELECT p.intCodigo, p.strNombre, p.strDireccion, p.strCiudad,
p.btDiabetico, p.dtmFechanac,count(*) as Nvisitas, p.intTurno 
FROM tblpacientes p
INNER JOIN tblvisitas v ON p.intCodigo = v.intCodigopaciente
group by p.intCodigo, p.strNombre, p.strDireccion,p.strCiudad ,p.btDiabetico,p.dtmFechanac,p.intTurno 
having count(*)>=3

declare @contador int
select @contador=(select count(*) from #tmptable)
PRINT 'CODIGO - NOMBRE - DIRECCION - CIUDAD - DIABETICO - FECHA_NACIMIEMNTO - TURNO'
while(@contador > 0)
	begin 
		declare @codigo int = (select top (1) codigo from #tmptable) ,
				@nombre nvarchar(20) = (select top (1) nombre from #tmptable) ,
				@direccion nvarchar(30)= (select top (1) direccion from #tmptable) ,
				@ciudad nvarchar(30) = (select top (1) ciudad from #tmptable) ,
				@diabetico bit = (select top (1) diabetico from #tmptable) ,
				@fechanac datetime = (select top (1) fechanac from #tmptable) ,
				@Nvisitas int = (select top (1) Nvisitas from #tmptable) ,
				@turno int = (select top (1) turno from #tmptable) 

				print cast(@codigo as nvarchar(6)) +'    ' + @nombre + '   ' + @direccion
				+ '   ' + @ciudad + '   ' +cast(@diabetico as nvarchar(1)) + '   ' +cast(@fechanac as nvarchar(20)) 
                + '   ' +cast(@Nvisitas as nvarchar(1)) + cast(@turno as nvarchar(1)) 

				delete top(1) from #tmptable
				select @contador = count(*) from #tmptable
	end
	
drop table if exists #tmptable
END TRY

BEGIN CATCH 
    SELECT   
        ERROR_NUMBER() AS ErrorNumber,  
        ERROR_SEVERITY() AS ErrorSeverity,  
        ERROR_STATE() AS ErrorState,  
        ERROR_PROCEDURE() AS ErrorProcedure, 
        ERROR_LINE() AS ErrorLine,  
        ERROR_MESSAGE() AS ErrorMessage;  
  
    IF @@TRANCOUNT > 0  
        ROLLBACK TRANSACTION;  
END CATCH;  
  
IF @@TRANCOUNT > 0  
    COMMIT TRANSACTION;  
GO


/*SCRIPT Pacientes que han visitado 3 o más veces la clínica:
(Todos los datos de los pacientes) 
*/

/*DECLARACION DE VARIABLES*/
BEGIN TRY
DECLARE @strNombre NVARCHAR(30),
        @strDireccion NVARCHAR(20),
        @strCiudad NVARCHAR(15),
        @btDiabetico BIT,
        @dtmFechanac DATETIME,
        @intTurno SMALLINT,
        @contador INT
       

create table #tmptable
(
	codigo int,
	nombre nvarchar(20),
	direccion nvarchar(30),
	ciudad nvarchar(30),
	diabetico bit,
	fechanac date,
	Nvisitas int,
	turno int	 
)

insert into #tmptable 
SELECT p.intCodigo, p.strNombre, p.strDireccion, p.strCiudad,
p.btDiabetico, p.dtmFechanac,count(*) as Nvisitas, p.intTurno 
FROM tblpacientes p
INNER JOIN tblvisitas v ON p.intCodigo = v.intCodigopaciente
group by p.intCodigo, p.strNombre, p.strDireccion,p.strCiudad ,p.btDiabetico,p.dtmFechanac,p.intTurno 
having count(*)>=3

declare @contador int
select @contador=(select count(*) from #tmptable)
PRINT 'CODIGO - NOMBRE - DIRECCION - CIUDAD - DIABETICO - FECHA_NACIMIEMNTO - TURNO'
while(@contador > 0)
	begin 
		declare @codigo int = (select top (1) codigo from #tmptable) ,
				@nombre nvarchar(20) = (select top (1) nombre from #tmptable) ,
				@direccion nvarchar(30)= (select top (1) direccion from #tmptable) ,
				@ciudad nvarchar(30) = (select top (1) ciudad from #tmptable) ,
				@diabetico bit = (select top (1) diabetico from #tmptable) ,
				@fechanac datetime = (select top (1) fechanac from #tmptable) ,
				@Nvisitas int = (select top (1) Nvisitas from #tmptable) ,
				@turno int = (select top (1) turno from #tmptable) 

				print cast(@codigo as nvarchar(6)) +'    ' + @nombre + '   ' + @direccion
				+ '   ' + @ciudad + '   ' +cast(@diabetico as nvarchar(1)) + '   ' +cast(@fechanac as nvarchar(20)) + '   ' +cast(@Nvisitas as nvarchar(1))
				+ cast(@turno as nvarchar(1)) 

				delete top(1) from #tmptable
				select @contador = count(*) from #tmptable
	end
	
drop table if exists #tmptable
END TRY

BEGIN CATCH 
    SELECT   
        ERROR_NUMBER() AS ErrorNumber,  
        ERROR_SEVERITY() AS ErrorSeverity,  
        ERROR_STATE() AS ErrorState,  
        ERROR_PROCEDURE() AS ErrorProcedure, 
        ERROR_LINE() AS ErrorLine,  
        ERROR_MESSAGE() AS ErrorMessage;  
  
    IF @@TRANCOUNT > 0  
        ROLLBACK TRANSACTION;  
END CATCH;  
  
IF @@TRANCOUNT > 0  
    COMMIT TRANSACTION;  
GO




/*SCRIPT Pacientes que han visitado 2 o más veces la clínica:
(Todos los datos de los pacientes) 
*/

/*DECLARACION DE VARIABLES*/
BEGIN TRY
DECLARE @strNombre NVARCHAR(30),
        @strDireccion NVARCHAR(20),
        @strCiudad NVARCHAR(15),
        @btDiabetico BIT,
        @dtmFechanac DATETIME,
        @intTurno SMALLINT,
        @contador INT
       

create table #tmptable
(
	codigo int,
	nombre nvarchar(20),
	direccion nvarchar(30),
	ciudad nvarchar(30),
	diabetico bit,
	fechanac date,
	Nvisitas int,
	turno int	 
)

insert into #tmptable 
SELECT p.intCodigo, p.strNombre, p.strDireccion, p.strCiudad,
p.btDiabetico, p.dtmFechanac,count(*) as Nvisitas, p.intTurno 
FROM tblpacientes p
INNER JOIN tblvisitas v ON p.intCodigo = v.intCodigopaciente
group by p.intCodigo, p.strNombre, p.strDireccion,p.strCiudad ,p.btDiabetico,p.dtmFechanac,p.intTurno 
having count(*)>=2

declare @contador int
select @contador=(select count(*) from #tmptable)
PRINT 'CODIGO - NOMBRE - DIRECCION - CIUDAD - DIABETICO - FECHA_NACIMIEMNTO - TURNO'
while(@contador > 0)
	begin 
		declare @codigo int = (select top (1) codigo from #tmptable) ,
				@nombre nvarchar(20) = (select top (1) nombre from #tmptable) ,
				@direccion nvarchar(30)= (select top (1) direccion from #tmptable) ,
				@ciudad nvarchar(30) = (select top (1) ciudad from #tmptable) ,
				@diabetico bit = (select top (1) diabetico from #tmptable) ,
				@fechanac datetime = (select top (1) fechanac from #tmptable) ,
				@Nvisitas int = (select top (1) Nvisitas from #tmptable) ,
				@turno int = (select top (1) turno from #tmptable) 

				print cast(@codigo as nvarchar(6)) +'    ' + @nombre + '   ' + @direccion
				+ '   ' + @ciudad + '   ' +cast(@diabetico as nvarchar(1)) + '   ' +cast(@fechanac as nvarchar(20)) + '   ' +cast(@Nvisitas as nvarchar(1))
				+ cast(@turno as nvarchar(1)) 

				delete top(1) from #tmptable
				select @contador = count(*) from #tmptable
	end
	
drop table if exists #tmptable
END TRY

BEGIN CATCH 
    SELECT   
        ERROR_NUMBER() AS ErrorNumber,  
        ERROR_SEVERITY() AS ErrorSeverity,  
        ERROR_STATE() AS ErrorState,  
        ERROR_PROCEDURE() AS ErrorProcedure, 
        ERROR_LINE() AS ErrorLine,  
        ERROR_MESSAGE() AS ErrorMessage;  
  
    IF @@TRANCOUNT > 0  
        ROLLBACK TRANSACTION;  
END CATCH;  
  
IF @@TRANCOUNT > 0  
    COMMIT TRANSACTION;  
GO

/*EJERCICIO 2*/

--El ejercicio 2 no lo he hecho ya tu comentaste que no lo hicieramos dado que no teniamos la base de datos del ejercicio ni las 
--tablas asociadas a esta 