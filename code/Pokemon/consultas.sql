
-- 1. ¿Cuáles son las 5 cartas más caras actualmente en el mercado (holofoil)?
SELECT name, market_price_holofoil
FROM pokemon_cards
WHERE tcg_price_date = (SELECT MAX(tcg_price_date) FROM pokemon_cards)
ORDER BY market_price_holofoil DESC
LIMIT 5;


-- 2. ¿Cuántas cartas tienen un precio de mercado en holofoil mayor a $100?
SELECT COUNT(*) AS cantidad_cartas
FROM pokemon_cards
WHERE market_price_holofoil > 100
AND tcg_price_date = (SELECT MAX(tcg_price_date) FROM pokemon_cards);


-- 3. ¿Cuál es el precio promedio de una carta en holofoil en la última actualización?
SELECT AVG(market_price_holofoil) AS precio_promedio
FROM pokemon_cards
WHERE tcg_price_date = (SELECT MAX(tcg_price_date) FROM pokemon_cards);


-- 4. ¿Cuáles son las cartas que han bajado de precio en la última actualización?
SELECT p1.name, p1.tcg_price_date, p1.market_price_holofoil, 
       (SELECT p2.market_price_holofoil 
        FROM pokemon_cards p2 
        WHERE p2.name = p1.name 
        AND p2.tcg_price_date < p1.tcg_price_date 
        ORDER BY p2.tcg_price_date DESC 
        LIMIT 1) AS previous_price
FROM pokemon_cards p1
WHERE p1.market_price_holofoil IS NOT NULL
AND p1.tcg_price_date = (SELECT MAX(tcg_price_date) FROM pokemon_cards)
HAVING market_price_holofoil < previous_price;


-- 5. ¿Qué tipo de Pokémon tiene el precio promedio más alto en holofoil?
SELECT types, AVG(market_price_holofoil) AS precio_promedio
FROM pokemon_cards
WHERE tcg_price_date = (SELECT MAX(tcg_price_date) FROM pokemon_cards)
GROUP BY types
ORDER BY precio_promedio DESC
LIMIT 1;


-- 6. ¿Cuál es la diferencia de precio entre la carta más cara y la más barata en holofoil?
SELECT MAX(market_price_holofoil) - MIN(market_price_holofoil) AS diferencia_precio
FROM pokemon_cards
WHERE tcg_price_date = (SELECT MAX(tcg_price_date) FROM pokemon_cards);



-- 7. ¿Cuántas cartas tienen precios disponibles en todas las condiciones (normal, reverse holofoil y holofoil)?
SELECT COUNT(*) AS cartas_completas
FROM pokemon_cards
WHERE market_price_normal IS NOT NULL 
AND market_price_reverse IS NOT NULL 
AND market_price_holofoil IS NOT NULL
AND tcg_price_date = (SELECT MAX(tcg_price_date) FROM pokemon_cards);



-- 8. ¿Cuál fue la fecha más reciente de actualización de precios?
SELECT MAX(tcg_price_date) AS ultima_actualizacion
FROM pokemon_cards;



-- 9. ¿Cuáles son las 3 cartas con la mayor diferencia entre el precio más alto y el más bajo en holofoil?
SELECT name, (high_price_holofoil - low_price_holofoil) AS diferencia
FROM pokemon_cards
WHERE tcg_price_date = (SELECT MAX(tcg_price_date) FROM pokemon_cards)
ORDER BY diferencia DESC
LIMIT 3;



-- 10. ¿Cuál es la carta más cara de cada tipo de Pokémon?
SELECT types, name, market_price_holofoil
FROM pokemon_cards p1
WHERE market_price_holofoil = (
    SELECT MAX(market_price_holofoil)
    FROM pokemon_cards p2
    WHERE p1.types = p2.types
    AND p2.tcg_price_date = (SELECT MAX(tcg_price_date) FROM pokemon_cards)
)
AND tcg_price_date = (SELECT MAX(tcg_price_date) FROM pokemon_cards)
ORDER BY market_price_holofoil DESC;
