
-- crear tabla estudiantes
create table estudiantes (
	id serial primary key,
	nombre varchar(255),
	apellido varchar(255),
	email varchar(255) unique,
	carrera varchar(255),
	fecha_registro date
);

-- crear tabla de libros
create table libros (
	id serial primary key,
	titulo varchar(100),
	autor varchar(100),
	publicado_en int,
	disponible int check (disponible >= 0)
);

-- crear tabla prestamos
create table prestamos (
	id serial primary key,
	estudiante_id int references estudiantes (id) on delete cascade,
	libro_id int references libros (id) on delete cascade,
	prestado_en date,
	devuelto_en date default null
);
