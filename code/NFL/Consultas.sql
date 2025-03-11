-- Forma con subselects poco optimizada
SELECT
t.name as team,
(select sum(home_score) from matches where home_team_id = t.id) as home_points,
(select sum(away_score) from matches where away_team_id = t.id) as away_points,
(select sum(home_score) from matches where home_team_id = t.id) + (select sum(away_score) from matches where away_team_id = t.id) as total_points
from teams as t
order by total_points desc;

-- Cual fue el equipo con mas puntos en un solo partido
with team_scores as (
    select home_team_id    as team_id,
        sum(home_score) as home_points,
        0               as away_points
     from matches
     group by home_team_id

     union all

     select away_team_id    as team_id,
            0               as home_points,
            sum(away_score) as away_points
     from matches
     group by away_team_id
)
select
    t.name as team,
    sum(ts.home_points) as home_points,
    sum(ts.away_points) as away_points,
    sum(ts.home_points + ts.away_points) as total_points
from team_scores as ts
join teams as t on ts.team_id = t.id
group by t.name
order by  total_points desc;

-- cuantos partidos ha ganado cada equipo
select
    t.name as equipo,
    count(*) as partidos
from matches as m
join teams as t on m.away_team_id = t.id or m.home_team_id = t.id
group by t.name
order by partidos desc;

-- cuantos puntos ha anotado cada equipo
select
    t.name as equipo,
    sum(
        case
            when m.home_team_id = t.id then m.home_score
            else m.away_score
        end
    ) as puntos_totales
from matches as m
join teams as t on m.away_team_id = t.id or m.home_team_id = t.id
group by t.name
order by puntos_totales desc;

-- 5 patidos con mayor cantidad de puntos combinados
select
    m.date, t1.name as local, t2.name as visitante, (m.home_score + m.away_score) as total
from matches as m
join teams as t1 on m.home_team_id = t1.id
join teams as t2 on m.away_team_id = t2.id
order by total desc
limit 5;

-- dia de la semana con más partidos
select
    d.name,
    count(*) as partidos
from matches as m
join day_of_week as d on m.day_of_week_id = d.id
group by d.name
order by partidos desc;

-- diferencia mas grande y que equipo
select
    m.date,
    t1.name as local,
    t2.name as visita,
    home_score,
    away_score,
    abs(m.home_score - m.away_score) as diferencia
from matches as m
join teams as t1 on m.home_team_id = t1.id
join teams as t2 on m.away_team_id = t2.id
order by diferencia desc
limit 1;