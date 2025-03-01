-- crear 3 estudiantes
insert into estudiantes (nombre, apellido, email, carrera, fecha_registro)
values
('Nery', 'Molina', 'yo@nrywhite.lat', 'Marketing', '2025-02-27'),
('Hernesto', 'Akino', 'yo@aquisi.com', 'Mecatrónica', '2025-02-28'),
('Quebin', 'Escobar', 'yo@mafia.cc', 'Agronomía', '2024-02-28');

-- crear 5 libros
insert into libros (titulo, autor, publicado_en, disponible)
values
('Popl Vuh', 'Los Mayas', 1701, 10),
('Biblia', 'Los 12 Apostoles', 1, 2),
('Bambi', 'Walt Disney', 1950, 3),
('Harry Potter y el pricionero de Azkaban', 'J.K. Rowling', 2004, 100),
('Cómo programar en Java', 'Deitel', 2007, 12);

-- prestar un libro
insert into prestamos (estudiante_id, libro_id, prestado_en)
values
(1, 2, current_date);

-- actualizar un estudiante
update estudiantes
set email = 'yo@aquitalvez.com'
where id = 2;

-- reducir la disponibilidad de un libro
update libros
set disponible = disponible - 1
where id = 2;

-- eliminar a un estudiante
delete from estudiantes
where id = 1;

-- prestar un libro
insert into prestamos (estudiante_id, libro_id, prestado_en)
values
(2, 3, current_date);

update prestamos
set devuelto_en = CURRENT_DATE
where id = 2;
