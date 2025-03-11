-- GROUP BY
SELECT
    categoria,
    SUM(ventas) as total
FROM productos
GROUP BY categoria
order by total desc;

-- ORDER BY
SELECT
    nombre,
    ventas
FROM productos
ORDER BY ventas DESC;

--SUM
select
    sum(salario)
from empleados;

--COUNT
select
    count(*)
from empleados;

-- AVG
select
    avg(edad)
from empleados;

-- MIN / MAX
SELECT MIN(salario), MAX(salario) FROM empleados;

SELECT MIN(edad), MAX(edad) FROM empleados;

-- UNION
SELECT
    nombre
FROM clientes_usa

UNION

SELECT
    nombre
FROM clientes_mexico;

-- UNION ALL
SELECT
    nombre
FROM clientes_usa

UNION ALL

SELECT
    nombre
FROM clientes_mexico;

-- WITH
WITH salario_promedio AS (
    SELECT
        AVG(salario) AS promedio
    FROM empleados
)
SELECT
    *
FROM empleados
WHERE salario > (select avg(salario) from empleados)

-- CASE WHEN THEN
SELECT nombre, salario,
       CASE
           WHEN salario > 5000 THEN 'Alto'
           WHEN salario BETWEEN 3000 AND 5000 THEN 'Medio'
           ELSE 'Bajo'
           END AS categoria_salarial
FROM empleados;