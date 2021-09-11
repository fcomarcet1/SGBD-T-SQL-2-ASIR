Utilizar instrucciones Transact-SQL para recorrer un conjunto de resultados
Hay tres métodos que puede utilizar para recorrer en iteración un conjunto de resultados, mediante instrucciones de Transact-SQL.


Un método es el uso de tablas temp . Con este método, se crea una "instantánea" de la instrucción SELECT inicial y se utiliza como base para "cursor". Por ejemplo:

/********** example 1 **********/ 

declare @au_id char( 11 )

set rowcount 0
select * into #mytemp from authors

set rowcount 1

select @au_id = au_id from #mytemp

while @@rowcount <> 0
begin
    set rowcount 0
    select * from #mytemp where au_id = @au_id
    delete #mytemp where au_id = @au_id

    set rowcount 1
    select @au_id = au_id from #mytemp<BR/>
end
set rowcount 0

/*Un segundo método sería utilizar la función min para "recorrer" una tabla una fila cada vez. 
Este método detecta las filas nuevas que se agregaron después el procedimiento almacenado comienza la ejecución, 
siempre que la nueva fila tiene un identificador único mayor que la fila actual que se está procesando en la consulta.
 Por ejemplo:*/

/********** example 2 **********/ 

declare @au_id char( 11 )

select @au_id = min( au_id ) from authors

while @au_id is not null
begin
    select * from authors where au_id = @au_id
    select @au_id = min( au_id ) from authors where au_id > @au_id
end

/*Nota: ambas ejemplo 1 y 2, se supone que existe un identificador único para cada fila de la tabla de origen. En algunos casos, 
no puede existir ningún identificador único. Si ese es el caso, puede modificar el método de tabla temp
 para utilizar una columna de clave recién creada. Por ejemplo:*/

/********** example 3 **********/ 

set rowcount 0
select NULL mykey, * into #mytemp from authors

set rowcount 1
update #mytemp set mykey = 1

while @@rowcount > 0
begin
    set rowcount 0
    select * from #mytemp where mykey = 1
    delete #mytemp where mykey = 1
    set rowcount 1
    update #mytemp set mykey = 1
end
set rowcount 0