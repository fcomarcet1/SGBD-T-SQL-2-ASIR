insert into @tabla(id,name) select id,name from people
 
declare @count int = (select count(*) from @tabla)
 
while @count > 0
begin
 
    declare @name varchar(max) = (select top(1) name from @tabla order by id)
    declare @id int = (select top(1) id from @tabla order by id)
 
    print 'Hola '+@name
 
    delete @tabla where id=@id
 
    set @count = (select count(*) from @tabla)
 
end



/*Declaración variables*/
/**********************/
Declare @id int,
        @count int
/*Iniciarlizar las variables @id y @count*/
/**********************/
Set @id=1
select @count=count(*)from tblpacientes 

/*Con un while recorremos los datos sin utilizar un cursor.*/
/**********************/

while @id<=@count
begin
    select * from (select  *,RANK()OVER (ORDER BY strNombre ASC)AS RANK from tblpacientes) as ji
    where rank=@id
/*recoremos secuencialmente los datos de la tabla al introducir la función rank() e igualar su resultado a nuestra variable @id*/

/*Terminadas las opercaciones incrementamos la variable @id*/
select @id=@id+1
end




-----------------------------------

