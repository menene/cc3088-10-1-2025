-- 1. Listar todos los libros disponibles en la biblioteca.
select *
from libros
where disponible > 0;

-- 2. Mostrar el nombre y carrera de todos los estudiantes registrados.
select nombre, carrera
from estudiantes;

-- 3. Obtener los títulos de los libros prestados actualmente (sin fecha de devolución).
select l.titulo
from prestamos as p
join libros as l on p.libro_id = l.id
where devuelto_en is null;

-- 4. Mostrar los datos de los estudiantes que han tomado algún préstamo.
-- select distinct e.nombre, e.email, e.carrera
select distinct e.*
from prestamos as p
join estudiantes as e on p.estudiante_id = e.id;

-- 5. Listar los préstamos hechos en los últimos 7 días.
select *
from prestamos
where prestado_en >= current_date - interval '7 days';

-- 6. Mostrar los nombres de los estudiantes que tienen un libro prestado actualmente.
select distinct e.nombre
from prestamos as p
join estudiantes as e on p.estudiante_id = e.id
where p.devuelto_en is null;

-- 7. Obtener los nombres de los estudiantes que nunca han hecho un préstamo.
select nombre, apellido
from estudiantes
where id not in (select estudiante_id from prestamos);

-- 8. Mostrar el título de los libros prestados por un estudiante en particular.
select l.titulo
from prestamos as p
join libros as l on p.libro_id = l.id
where p.estudiante_id = 2;

-- 9. Mostrar los libros que ya han sido devueltos.
select l.titulo
from prestamos as p
join libros as l on p.libro_id = l.id
where p.devuelto_en is not null;

-- 10. Obtener el nombre de un estudiante que tomó un libro específico.
select e.nombre
from prestamos as p
join estudiantes as e on p.estudiante_id = e.id
join libros as l on p.libro_id = l.id
where l.titulo = 'Bambi';
