--Со слоя stg мы переносим данные о погоде в dds. Мы очищаем итоговую таблицу и заполняем заново,
-- заполняя новые колонки согласно заданию

CREATE or replace PROCEDURE etl.dds_weather()
LANGUAGE sql
AS $$
    TRUNCATE TABLE dds.airport_weather33;
    INSERT INTO dds.airport_weather33 (
        airport_dk,
        weather_type_dk,
        cold,
        rain,
        snow,
        thunderstorm,
        drizzle,
        fog_mist,
        t,
        max_gws,
        w_speed,
        date_start,
        date_end
    )
    SELECT
        a.id AS airport_dk,
        CONCAT(
            CASE WHEN w.t_air_temperature < 0 THEN '1' ELSE '0' END,
            CASE WHEN (COALESCE(w.ww_present, '') ILIKE '%rain%' OR COALESCE(w.ww_recent, '') ILIKE '%rain%') THEN '1' ELSE '0' END,
            CASE WHEN (COALESCE(w.ww_present, '') ILIKE '%snow%' OR COALESCE(w.ww_recent, '') ILIKE '%snow%') THEN '1' ELSE '0' END,
            CASE WHEN (COALESCE(w.ww_present, '') ILIKE '%thunderstorm%' OR COALESCE(w.ww_recent, '') ILIKE '%thunderstorm%') THEN '1' ELSE '0' END,
            CASE WHEN (COALESCE(w.ww_present, '') ILIKE '%drizzle%' OR COALESCE(w.ww_recent, '') ILIKE '%drizzle%') THEN '1' ELSE '0' END,
            CASE WHEN (COALESCE(w.ww_present, '') ILIKE '%fog%' OR COALESCE(w.ww_present, '') ILIKE '%mist%' OR 
                       COALESCE(w.ww_recent, '') ILIKE '%fog%' OR COALESCE(w.ww_recent, '') ILIKE '%mist%') THEN '1' ELSE '0' END
        ) AS weather_type_dk,
        CASE WHEN w.t_air_temperature < 0 THEN 1 ELSE 0 END AS cold,
        CASE WHEN (COALESCE(w.ww_present, '') ILIKE '%rain%' OR COALESCE(w.ww_recent, '') ILIKE '%rain%') THEN 1 ELSE 0 END AS rain,
        CASE WHEN (COALESCE(w.ww_present, '') ILIKE '%snow%' OR COALESCE(w.ww_recent, '') ILIKE '%snow%') THEN 1 ELSE 0 END AS snow,
        CASE WHEN (COALESCE(w.ww_present, '') ILIKE '%thunderstorm%' OR COALESCE(w.ww_recent, '') ILIKE '%thunderstorm%') THEN 1 ELSE 0 END AS thunderstorm,
        CASE WHEN (COALESCE(w.ww_present, '') ILIKE '%drizzle%' OR COALESCE(w.ww_recent, '') ILIKE '%drizzle%') THEN 1 ELSE 0 END AS drizzle,
        CASE WHEN (COALESCE(w.ww_present, '') ILIKE '%fog%' OR COALESCE(w.ww_present, '') ILIKE '%mist%' OR COALESCE(w.ww_recent, '') ILIKE '%fog%' OR COALESCE(w.ww_recent, '') ILIKE '%mist%') THEN 1 ELSE 0 END AS fog_mist,
        w.t_air_temperature AS t,
        w.ff10_max_gust_value AS max_gws,
        w.ff_wind_speed AS w_speed,
        TO_TIMESTAMP(w.local_datetime, 'DD.MM.YYYY HH24:MI') AS date_start,
        COALESCE(
            (
                SELECT MIN(TO_TIMESTAMP(w2.local_datetime, 'DD.MM.YYYY HH24:MI'))
                FROM stg.weather33 w2
                WHERE w2.icao_code = w.icao_code AND TO_TIMESTAMP(w2.local_datetime, 'DD.MM.YYYY HH24:MI') > TO_TIMESTAMP(w.local_datetime, 'DD.MM.YYYY HH24:MI')
            ), '3000-01-01 00:00:00'::timestamp) AS date_end
    FROM stg.weather33 w INNER JOIN etl.id_translate_airport33 a ON w.icao_code = a.icao_code;
$$;

call etl.dds_weather();
