-- https://datalens.yandex/5ssiddffypoqr

SELECT 
    CASE 
        WHEN SUBSTRING(weather_type_dk, 1, 1)='1' THEN 'Cold'
        WHEN SUBSTRING(weather_type_dk, 2, 1)='1' THEN 'Rain'
        WHEN SUBSTRING(weather_type_dk, 3, 1)='1' THEN 'Snow'
        WHEN SUBSTRING(weather_type_dk, 4, 1)='1' THEN 'Thunderstorm'
        WHEN SUBSTRING(weather_type_dk, 5, 1)='1' THEN 'Drizzle'
        WHEN SUBSTRING(weather_type_dk, 6, 1)='1' THEN 'Fog_Mist' ELSE 'Clear' END AS weather,
    ABS(AVG(dep_delay_min)) AS earlier
FROM mart.fact_departure WHERE dep_delay_min <=0 GROUP BY weather ORDER BY earlier ASC;
