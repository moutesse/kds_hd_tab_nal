-- https://datalens.yandex/l882ulf2xl4e7

SELECT airline, SUM(cancelled) AS cancelled
FROM mart.fact_departure33 GROUP BY airline ORDER BY cancelled ASC;

SELECT airline, ABS(AVG(dep_delay_min)) AS earlier
FROM mart.fact_departure33 WHERE dep_delay_min <= 0 GROUP BY airline ORDER BY earlier ASC;

SELECT airline, ABS(AVG(dep_delay_min)) AS earlier
FROM mart.fact_departure33 WHERE dep_delay_min > 0 GROUP BY airline ORDER BY earlier ASC;

WITH total AS (SELECT airline, COUNT(*) AS total_flights FROM mart.fact_departure33 WHERE cancelled = 0 GROUP BY airline)
SELECT t.airline AS airline, t.total_flights, COUNT(*) AS delayed_flights, ROUND(AVG(dep_delay_min)::numeric, 2) AS avg_delay_minutes, ROUND(100.0*COUNT(*)/t.total_flights::numeric, 2) AS percentage
FROM mart.fact_departure33 f JOIN total t ON f.airline = t.airline
WHERE f.cancelled = 0 AND f.dep_delay_min > 0 GROUP BY t.airline, t.total_flights ORDER BY percentage ASC;
