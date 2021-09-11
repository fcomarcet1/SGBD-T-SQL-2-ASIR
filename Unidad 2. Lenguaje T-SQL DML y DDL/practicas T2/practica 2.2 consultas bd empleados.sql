--2.1. Obtener los apellidos de los empleados 

    select apellidos 
    from empleados;

--2.2. Obtener los apellidos de los empleados sin repeticiones.

	select distict apellidos
	from empleados;

--2.3. Obtener todos los datos de los empleados que se apellidan ’López’.

    SELECT * FROM empleados
    WHERE apellido like 'Lopez';

--2.4. Obtener todos los datos de los empleados que se apellidan ’López’ y los que se
--apellidan ’Pérez’.

    SELECT * FROM empleados
    WHERE apellido = 'Lopez' AND apellido = 'Perez';


    SELECT *
    FROM departamentos
    WHERE apellido IN ('Lopez','Perez');

--2.5. Obtener todos los datos de los empleados que trabajan para el departamento 14.

    SELECT * FROM empleados
    WHERE departamento = 14;    

--2.6. Obtener todos los datos de los empleados que trabajan para el departamento 37 y
--para el departamento 77.

    SELECT * FROM empleados
    WHERE departamento = 37 AND departamento = 77;

    SELECT *
    FROM empleados
    WHERE departamento IN (37,77);

--2.7. Obtener todos los datos de los empleados cuyo apellido comience por ’P’.

    SELECT * FROM empleados
    WHERE apellido like 'p%'

--2.8. Obtener el presupuesto total de todos los departamentos.

    SELECT SUM(presumuesto) 
    FROM departamentos

--2.9. Obtener el número de empleados en cada departamento.

    SELECT departamento,COUNT(*)
    FROM empleados
    GROUP BY departamento;


--2.10. Obtener un listado completo de empleados, incluyendo por cada empleado los
--datos del empleado y de su departamento.

    SELECT *
    FROM empleados 
    INNER JOIN departamentos
    ON e.departamento = d.codigo;
    

--2.11. Obtener un listado completo de empleados, incluyendo el nombre y apellidos del
--empleado junto al nombre y presupuesto de su departamento.

    SELECT e.nombre, e.apellidos, d.nombre, d.presupuesto
    FROM empleados
    INNER JOIN departamentos
    ON e.departamento = d.codigo;

--2.12. Obtener los nombres y apellidos de los empleados que trabajen en
--departamentos cuyo presupuesto sea mayor de 60.000 €.

    SELECT e.nombre, e.apellido
    FROM empleados
    INNER JOIN departamentos
    ON e.departamento = d.codigo
    WHERE presupuesto > 60000;

--2.13. Obtener los datos de los departamentos cuyo presupuesto es superior al
--presupuesto medio de todos los departamentos.

    SELECT * 
    FROM departamentos
    WHERE presupuesto >
                        (
                        SELECT AVG(presupuesto)
                        FROM departamentos
                        )



--2.15. Añadir un nuevo departamento: ‘Calidad’, con presupuesto de 40.000 € y código 11.
--Añadir un empleado vinculado al departamento recién creado: Esther Vázquez,DNI: 89267109.

    INSERT INTO departamentos
    VALUES ('Calidad', 40000, 11)

    INSERT INTO empleados
    VALUES ('Esther', 'Vazquez',' 89267109' )

--2.16. Aplicar un recorte presupuestario del 10% a todos los departamentos.

    UPDATE departamentos
    SET presupuesto = presupuesto * 0.9


--2.17. Reasignar a los empleados del departamento de investigación (código 77) al departamento de informática (código 14).

    UPDATE departamentos
    SET codigo = 14
    WHERE codigo = 77 

--2.18. Despedir a todos los empleados que trabajan para el departamento de informática (código 14).

    DELETE FROM empleados
    WHERE departamento  = 14

--2.19. Despedir a todos los empleados que trabajen para departamentos cuyo presupuesto sea superior a los 60.000 €.

    DELETE FROM empleados 
    WHERE presupuesto IN
                        (
                            SELECT presupuesto 
                            FROM departamentos
                            WHERE presupuesto < 60000
                        )   

--2.20. Despedir a todos los empleados

    DELETE FROM empleados