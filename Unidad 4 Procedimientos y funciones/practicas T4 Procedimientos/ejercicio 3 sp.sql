declare @contador INT,
        @codigo int,
        @nombre NVARCHAR(20),
        @sumaimporte int
            

CREATE table #tmptable 
    (
        codigo int,
        nombre nvarchar(20),
        sumaimporte int,
        media int,
        numvisitas int
    )

INSERT INTO #tmptable (codigo, nombre, sumaimporte, media, Numvisitas)

    select codpaciente, nombre ,sum(importe),(select avg(importe) from visitas) as media ,count(*) AS nvisitas 
    FROM visitas
	inner join pacientes on codpaciente = codigo
    group by codpaciente, nombre
    having sum(importe)>avg(importe)

SELECT @contador = COUNT(*) from #tmptable 
WHILE(@contador > 0)
    BEGIN 
        set @nombre = select top(1) from #tmptable 
    
    END