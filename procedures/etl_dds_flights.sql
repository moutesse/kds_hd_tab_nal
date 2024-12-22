--Со слоя stg мы переносим данные о полетах в dds. Мы очищаем итоговую таблицу и заполняем заново,
-- заполняя новые колонки согласно заданию

CREATE OR REPLACE PROCEDURE etl.dds_flights()
LANGUAGE sql
AS $$
    TRUNCATE TABLE dds.flights;
    INSERT INTO dds.flights (
        "year", 
        quarter, 
        "month", 
        flight_scheduled_date, 
        flight_actual_date, 
        flight_dep_scheduled_ts, 
        flight_dep_actual_ts, 
        report_airline, 
        tail_number, 
        flight_number_reporting_airline, 
        airport_origin_dk, 
        origin_code, 
        airport_dest_dk, 
        dest_code, 
        dep_delay_minutes, 
        cancelled, 
        cancellation_code, 
        weather_delay, 
        air_time, 
        distance
    )
    SELECT
        f."year",
        f.quarter,
        f."month",
        f.flight_date AS flight_scheduled_date,
        CASE 
            WHEN f.cancelled = 1 THEN NULL
            ELSE (TO_TIMESTAMP(f.flight_date || ' ' || f.crs_dep_time, 'YYYY.MM.DD HH24:MI') + f.dep_delay_minutes * INTERVAL '1 minute')::date END AS flight_actual_date,
        TO_TIMESTAMP(f.flight_date || ' ' || f.crs_dep_time, 'YYYY.MM.DD HH24:MI') AS flight_dep_scheduled_ts,
        CASE 
            WHEN f.cancelled = 1 THEN NULL
            ELSE TO_TIMESTAMP(f.flight_date || ' ' || f.crs_dep_time, 'YYYY.MM.DD HH24:MI') + f.dep_delay_minutes * INTERVAL '1 minute' END AS flight_dep_actual_ts,
        f.reporting_airline AS report_airline,
        f.tail_number,
        f.flight_number AS flight_number_reporting_airline,
        (SELECT id FROM dds.airport_code WHERE iata_code = f.origin LIMIT 1) AS airport_origin_dk,
        f.origin AS origin_code,
        (SELECT id FROM dds.airport_code WHERE iata_code = f.dest LIMIT 1) AS airport_origin_dk,
        f.dest AS dest_code,
        f.dep_delay_minutes,
        f.cancelled,
        f.cancellation_code,
        f.weather_delay,
        f.air_time,
        f.distance
    FROM stg.flights f;
$$;

call etl.dds_flights();
