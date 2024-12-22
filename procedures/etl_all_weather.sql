--Со слоя ods мы переносим данные о погоде в stg. Мы очищаем итоговую таблицу и заполняем заново,
-- изменяя форматы колонок из text в нужные

CREATE OR REPLACE PROCEDURE etl.all_weather()
LANGUAGE sql
AS $$
 TRUNCATE TABLE stg.weather;
 INSERT INTO stg.weather (
     icao_code, 
     local_datetime, 
     t_air_temperature, 
     p0_sea_lvl, 
     p_station_lvl, 
     u_humidity, 
     dd_wind_direction, 
     ff_wind_speed, 
     ff10_max_gust_value, 
     ww_present, 
     ww_recent, 
     c_total_clouds, 
     vv_horizontal_visibility, 
     td_temperature_dewpoint
 )
 SELECT
     CAST(icao_code AS VARCHAR(10)) AS icao_code,
     CAST(local_datetime AS VARCHAR(25)) AS local_datetime,
     CAST(t_air_temperature AS NUMERIC(3, 1)) AS t_air_temperature,
     CAST(p0_sea_lvl AS NUMERIC(4, 1)) AS p0_sea_lvl,
     CAST(p_station_lvl AS NUMERIC(4, 1)) AS p_station_lvl,
     CAST(u_humidity AS INT) AS u_humidity,
     CASE WHEN dd_wind_direction = '' THEN NULL ELSE CAST(dd_wind_direction AS VARCHAR(100)) END AS dd_wind_direction,
     CASE WHEN ff_wind_speed = '' THEN NULL ELSE CAST(ff_wind_speed AS INT) END AS ff_wind_speed,
     CASE WHEN ff10_max_gust_value = '' THEN NULL ELSE CAST(ff10_max_gust_value AS INT) END AS ff10_max_gust_value,
     CASE WHEN ww_present = '' THEN NULL ELSE CAST(ww_present AS VARCHAR(100)) END AS ww_present,
     CASE WHEN ww_recent = '' THEN NULL ELSE CAST(ww_recent AS VARCHAR(50)) END AS ww_recent,
     CAST(c_total_clouds AS VARCHAR(200)) AS c_total_clouds,
     CAST(vv_horizontal_visibility AS NUMERIC(3, 1)) AS vv_horizontal_visibility,
     CAST(td_temperature_dewpoint AS NUMERIC(3, 1)) AS td_temperature_dewpoint
 FROM ods.weather;
$$;

CALL etl.all_weather();
