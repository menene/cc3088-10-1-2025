
-- agregar telefono a estudiantes
alter table estudiantes
add column telefono varchar(10);

-- no valores negativos en libros
alter table libros alter column disponible set default 0;
alter table libros add constraint cantidad_positiva check (disponible >= 0);

-- crear tabla autores
create table autores (
	id serial primary key,
	nombre varchar(100),
	apellido varchar(100),
	nacionalidad varchar(100)
);

-- crear tabla categorias
create table categorias (
	id serial primary key,
	nombre varchar(100)
);

-- referenciar nuevas tablas con libros
insert into autores (nombre, apellido, nacionalidad)
select distinct autor, '-', '-' from libros;

alter table libros add column autor_id int references autores(id) on delete cascade;

update libros as l
set autor_id = (select id from autores where nombre = l.autor);

alter table libros drop column autor;
