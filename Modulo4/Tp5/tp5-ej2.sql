-- 1. Devuelve un listado con todos los pedidos que se han realizado. Los pedidos deben estar
-- ordenados por la fecha de realización, mostrando en primer lugar los pedidos más recientes.

	select * from pedidos order by fecha desc;

-- 2. Devuelve todos los datos de los dos pedidos de mayor valor.

	select * from pedidos inner join clientes on clientes.id=id_cliente order by cantidad desc limit 2;
    
-- 3. Devuelve un listado con los identificadores de los clientes que han realizado algún pedido.
-- Tenga en cuenta que no debe mostrar identificadores que estén repetidos.

	select  distinct id_cliente,clientes.nombre from pedidos inner join clientes on clientes.id=id_cliente;

-- 4. Devuelve un listado de todos los pedidos que se realizaron durante el año 2022, cuya
-- cantidad total sea superior a $500.
	
    select * from pedidos where fecha between '2022-01-01' and '2022-12-31' and cantidad > 500; 

-- 5. Devuelve un listado con el nombre y apellido de los vendedores que tienen una comisión
-- entre 0.05 y 0.11.

	select vendedores.nombre,vendedores.apellido,vendedores.comisión from vendedores where comisión between 0.05 and 0.11;
    
-- 6. Devuelve el valor de la comisión de mayor valor que existe en la tabla vendedores.
	
    select vendedores.nombre,vendedores.apellido,vendedores.comisión from vendedores order by comisión desc limit 1;

-- 7. Devuelve el identificador, nombre y primer apellido de aquellos clientes cuyo cuitcuil no es
-- NULL. El listado deberá estar ordenado alfabéticamente por apellido y nombre.

	select id, concat_ws(' ',clientes.nombre,clientes.apellido) as nombre_apellido from clientes where cuitcuil IS NOT NULL order by clientes.apellido asc,clientes.nombre asc;
    
-- 8. Devuelve un listado de los nombres de los clientes que empiezan por “A” y terminan por “n” y
-- también los nombres que empiezan por “P”. El listado deberá estar ordenado
-- alfabéticamente.
		
	select clientes.nombre from clientes where nombre LIKE 'A%n' or nombre LIKE 'P%'  order by clientes.nombre asc;


-- 9. Devuelve un listado de los nombres de los clientes que no empiezan por “A”. El listado deberá
-- estar ordenado alfabéticamente.
	
    select clientes.nombre from clientes where nombre NOT LIKE 'A%' order by clientes.nombre asc;

-- 10.Devuelve un listado con los nombres de los vendedores que terminan por “el” o “o”. Tenga en
-- cuenta que se deberán eliminar los nombres repetidos.

	select vendedores.nombre from vendedores where vendedores.nombre like '%el' or vendedores.nombre like '%o';

-- 11.Devuelve un listado con el identificador, nombre y apellido de todos los clientes que han
-- realizado algún pedido. El listado debe estar ordenado alfabéticamente y se deben eliminar
-- los elementos repetidos.

	select distinct clientes.id, clientes.nombre,clientes.apellido from clientes inner join pedidos on clientes.id=pedidos.id_cliente order by clientes.nombre asc;


-- 12.Devuelve un listado que muestre todos los pedidos que ha realizado cada cliente. El resultado
-- debe mostrar todos los datos de los pedidos y del cliente. El listado debe mostrar los datos de
-- los clientes ordenados alfabéticamente.

	select * from clientes inner join pedidos on clientes.id=pedidos.id_cliente order by clientes.nombre asc;
    
-- 13.Devuelve un listado que muestre todos los pedidos en los que ha participado un vendedor. El
-- resultado debe mostrar todos los datos de los pedidos y de los vendedores. El listado debe
-- mostrar los datos de los vendedores  ordenados alfabéticamente.
	
    select * from vendedores inner join pedidos on vendedores.id=pedidos.id_vendedor order by vendedores.nombre asc;

-- 14.Devuelve un listado que muestre todos los clientes, con todos los pedidos que han realizado y
-- con los datos de los vendedores asociados a cada pedido.


	select * from clientes inner join pedidos on clientes.id = pedidos.id_cliente inner join vendedores on vendedores.id=pedidos.id_vendedor order by clientes.nombre;


-- 15.Devuelve un listado de todos los clientes que realizaron un pedido durante el año 2022, cuyo
-- monto esté entre $300  y $1000.

	select * from clientes inner join pedidos on pedidos.id_cliente=clientes.id where fecha between '2022/01/01' and '22/12/31' and cantidad between 300 and 1000;

-- 16.Devuelve el nombre y apellido de todos los vendedores que han participado en algún pedido
-- realizado por María Santana.

	select * from vendedores inner join pedidos on vendedores.id=pedidos.id_vendedor inner join clientes 
    on clientes.id=pedidos.id_cliente where clientes.nombre = 'Maria' and clientes.apellido ='Santana';

-- 17.Devuelve el nombre de todos los clientes que han realizado algún pedido con el vendedor
-- Daniel Sáez.
	
	select distinct clientes.nombre,clientes.apellido,vendedores.nombre, vendedores.apellido from clientes inner join pedidos on clientes.id=pedidos.id_cliente 
    inner join vendedores where vendedores.nombre='Daniel' and vendedores.apellido='Sáez';

    
-- 18.Devuelve un listado con todos los clientes junto con los datos de los pedidos que han
-- realizado. Este listado también debe incluir los clientes que no han realizado ningún pedido.
-- El listado debe estar ordenado alfabéticamente por el apellido y nombre de los clientes.
	
    select * from clientes inner join pedidos on clientes.id=pedidos.id order by clientes.apellido asc,clientes.nombre asc;


-- 19.Devuelve un listado con todos los vendedores junto con los datos de los pedidos que han
-- realizado. Este listado también debe incluir los vendedores que no han realizado ningún
-- pedido. El listado debe estar ordenado alfabéticamente por el apellido y nombre de los
-- vendedores.
    select * from vendedores inner join pedidos on vendedores.id=pedidos.id order by vendedores.apellido asc,vendedores.nombre asc;

-- 20.Devuelve un listado que solamente muestre los clientes que no han realizado ningún pedido.

	select * from clientes left join pedidos on clientes.id= pedidos.id_cliente where clientes.id and pedidos.id is null;

-- 21.Devuelve un listado que solamente muestre los vendedores que no han realizado ningún
-- pedido.

	select * from vendedores left join pedidos on vendedores.id= pedidos.id_vendedor where pedidos.id is null;
    
-- 22.Devuelve un listado con los clientes que no han realizado ningún pedido y de los vendedores
-- que no han participado en ningún pedido. Ordene el listado alfabéticamente por el apellido y
-- el nombre. En el listado deberá diferenciar de algún modo los clientes y los vendedores.

	select 'vendedores' AS tipo ,vendedores.id,concat_ws(' ',vendedores.nombre,vendedores.apellido) as nombre_completo from vendedores 
    left join pedidos on vendedores.id= pedidos.id_vendedor where pedidos.id is null 
    union 
    select 'clientes', clientes.id,concat_ws(' ',clientes.nombre,clientes.apellido) as nombre_completo from clientes 
    left join pedidos on clientes.id= pedidos.id_cliente where clientes.id and pedidos.id is null
    order by nombre_completo asc;
	
    
    
-- 23.Calcula la cantidad total que suman todos los pedidos que aparecen en la tabla pedido.

	select round(sum(cantidad),2) as 'total de Pedidos' from pedidos;

-- 24.Calcula la cantidad media de todos los pedidos que aparecen en la tabla pedido.
	
	select round(AVG(cantidad),2) as 'media de pedidos' from pedidos;
    
    
-- 25.Calcula el número total de vendedores distintos que aparecen en la tabla pedido.
    
	select  count(distinct pedidos.id_vendedor) as 'vendedores' from vendedores left join pedidos 
	on pedidos.id_vendedor=vendedores.id
	where pedidos.id is not null;
    
-- 26.Calcula el número total de clientes que aparecen en la tabla cliente.
	
    select count(id) as 'Total clientes' from clientes;

-- 27.Calcula cuál es la mayor cantidad que aparece en la tabla pedido.
	
    select max(cantidad) as 'cantidad min' 
	from pedidos;
		

-- 28.Calcula cuál es la menor cantidad que aparece en la tabla pedido.

	select min(cantidad) as 'cantidad min' 
	from pedidos;

-- 29.Calcula cuál es el valor máximo de categoría para cada una de las ciudades que aparece en la
-- tabla cliente.

	select ciudad, max(categoría) from clientes group by clientes.id;
    
-- 30.Calcula cuál es el máximo valor de los pedidos realizados durante el mismo día para cada uno
-- de los clientes. Es decir, el mismo cliente puede haber realizado varios pedidos de diferentes
-- cantidades el mismo día. Se pide que se calcule cuál es el pedido de máximo valor para cada
-- uno de los días en los que un cliente ha realizado un pedido. Muestra el identificador del
-- cliente, nombre, apellido, la fecha y el valor de la cantidad.

	select * 
-- 31.Calcula cuál es el máximo valor de los pedidos realizados durante el mismo día para cada uno
-- de los clientes, teniendo en cuenta que sólo queremos mostrar aquellos pedidos que superen
-- la cantidad de $2000 .
-- 32.Calcula el máximo valor de los pedidos realizados para cada uno de los vendedores durante la
-- fecha 2021-08-17. Muestra el identificador del vendedor, nombre, apellido y total.
-- 33.Devuelve un listado con el identificador de cliente, nombre y apellido y el número total de
-- pedidos que ha realizado cada uno de los clientes. Tenga en cuenta que pueden existir
-- clientes que no han realizado ningún pedido. Estos clientes también deben aparecer en el
-- listado indicando que el número de pedidos realizados es 0.
-- 34.Devuelve un listado con el identificador de cliente, nombre, apellido y el número total de
-- pedidos que ha realizado cada uno de clientes durante el año 2020.
-- 35.Devuelve cuál ha sido el pedido de máximo valor que se ha realizado cada año.
-- 36.Devuelve el número total de pedidos que se han realizado cada año.
-- 37.Devuelve un listado con todos los pedidos que ha realizado Adela Salas. (Sin utilizar INNER
-- JOIN).
-- 38.Devuelve el número de pedidos en los que ha participado el vendedor Daniel Sáe. (Sin utilizar
-- INNER JOIN)
-- 39.Devuelve los datos del cliente que realizó el pedido más caro en el año 2020. (Sin utilizar
-- INNER JOIN)
-- 40.Devuelve la fecha y la cantidad del pedido de menor valor realizado por el cliente Pepe Ruiz
-- Santana.
-- 41.Devuelve un listado de los clientes que no han realizado ningún pedido. (Utilizando IN o NOT
-- IN).
-- 42.Devuelve un listado de los vendedores que no han realizado ningún pedido. (Utilizando IN o
-- NOT IN).
-- 43.Devuelve un listado de los clientes que no han realizado ningún pedido. (Utilizando EXISTS o
-- NOT EXISTS).
-- 44.Devuelve un listado de los vendedores que no han realizado ningún pedido. (Utilizando
-- EXISTS o NOT EXISTS).

-- https://es.scribd.com/document/544081894/Practica-09b-Consultas-SQL