
-- crear table empleados
create table empleados (
	id serial primary key,
	nombre varchar(255)
);

-- crear table inventario
create table inventario (
	id serial primary key,
	libro_id int null references libros (id),
	estudiante_id int null references estudiantes (id),
	empleado_id int null references empleados (id),
	cantidad int
);

-- crear un nuevo empleado
insert into empleados (nombre) values ('Bibliotecario');

-- generar datos aleatorios
INSERT INTO inventario (libro_id, estudiante_id, cantidad)
SELECT 
    (floor(random() * 5) + 2)::int AS libro_id, 
    (floor(random() * 2) + 2)::int AS estudiante_id, 
    CASE WHEN random() > 0.5 THEN 1 ELSE -1 END AS cantidad
FROM generate_series(1, 1000);