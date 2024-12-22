-- https://datalens.yandex/0nnj43xa6sp0m

SELECT EXTRACT(HOUR FROM flight_scheduled_ts) AS flight_hour, SUM(cancelled) AS cancelled
FROM mart.fact_departure33 GROUP BY flight_hour ORDER BY flight_hour;

SELECT EXTRACT(HOUR FROM flight_scheduled_ts) AS flight_hour, ABS(AVG(dep_delay_min)) AS earlier
FROM mart.fact_departure33 WHERE dep_delay_min <= 0 GROUP BY flight_hour ORDER BY flight_hour;

SELECT EXTRACT(HOUR FROM flight_scheduled_ts) AS flight_hour, AVG(dep_delay_min) AS delay
FROM mart.fact_departure33 WHERE dep_delay_min > 0 GROUP BY flight_hour ORDER BY flight_hour;
