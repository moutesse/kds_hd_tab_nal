-- https://datalens.yandex/l882ulf2xl4e7

SELECT airline, SUM(cancelled) AS cancelled
FROM mart.fact_departure GROUP BY airline ORDER BY cancelled ASC;

SELECT airline, ABS(AVG(dep_delay_min)) AS earlier
FROM mart.fact_departure WHERE dep_delay_min <= 0 GROUP BY airline ORDER BY earlier ASC;

SELECT airline, ABS(AVG(dep_delay_min)) AS earlier
FROM mart.fact_departure WHERE dep_delay_min > 0 GROUP BY airline ORDER BY earlier ASC;
