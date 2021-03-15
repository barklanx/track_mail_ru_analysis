-- Task 1
    -- Посчитать количество матчей, в которых first_blood_time больше
    -- 1 минуты, но меньше 3х минут;
SELECT
  COUNT(match_id)
FROM
  match
WHERE
  first_blood_time BETWEEN 60
  AND 180; -- 20098


-- Task 2
  -- Вывести идентификаторы участников (исключая анонимные
  -- аккаунты где айдишник равен нулю), которые участвовали в
  -- матчах, в которых победили силы Света и количество
  -- позитивных отзывов зрителей было больше чем количество
  -- негативных;
SELECT
  DISTINCT p.account_id
FROM
  players p
  INNER JOIN match m USING(match_id)
WHERE
  (m.radiant_win = 'True')
  AND (p.account_id <> 0)
  AND (m.positive_votes > m.negative_votes); -- 212 accounts


-- Task 3
  -- Получить идентификатор игрока и среднюю продолжительность
  -- его матчей;
SELECT
  p.account_id,
  avg(m.duration) AS avg_match_duration
FROM
  players p
  INNER JOIN match m USING(match_id)
GROUP BY
  p.account_id;


-- Task 4
  -- Получить суммарное количество потраченного золота,
  -- уникальное количество использованных персонажей, среднюю
  -- продолжительность матчей (в которых участвовали данные
  -- игроки) для анонимных игроков;
SELECT
  SUM(p.gold_spent) AS sum_gold_spent,
  COUNT(DISTINCT hero_id) AS num_unique_heroes,
  AVG(m.duration) AS avg_match_duration
FROM
  players p
  INNER JOIN match m USING(match_id)
WHERE
  p.account_id = 0;


-- Task 5
  -- для каждого героя (hero_name) вывести: количество матчей в
  -- которых был использован, среднее количество убийств,
  -- минимальное количество смертей, максимальное количество
  -- потраченного золота, суммарное количество позитивных
  -- отзывов зрителей, суммарное количество негативных отзывов.
SELECT
  h.localized_name,
  COUNT(match_id) AS count_matches,
  AVG(p.kills) AS avg_kills,
  MIN(p.deaths) AS min_deaths,
  MAX(p.gold_spent) AS max_gold_spent,
  SUM(m.positive_votes) AS sum_positive_votes,
  SUM(m.negative_votes) AS sum_negative_votes
FROM
  players p
  INNER JOIN match m USING(match_id)
  INNER JOIN hero_names h USING(hero_id)
GROUP BY h.localized_name;


-- Task 6
  -- вывести матчи в которых: хотя бы одна покупка item_id = 42
  -- состоялась позднее 100 секунды с начала мачта;
SELECT
  DISTINCT match_id
FROM
  purchase_log
WHERE
  (item_id = 42)
  AND (time > 100);
  

-- Task 7
  -- получить первые 20 строк из всех данных из таблиц с матчами и
  -- оплатами (purchase_log);
SELECT * FROM purchase_log LIMIT 20; -- They are in undefined order