/*=============================================
  fundamentos.sql
  Descripción  : Consultas iniciales
  Autor        : Erick Marroqin
  Fecha        : 2025-02-17
=============================================*/

-- sleccionar todos los campos
-- de la tabla de usuarios
select * from usuarios;


-- seleccionar los campos de email, rol_id,
-- nombre, email y id de la tabla de usuarios
-- para todos aquellos que tengan rol_id 
-- igual a 1 y nombre igual a 'Erick'
SELECT 
email, rol_id, nombre,
email, id
FROM usuarios 
where rol_id = 1 
and nombre = 'Erick';

-- seleccionar los campos de email, rol_id,
-- nombre y correlativo de la tabla de usuarios
-- para todos aquellos cuya suma de id y correlativo
-- sea mayor a 100
SELECT 
email, rol_id, nombre,
id, correlativo,
FROM usuarios 
where (id + correlativo) > 100;

-- seleccionar los campos de email, rol_id,
-- nombre, id, correlativo y una columna calculada
-- a la que le asignamos el alias de factor_fabian
-- de la tabla de usuarios para todos aquellos 
-- cuya suma de id y correlativo sea mayor a 100
SELECT 
email, rol_id, nombre,
id, correlativo,
(id + correlativo) as factor_fabian
FROM usuarios
where (id + correlativo) > 100;

-- sleccionar nombre de usuario (le asignamos el alias de usuario),
-- email y nombre del rol (le asignamos el alias de rol)
-- de la tabla de usuarios (le asignamos un alias de u) 
-- haciendo un join a la tabla de roles (le asignamos un alias de r)
select
u.nombre as usuario, email, r.nombre as rol
from public.usuarios as u
join public.roles as r on u.rol_id = r.id;