/*Ejercicio 1
Crear una función escalar para la base de datos clínica, que calcule el importe total con IVA de
cada una de las visitas del paciente código 30006.*/

CREATE FUNCTION ImporteTotalIVA
    (@codpaciente smallint)

returns decimal(6,2)
as 
    BEGIN 
        declare @importe decimal(6,2)
        SELECT @importe = sum(importe)*1.21
        from visitas
        where codpaciente = @codpaciente

        return @importe
    END


/*Ejercicio 2
Utiliza la función en líneas que has creado anteriormente en un script para mostrar el nombre
del paciente y el importe de todas las visitas con y sin IVA para el paciente número 30002.*/

declare @contador int,
        @max int, 
        @codpaciente smallint,
        @importetotaliva decimal(6,2),
        @importetotal int

select @contador =min(codigo), @max=max(codigo) from pacientes
where codigo = @codpaciente

print 'NOMBRE---------IMPORTE TOTAL-------IMPORTE TOTAL+IVA'

WHILE(@contador <= @max)
    BEGIN 
        if(exists(select * from pacientes where codigo = @contador))
            BEGIN
                SET @importetotaliva = dbo.ImporteTotalIVA(@contador) 
                select nombre =@nombre, sum(importe) = @importetotal 
                from pacientes 
                inner join visitas  on codpaciente = codigo
                where codigo = @contador

                print @nombre+'space(10)'+cast(@importetotal as nvarchar(6))
                +'space(10)'+cast(@importetotaliva as nvarchar(6))
            END
    SET @contador = @contador +1 
    END



/*PARA LA BD PIZZERIA
Ejercicio 3
Crea una función que permita obtener el dinero ganado en un mes de un año concreto y para
un tipo de pizza concreto. Posteriormente deberás mostrar el dinero obtenido desde fuera de
la función (desde el script principal).*/

--consulta
select s.Npizza ,SUM(p.price) 
from sales s
inner join pizzas p on s.Npizza =p.Npizza
group by s.Npizza 


Besubio	    91.00
Boloñesa	12.50
Hawaiana	13.00
Napolitana	36.00
Simple	    7.50
Vegetariana	73.50

-----------------------------------------
SELECT datepart(YEAR FROM s.date2)as año ,
	   datepart(month FROM s.date2) as mes, 
       sum(p.price) as[Importe Total]
FROM sales s
inner join pizzas p on s.Npizza =p.Npizza
where s.Npizza like @Npizza and MONTH(s.date2) and YEAR(s.date2)
GROUP BY datepart(month FROM s.date2),datepart(YEAR FROM s.date2)
ORDER BY datepart(YEAR FROM s.date2) DESC

año     mes  Importe Total
2019	1	10.50
2019	2	13.00
2019	3	13.00
2019	4	13.00
2019	5	23.50
2019	6	25.50
2019	7	49.00
2019	8	44.00
2019	9	10.50
2019	10	10.50
2019	11	10.50
2019	12	10.50



SELECT datepart(YEAR FROM s.date2)as año ,
	   datepart(month FROM s.date2) as mes, 
       sum(p.price) as[Importe Total]
FROM sales s
inner join pizzas p on s.Npizza =p.Npizza
where s.Npizza like 'Besubio'
GROUP BY datepart(month FROM s.date2),datepart(YEAR FROM s.date2)
ORDER BY datepart(YEAR FROM s.date2) DESC



2019	2	13.00
2019	3	13.00
2019	4	13.00
2019	5	13.00
2019	6	13.00
2019	7	13.00
2019	8	13.00


--------------------------------------

-------------------------------
SELECT s.Npizza ,datepart(YEAR FROM s.date2)as año ,
	datepart(month FROM s.date2) as mes, 
    sum(p.price) as[Importe Total]
FROM sales s
inner join pizzas p on s.Npizza =p.Npizza
--where s.Npizza like 'Besubio'
GROUP BY datepart(month FROM s.date2),datepart(YEAR FROM s.date2),s.Npizza
ORDER BY datepart(YEAR FROM s.date2) DESC*/


Vegetariana	2019	1	10.50
Besubio	    2019	2	13.00
Besubio	    2019	3	13.00
Besubio	    2019	4	13.00
Besubio	    2019	5	13.00
Vegetariana	2019	5	10.50
Besubio 	2019	6	13.00
Boloñesa	2019	6	12.50
Besubio	    2019	7	13.00
Napolitana   2019	7	18.00
Simple	    2019	7	7.50
Vegetariana	2019	7	10.50
Besubio	    2019	8	13.00
Hawaiana	2019	8	13.00
Napolitana	2019	8	18.00
Vegetariana	2019	9	10.50
Vegetariana	2019	10	10.50
Vegetariana	2019	11	10.50
Vegetariana	2019	12	10.50



SELECT s.Npizza ,datepart(YEAR FROM s.date2)as año ,
	    datepart(month FROM s.date2) as mes, 
        sum(p.price) as[Importe Total]
FROM sales s
inner join pizzas p on s.Npizza =p.Npizza
where s.Npizza like 'Besubio'
GROUP BY datepart(month FROM s.date2),datepart(YEAR FROM s.date2),s.Npizza
ORDER BY datepart(YEAR FROM s.date2) DESC


Besubio	2019	2	13.00
Besubio	2019	3	13.00
Besubio	2019	4	13.00
Besubio	2019	5	13.00
Besubio	2019	6	13.00
Besubio	2019	7	13.00
Besubio	2019	8	13.00

--FUNCTION


CREATE FUNCTION [Ingresos Generados Pizza]
(
    @Npizza varchar(20),


)
RETURNS decimal(5,2)
AS
    BEGIN
        DECLARE

       SELECT @año = datepart(YEAR FROM s.date2)as año ,
	    @mes = datepart(month FROM s.date2) as mes, 
        @importe = sum(p.price) as[Importe Total]

        FROM sales s
        inner join pizzas p on s.Npizza =p.Npizza
        where s.Npizza like @Npizza and MONTH(s.date2) and YEAR(s.date2)
        GROUP BY datepart(month FROM s.date2),datepart(YEAR FROM s.date2)
        ORDER BY datepart(YEAR FROM s.date2) DESC


        return @importe
    END




/*Ejercicio 4
Muestra el cliente (código y nombre) que más pizzas haya comprado de un tipo que se pase por
parámetro. En el caso de que la pizza no exista, se deberá mostrar el siguiente error “La pizza no
existe, por favor introduzca una correcta”.*/

--CONSULTA
select  top(1) c.clientCod, c.nombre ,count(*) as Numpedidos
from client c
inner join sales s
on c.clientCod=s.clientCod
where Npizza = 'Simple'
group by c.clientCod, c.nombre
order by Npedidos desc 


----------------------------------------

--FUNCTION

IF OBJECT_ID (N'mejorClienteTipoPizza', N'IF') IS NOT NULL  
    DROP FUNCTION mejorClienteTipoPizza;  
GO  
CREATE FUNCTION mejorClienteTipoPizza (@Npizza varchar(20) )  
RETURNS TABLE  
AS  
RETURN   
(  
        select  top(1) c.clientCod, c.nombre ,count(*) as Numpedidos 
        from client c
        inner join sales s
        on c.clientCod=s.clientCod
        where Npizza = @Npizza
        group by c.clientCod, c.nombre
        order by count(*) desc  
);          


select * from dbo.mejorClienteTipoPizza (@Npizza);


--script

declare @Npizza varchar(20)

IF(exists(select * from sales WHERE @Npizza IS NOT NULL))
    BEGIN 
        select * from dbo.mejorClienteTipoPizza (@Npizza);
    END

ELSE
    BEGIN 
        PRINT 'La pizza no existe, por favor introduzca una correcta'
    END


