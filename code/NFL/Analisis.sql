
-- Ejercicios SQL - Análisis de Datos de la NFL

-- 1. ¿Cuál fue el equipo que más puntos anotó en un solo partido?
SELECT
	t.name as team,
	(select sum(home_score) from matches where home_team_id = t.id) as home_points,
	(select sum(away_score) from matches where away_team_id = t.id) as away_points,
	(select sum(home_score) from matches where home_team_id = t.id) + (select sum(away_score) from matches where away_team_id = t.id) as total_points
from teams as t
order by total_points desc;


-- MEJORADO:

WITH team_scores AS (
    SELECT home_team_id AS team_id, 
           SUM(home_score) AS home_points, 
           0 AS away_points
    FROM matches
    GROUP BY home_team_id
    UNION ALL
    SELECT away_team_id AS team_id, 
           0 AS home_points, 
           SUM(away_score) AS away_points
    FROM matches
    GROUP BY away_team_id
)
SELECT t.name AS team, 
       SUM(ts.home_points) AS home_points, 
       SUM(ts.away_points) AS away_points, 
       SUM(ts.home_points + ts.away_points) AS total_points
FROM teams t
LEFT JOIN team_scores ts ON t.id = ts.team_id
GROUP BY t.id, t.name
ORDER BY total_points DESC;


-- 2. ¿Cuántos partidos ha jugado cada equipo?
SELECT t.name AS equipo, COUNT(*) AS partidos_jugados
FROM matches AS m
JOIN teams AS t ON m.home_team_id = t.id OR m.away_team_id = t.id
GROUP BY t.name
ORDER BY partidos_jugados DESC;

-- 3. ¿Cuántos puntos ha anotado cada equipo en total?
SELECT t.name AS equipo, 
       SUM(CASE WHEN m.home_team_id = t.id THEN m.home_score ELSE m.away_score END) AS puntos_totales
FROM matches AS m
JOIN teams AS t ON m.home_team_id = t.id OR m.away_team_id = t.id
GROUP BY t.name
ORDER BY puntos_totales DESC;

-- 4. ¿Cuáles fueron los 5 partidos con mayor cantidad de puntos combinados?
SELECT m.date, t1.name AS equipo_local, t2.name AS equipo_visitante,
       (m.home_score + m.away_score) AS puntos_totales
FROM matches AS m
JOIN teams AS t1 ON m.home_team_id = t1.id
JOIN teams AS t2 ON m.away_team_id = t2.id
ORDER BY puntos_totales DESC
LIMIT 5;

-- 5. ¿En qué día de la semana se juegan más partidos?
SELECT d.name AS dia, COUNT(*) AS cantidad_partidos
FROM matches AS m
JOIN day_of_week d ON m.day_of_week_id = d.id
GROUP BY d.name
ORDER BY cantidad_partidos DESC;

-- 6. ¿Cuántos partidos se han jugado en cada temporada?
SELECT s.year AS temporada, COUNT(*) AS cantidad_partidos
FROM matches AS m
JOIN seasons AS s ON m.season_id = s.id
GROUP BY s.year
ORDER BY s.year ASC;

-- 7. ¿Cuál es la temporada con más puntos anotados en total?
SELECT s.year AS temporada, SUM(m.home_score + m.away_score) AS puntos_totales
FROM matches AS m
JOIN seasons AS s ON m.season_id = s.id
GROUP BY s.year
ORDER BY puntos_totales DESC;

-- 8. ¿Cuál ha sido la diferencia de puntos más grande en un partido y qué equipos participaron?
SELECT m.date, t1.name AS equipo_local, t2.name AS equipo_visitante, 
       m.home_score, m.away_score, 
       ABS(m.home_score - m.away_score) AS diferencia_puntos
FROM matches AS m
JOIN teams AS t1 ON m.home_team_id = t1.id
JOIN teams AS t2 ON m.away_team_id = t2.id
ORDER BY diferencia_puntos DESC
LIMIT 1;

-- 9. ¿Cuáles son los equipos que anotaron más de 50 puntos en un partido?
SELECT DISTINCT t.name AS equipo
FROM matches AS m
JOIN teams AS t ON m.home_team_id = t.id OR m.away_team_id = t.id
WHERE m.home_score > 50 OR m.away_score > 50;

-- 10. ¿Cuál fue el primer partido jugado en la historia de la liga?
SELECT m.date, t1.name AS equipo_local, t2.name AS equipo_visitante, 
       m.home_score, m.away_score
FROM matches AS m
JOIN teams AS t1 ON m.home_team_id = t1.id
JOIN teams AS t2 ON m.away_team_id = t2.id
ORDER BY m.date ASC
LIMIT 1;