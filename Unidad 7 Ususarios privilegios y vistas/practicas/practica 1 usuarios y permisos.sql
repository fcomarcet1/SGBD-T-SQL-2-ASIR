/*
EJERCICIO 1.*/

/*
LOGIN:
*/
/*1. Crea un Login inicial que se llame ‘cfgsmz’ a partir de autenticación de SQL Server. 
Investiga cómo crearlo para que al iniciar sesión en él te pida que cambies la contraseña introducida inicialmente.
*/

    CREATE LOGIN cfgsmz 
        WITH PASSWORD = 'abcd'
        MUST_CHANGE,    /*NOTA: La opción MUST_CHANGE no se puede utilizar cuando se ha desactivado CHECK_EXPIRATION.*/ 
        CHECK_EXPIRATION = ON;
GO

/*2. Renombra el Login creado anteriormente a ‘gbdasix’*/

   ALTER LOGIN cfgsmz 
   WITH NAME = gbdasix;

/*3. Deshabilita el Login creado.*/

    ALTER LOGIN cfgsmz DISABLE;

/*4. Vuelve a habilitarlo.*/

    ALTER LOGIN cfgsmz ENABLE;

/*5. Borra el Login e inmediatamente vuelve a crearlo con el nombre ‘gbdasix’.*/

    DROP LOGIN cfgsmz;

    CREATE LOGIN cfgsmz 
    WITH PASSWORD = 'abcd'
    

/*USERS:*/
/*6. Eres el administrador de la Base de Datos, y te piden varios 
departamentos usuarios para acceder a la BD. 
Realiza la siguiente creación de usuarios:*/
/*7. Crea un usuario de tipo administrador, es decir, que tenga permisos para todo y sea el que vayas a usar tú.*/


    CREATE USER mpf_asix FOR LOGIN cfgsmz;

    USE clinica;
    GRANT ALL ON DATABASE::clinica TO mpf_asix;
    USE videoclub;
    GRANT ALL ON DATABASE::videoclub TO mpf_asix;
    USE proyectos;
    GRANT ALL ON DATABASE::proyectos TO mpf_asix;
    USE Servicio_tecnico;
    GRANT ALL ON DATABASE::Servicio_tecnico TO mpf_asix;
    

/*8. Crea un usuario genérico para el departamento de Marketing,
que sólo tenga privilegios para consultar datos en las BD ClinicaDB, Proyectos y Concesionarios.*/

    CREATE LOGIN marketing 
        WITH PASSWORD = 'Usermarketing1';
    CREATE USER user_consulta FOR LOGIN marketing;

    GRANT SELECT ON DATABASE::clinica TO user_consulta;
    GRANT SELECT ON DATABASE::proyectos TO user_consulta;
    GRANT SELECT ON DATABASE::concesionario TO user_consulta;  
GO  
    
/*9. Crea un usuario genérico para el departamento de Ventas, que tenga privilegios
 para consultar, borrar e insertar datos para la BD Proyectos.*/

    CREATE LOGIN ventas 
        WITH PASSWORD = 'Userventas1';
    CREATE USER user_consulta FOR LOGIN ventas;

    GRANT SELECT, DELETE, INSERT ON DATABASE::proyectos TO user_consulta;
      
GO  

/*10. Crea tres usuarios para el departamento de TI que tengan todos los permisos para cualquiera de las tablas de la BD.*/

    CREATE LOGIN TI
        WITH PASSWORD = 'UserTI1';

    CREATE USER user_ti1 FOR LOGIN TI
    GRANT ALL ON DATABASE::concesionario TO user_ti1;

    CREATE USER user_ti2 FOR LOGIN TI
    GRANT ALL ON DATABASE::concesionario TO user_ti2;

    CREATE USER user_ti3 FOR LOGIN TI
    GRANT ALL ON DATABASE::concesionario TO user_ti3;

/*11. A uno de estos tres últimos usuarios, que será para el equipo de desarrollo,
 quítale los permisos de REFERENCES y ALTER.*/

    USE concesionario;  
    REVOKE REFERENCES, ALTER ON DATABASE::concesionario TO user_ti3;  
    GO


/*12. Crea otro usuario que permita solamente acceder a la información de los pacientes 
y ejecutar algún procedimiento de los creados en la Unidad 7 sobre la BD ClinicaBD.*/

    CREATE LOGIN clinica
        WITH PASSWORD = 'User1'
    CREATE USER user_consulta_pacientes FOR LOGIN clinica

    GRANT SELECT ON DATABASE:: clinicaBD TO user_consulta_pacientes;
    USE clinicaBD;   
    GRANT EXECUTE ON OBJECT::dbo.visitaspacientes  TO user_consulta_pacientes;  
GO


/*ROLES:*/
/*13. Investiga para qué sirven los roles en SQL Server, y que roles por defecto existen ya.*/


        /*Los roles son los conjuntos de permisos. Estos conjuntos existen a tres niveles distintos: servidor, base de datos y aplicación.
        Los roles permiten agrupar los derechos y gestionar más fácilmente los diferentes usuarios y las conexiones.
        Siempre es preferible asignar los derechos a los roles y posteriormente asignar los roles a los usuarios.
        Con una estructura como esta, la adición y la modificación de permisos o de usuarios son más sencillas.

        Es posible definir un rol como un conjunto identificado de permisos. 
        Para facilitar la gestión de los permisos, SQL Server ofrece los roles predefinidos, también llamados fijos, 
        ya que no es posible añadir o eliminar privilegios en estos roles.

        Estos roles fijos se definen en dos niveles:

            1-.Servidor.
            2-.Base de datos.

        Además de estos roles fijos, es posible gestionar otros roles. 
        Es conveniente establecer un nombre único para definir un rol y posteriormente asignar uno o varios permisos 
        respetando un procedimiento en todo punto similar al utilizado para asignar los permisos a los usuarios. 
        Estos roles se pueden definir en tres niveles:

            Servidor.
            Base de datos.
            Aplicación.
            
            */


/*14. ¿Qué es el rol ‘public’ y para qué sirve?*/

        /*Es un roll fijo de la base de datos, y tiene una particularidad que es el unico
        el cual se pueden modificar los permisos a diferencia de los demas roles fijos*/

/*15. ¿Qué es la cuenta de usuario dbo y para qué sirve?*/

        /*
        dbo (database owner) es un usuario con permisos implícitos para realizar todas las actividades en la base de datos
        Función que se asigna a un usuario que es propietario de una base de datos. 
        */

/*16. ¿Qué es la cuenta de usuario guest y para qué sirve?*/

        /*
        La cuenta Guest permite iniciar una sesión sin una cuenta de usuario que de acceso a la base de datos. 
        Se pueden añadir y eliminar cuentas de usuario invitado en cualquier base de datos, 
        excepto en las bases Master y Tempdb.
        */

/*17. Crea un rol que se llame ‘rolexecutegbd’ y asígnale los privilegios de
 ejecutar cualquier objeto de la BD y consultar cualquier tabla de la BD.*/

    CREATE ROLE rolexecutegbd 
    GRANT SELECT ON DATABASE ::clinicaBD


/*18. Posteriormente crea dos nuevos usuarios y asígnales este rol.*/

    CREATE LOGIN asix2
        WITH PASSWORD = 'User1'

    CREATE USER frank FOR LOGIN asix2
    EXEC sp_addrolemember 'rolexecutegbd', 'frank'

    CREATE USER antonio FOR LOGIN asix2
    EXEC sp_addrolemember 'rolexecutegbd', 'antonio'
    

/*
EJERCICIO 2. Crea vistas para las siguientes BDs
A) CLINICA BD
1.Realiza una vista que permita mostrar las visitas del día actual. 
Además, también deberá mostrar la información del paciente de la visita. 
Esta vista ayudará a que la gente de administración sepa las visitas del día en el que se encuentran.*/

    CREATE VIEW consultasdiarias
     AS
        SELECT * FROM visitas v
        INNER JOIN pacientes p 
        ON v.CODPACIENTE=p.codigo
        WHERE v.FECHA = CONVERT(varchar(10), getdate(), 120)
        

/*2. Modifica esta vista para que, además, sólo muestre la de los pacientes que no estén allí por una gripe.*/

    ALTER VIEW consultasdiarias
    AS
        SELECT * FROM visitas v
        INNER JOIN pacientes p 
        ON v.codpaciente=p.codigo
        WHERE v.fecha = CONVERT(varchar(10), getdate(), 120)
        AND v.enfermedad <> 'Gripe';

/*3. Borra la vista creada anteriormente.*/

    DROP VIEW consultasdiarias

/*B) VIDEOCLUB
4. Crea una vista que muestre todos los datos de los socios, exceptuando el DNI y la fecha de nacimiento.*/

    CREATE VIEW datos_socios
    AS
        SELECT codigo, nombre, apellido, telefono, clientevip
        FROM socios

/*5. Modifica los datos de la tabla para que el cliente con código 2 (Federico), sea CLIENTEVIP también (1). 
Consulta ahora la vista. ¿Qué sucede? ¿Ha cambiado también el valor en la vista?*/

USE clinica
    UPDATE socios
    SET CLIENTEVIP = 1
    WHERE codigo = 2 
    
    /* 
    Ha cambiado el valor del registro CLIENTEVIP a 1, y por tanto en la vista veremos el 
    valor actualizado a CLIENTEVIP = 1
    */

/*6. Devuelve a su estado anterior (0) el valor modificado.*/

USE clinica
    UPDATE socios
    SET CLIENTEVIP = 0
    WHERE codigo = 2 


/*7. Modifica ahora el mismo campo para Federico, pero esta vez en la vista. ¿Qué sucede? 
¿Permite realizar la modificación de los datos reales a partir de la vista?*/

    UPDATE datos_socios
    SET CLIENTEVIP = 1
    WHERE codigo = 2 

  /*
     Se podra modificar los registros si el usuario posee permisos UPDATE, INSERT o DELETE 
     en la tabla de destino, en función de la acción que realizará
  */  

/*8. Bien, como ya hemos visto, a partir de esta vista hemos podido modificar los valores reales,
ya que la vista no es nada físico, sino simplemente una representación de los valores.
Por tanto, tendréis ahora que crear un usuario, que SÓLO tendrá privilegios para consultar 
la información de esta vista,y de esta manera evitamos que pudiera modificar.*/

 CREATE LOGIN asix2
    WITH PASSWORD = 'User1'
    CREATE USER frank FOR LOGIN asix2
    GRANT SELECT ON OBJECT:: datos_socios TO frank;


/*9. Modifica ahora la vista para que permita ver los datos de socios (Exceptuando su DNI y fecha de nacimiento) 
que hayan alquilado alguna vez alguna película que dure más de 180 minutos).*/

    ALTER VIEW datos_socios
    AS
        SELECT s.codigo, s.nombre, s.apellido, s.telefono, s.clientevip
        FROM socios s
		INNER JOIN alquiler a ON s.codigo = a.CODIGO_SOCIO
		INNER JOIN stock stk ON a.CODIGO_STOCK = stk.CODIGO
		INNER JOIN peliculas p ON stk.CODIGO_PELICULA = p.CODIGO
        WHERE p.duracion >= 180  


/*10. Trata ahora de realizar una modificación de la misma forma sobre CLIENTEVIP. ¿Te ha permitido?*/

    /*
        No se puede efctuar la modificacion ya que el usuario solo tiene privilegios de consulta
        sobre la vista
    */

/*C) PROYECTOS
11. Crea una vista que permita visualizar la información de solamente los empleados 
que trabajan en el departamento de DIR.*/

    CREATE VIEW empleados_deptDIR
    AS
        SELECT e.intCodempleado, e.strNombreem, e.strApellidoem, e.mnySueldo,
                e.strNombredp, e.strCiudaddp, e.strNumpro
        FROM tblempleados e
        WHERE e.strNombredp LIKE 'DIR'

    GO  

/*12. Tendrás que crear un usuario genérico para que este departamento consulte la información en esta vista. 
Además, tendrán permiso también para insertar y modificar datos sobre la propia vista.*/

    CREATE LOGIN proyectos
        WITH PASSWORD = 'User1proyectos'
        CREATE USER us01proyectos FOR LOGIN proyectos
        GRANT SELECT, INSERT, UPDATE ON empleados_deptDIR TO us01proyectos;

/*13. Borra la vista creada anteriormente.*/

    DROP VIEW empleados_deptDIR


