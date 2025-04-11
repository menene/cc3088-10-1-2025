-- 1. Contar la cantidad de libros en cada categoría
SELECT categorias.nombre, COUNT(libros.id) AS total_libros
FROM categorias
LEFT JOIN libros ON categorias.id = libros.categoria_id
GROUP BY categorias.nombre;

-- 2. Mostrar cuántos libros ha escrito cada autor
SELECT autores.nombre, autores.apellido, COUNT(libros.id) AS total_libros
FROM autores
LEFT JOIN libros ON autores.id = libros.autor_id
GROUP BY autores.id;

-- 3. Contar la cantidad de préstamos realizados por cada estudiante
SELECT estudiantes.nombre, estudiantes.apellido, COUNT(prestamos.id) AS total_prestamos
FROM prestamos
JOIN estudiantes ON prestamos.estudiante_id = estudiantes.id
GROUP BY estudiantes.id;

-- 4. Calcular el número promedio de libros por categoría
SELECT AVG(total) AS promedio_libros_por_categoria FROM (
    SELECT COUNT(libros.id) AS total FROM libros
    GROUP BY libros.categoria_id
) AS subquery;

-- 5. Encontrar el libro más prestado
SELECT libros.titulo, COUNT(prestamos.id) AS veces_prestado
FROM prestamos
JOIN libros ON prestamos.libro_id = libros.id
GROUP BY libros.id
ORDER BY veces_prestado DESC
LIMIT 1;

-- 6. Encontrar el estudiante que ha tomado más libros prestados
SELECT estudiantes.nombre, estudiantes.apellido, COUNT(prestamos.id) AS total_prestamos
FROM prestamos
JOIN estudiantes ON prestamos.estudiante_id = estudiantes.id
GROUP BY estudiantes.id
ORDER BY total_prestamos DESC
LIMIT 1;

-- 7. Mostrar la cantidad de préstamos por mes
SELECT DATE_TRUNC('month', fecha_prestamo) AS mes, COUNT(*) AS total_prestamos
FROM prestamos
GROUP BY mes
ORDER BY mes;

-- 8. Contar la cantidad de estudiantes que han tomado al menos un libro de cada categoría
SELECT categorias.nombre, COUNT(DISTINCT prestamos.estudiante_id) AS total_estudiantes
FROM prestamos
JOIN libros ON prestamos.libro_id = libros.id
JOIN categorias ON libros.categoria_id = categorias.id
GROUP BY categorias.id;

-- 9. Mostrar los 3 estudiantes con más libros prestados
SELECT estudiantes.nombre, estudiantes.apellido, COUNT(prestamos.id) AS total_prestamos
FROM prestamos
JOIN estudiantes ON prestamos.estudiante_id = estudiantes.id
GROUP BY estudiantes.id
ORDER BY total_prestamos DESC
LIMIT 3;

-- 10. Calcular la duración promedio de los préstamos antes de ser devueltos
SELECT AVG(fecha_devolucion - fecha_prestamo) AS duracion_promedio_dias
FROM prestamos
WHERE fecha_devolucion IS NOT NULL;

-- 11. Obtener la cantidad de préstamos realizados por cada carrera universitaria
SELECT estudiantes.carrera, COUNT(prestamos.id) AS total_prestamos
FROM prestamos
JOIN estudiantes ON prestamos.estudiante_id = estudiantes.id
GROUP BY estudiantes.carrera
ORDER BY total_prestamos DESC;

-- 12. Encontrar las 3 categorías de libros más prestadas
SELECT categorias.nombre, COUNT(prestamos.id) AS total_prestamos
FROM prestamos
JOIN libros ON prestamos.libro_id = libros.id
JOIN categorias ON libros.categoria_id = categorias.id
GROUP BY categorias.id
ORDER BY total_prestamos DESC
LIMIT 3;

-- 13. Encontrar los estudiantes que han tomado más libros prestados que el promedio
SELECT estudiantes.nombre, estudiantes.apellido, COUNT(prestamos.id) AS total_prestamos
FROM prestamos
JOIN estudiantes ON prestamos.estudiante_id = estudiantes.id
GROUP BY estudiantes.id
HAVING COUNT(prestamos.id) > (
    SELECT AVG(total_prestamos) FROM (
        SELECT COUNT(prestamos.id) AS total_prestamos FROM prestamos
        GROUP BY prestamos.estudiante_id
    ) AS subquery
)
ORDER BY total_prestamos DESC;

-- 14. Calcular la tasa de devolución de libros por categoría
SELECT categorias.nombre, 
       COUNT(prestamos.id) AS total_prestamos, 
       COUNT(prestamos.fecha_devolucion) AS total_devueltos,
       (COUNT(prestamos.fecha_devolucion)::DECIMAL / COUNT(prestamos.id)) * 100 AS tasa_devolucion
FROM prestamos
JOIN libros ON prestamos.libro_id = libros.id
JOIN categorias ON libros.categoria_id = categorias.id
GROUP BY categorias.id
ORDER BY tasa_devolucion DESC;

-- 15. Encontrar el estudiante que ha mantenido un libro prestado por más tiempo sin devolverlo
SELECT estudiantes.nombre, estudiantes.apellido, libros.titulo, 
       CURRENT_DATE - prestamos.fecha_prestamo AS dias_prestado
FROM prestamos
JOIN estudiantes ON prestamos.estudiante_id = estudiantes.id
JOIN libros ON prestamos.libro_id = libros.id
WHERE prestamos.fecha_devolucion IS NULL
ORDER BY dias_prestado DESC
LIMIT 1;
