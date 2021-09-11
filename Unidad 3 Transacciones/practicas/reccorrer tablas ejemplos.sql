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
having count(*)>=4

declare @contador int
select @contador=(select count(*) from #tmptable)

while(@contador > 0)
	begin 
		declare @codigo nvarchar(20) = (select top (1) codigo from #tmptable) ,
				@nombre nvarchar(20) = (select top (1) nombre from #tmptable) ,
				@direccion nvarchar(30)= (select top (1) direccion from #tmptable) ,
				@ciudad nvarchar(30) = (select top (1) ciudad from #tmptable) ,
				@diabetico nvarchar(30) = (select top (1) diabetico from #tmptable) ,
				@fechanac nvarchar(30) = (select top (1) fechanac from #tmptable) ,
				@Nvisitas nvarchar(30) = (select top (1) Nvisitas from #tmptable) ,
				@turno nvarchar(30) = (select top (1) turno from #tmptable) 

				print '@codigo' + '   '+'@nombre' + '   '+'@direccion' + '   '+'@ciudad'+'   '+'@Nvisitas'
				+ cast(@contador as nvarchar(30))

				delete top(1) from #tmptable
				select @contador = count(*) from #tmptable
	end

	drop table #tmptable


    -----------------------------------------------------------------

declare @codigo char(11), @nombre char(20)

set rowcount 0  //devuelve todas las filas 

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
having count(*)>=4

set rowcount 1 //devuelve 1ºa fila
select @codigo = codigo, @nombre = nombre from #tmptable

while(@@ROWCOUNT <> 0)
	begin 
		set rowcount 0
		select * from #tmptable where @codigo = codigo and @nombre = nombre
		delete #tmptable where  @codigo =codigo
	end

	drop table #tmptable



    --------------------------------------------------------------

declare @count int = 0,
@countb int = 1

set @count = (select count( * ) from stats_ddl)
while @countb <= @count
begin
declare @fechaMov varchar(50) = (select top(1) fecha + hora + importe from stats_ddl)
print 'fecha' + @fechaMov + ' ' + convert(varchar, @countb)
set @countb = @countb + 1
end