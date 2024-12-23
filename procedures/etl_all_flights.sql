--Со слоя ods мы переносим данные о полётах в stg. Мы очищаем итоговую таблицу и заполняем заново,
-- изменяя форматы колонок из text в нужные

CREATE OR REPLACE PROCEDURE etl.all_flights()
LANGUAGE sql
AS $$
 TRUNCATE TABLE stg.flights33;
 INSERT INTO stg.flights33 (
        "year", 
        quarter, 
        "month", 
        flight_date, 
        dep_time, 
        crs_dep_time, 
        air_time, 
        dep_delay_minutes, 
        cancelled, 
        cancellation_code, 
        weather_delay, 
        reporting_airline, 
        tail_number, 
        flight_number, 
        distance, 
        origin, 
        dest)
 SELECT DISTINCT
        CAST("year" AS INT) AS "year",
        CAST(quarter AS INT) AS quarter,
        CAST("month" AS INT) AS "month",
        TO_DATE(fl_date, 'MM/DD/YYYY') AS flight_date,
        CASE WHEN dep_time = '' THEN NULL ELSE CAST(dep_time AS TIME) END AS dep_time,
        CAST(crs_dep_time AS TIME) AS crs_dep_time,
        CASE WHEN air_time = '' THEN NULL ELSE CAST(air_time AS FLOAT) END AS air_time,
        CASE WHEN dep_delay_new = '' THEN NULL ELSE CAST(dep_delay_new AS FLOAT) END AS dep_delay_minutes,
        CAST(ROUND(CAST(cancelled AS NUMERIC)) AS INT) AS cancelled,
        CASE WHEN cancellation_code = '' THEN NULL ELSE CAST(cancellation_code AS CHAR(1)) END AS cancellation_code,
        CASE WHEN weather_delay = '' THEN NULL ELSE CAST(weather_delay AS FLOAT) END AS weather_delay,
        CAST(op_unique_carrier AS VARCHAR(100)) AS reporting_airline,
        CAST(tail_num AS VARCHAR(100)) AS tail_number,
        CAST(op_carrier_fl_num AS VARCHAR(100)) AS flight_number,
        CASE WHEN distance = '' THEN NULL ELSE CAST(distance AS FLOAT) END AS distance,
        CAST(origin AS VARCHAR(100)) AS origin,
        CAST(dest AS VARCHAR(100)) AS dest
   FROM ods.flights33 ON CONFLICT (flight_date, flight_number, origin, dest, crs_dep_time) DO NOTHING;
$$;

call etl.all_flights();
