-- seleccionar cuantos libros hay actualmente en la biblioteca
select
e.nombre,
l.titulo,
sum(cantidad)
from inventario as i
join libros as l on i.libro_id = l.id
join estudiantes as e on i.estudiante_id = e.id
--where libro_id = 2
group by e.nombre, l.titulo;



SELECT
e.nombre as estudiante,
l.titulo as libro
from inventario as i
join estudiantes as e on i.estudiante_id = e.id
join libros as l on i.libro_id = l.id
where estudiante_id is not null;

-- devoluciones de un libo y de un estudiante
select 
sum(cantidad) as devoluciones
from inventario 
where estudiante_id = 2 
and cantidad > 0
and libro_id = 2;

-- prestamos de un libro y de un estudiante
select 
abs(sum(cantidad)) as prestamos
from inventario 
where estudiante_id = 2 
and cantidad < 0
and libro_id = 2;

-- prestamos y devoluciones de libros a estudiantes
SELECT
distinct e.nombre as estudiante,
l.titulo as libro,
	(select 
	sum(cantidad)
	from inventario 
	where estudiante_id = e.id
	and cantidad > 0
	and libro_id = l.id) as devolucion,
(select 
	abs(sum(cantidad))
	from inventario 
	where estudiante_id = e.id 
	and cantidad < 0
	and libro_id = l.id) as prestamos
from inventario as i
join estudiantes as e on i.estudiante_id = e.id
join libros as l on i.libro_id = l.id
where estudiante_id is not null
order by e.nombre, l.titulo;

-- libros prestados por estudiente con tituo y autor
SELECT
e.nombre as estudiante,
l.titulo as libro,
a.nombre as autor
from inventario as i
join estudiantes as e on i.estudiante_id = e.id
join libros as l on i.libro_id = l.id
join autores as a on l.autor_id = a.id
where estudiante_id is not null;

-- autor mas popular para un estudiente
select
a.nombre, count(*)
from inventario as i
join libros as l on i.libro_id = l.id
join autores as a on l.autor_id = a.id
where estudiante_id = 3
group by a.nombre
order by count desc
limit 1;
