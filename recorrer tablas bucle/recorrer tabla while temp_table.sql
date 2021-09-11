declare @contador int
declare @tabla table
		(
			id int not null,
			nombre nvarchar(30),
			titulo nvarchar(30)
		)

insert into @tabla(id,nombre,titulo)
select EmployeeID,FirstName,Title from Employees
select * from @tabla

set @contador = (select count(*) from @tabla)

while(@contador > 0)
	begin 
		
		declare @id int =(select top(1) id from @tabla order by id) 
		declare @nombre nvarchar(30) = (select top(1) nombre from @tabla order by id)
		declare @titulo nvarchar(30) =(select top(1) titulo from @tabla order by id)
		
		print cast(@id as nvarchar(10))+'  '+@nombre+'    '+@titulo

		delete from @tabla where id=@id
		set @contador=(select count(*) from @tabla)
	end
