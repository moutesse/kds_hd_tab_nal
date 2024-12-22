--Со слоя ods мы переносим данные об аэропорта в dds. Мы очищаем итоговую таблицу и заполняем заново,
-- изменяя форматы колонок из text в нужные

create or replace PROCEDURE etl.all_airports()
LANGUAGE sql
AS $$
    TRUNCATE TABLE dds.airport_code;
    INSERT INTO dds.airport_code (
        id,
        ident,
        "type",
        "name",
        latitude_deg,
        longitude_deg,
        elevation_ft,
        continent,
        iso_country,
        iso_region,
        municipality,
        scheduled_service,
        gps_code,
        iata_code,
        local_code,
        home_link,
        wikipedia_link,
        keywords
    )
    SELECT
        CAST(id AS INT) AS id,
        CAST(ident AS VARCHAR(100)) AS ident,
        CAST("type" AS VARCHAR(100)) AS "type",
        CAST("name" AS VARCHAR(100)) AS "name",
        CAST(latitude_deg AS FLOAT) AS latitude_deg,
        CAST(longitude_deg AS FLOAT) AS longitude_deg,
        CASE WHEN elevation_ft = '' THEN NULL ELSE CAST(elevation_ft AS INT) END AS elevation_ft,
        CAST(continent AS VARCHAR(100)) AS continent,
        CAST(iso_country AS VARCHAR(100)) AS iso_country,
        CAST(iso_region AS VARCHAR(100)) AS iso_region,
        CAST(municipality AS VARCHAR(100)) AS municipality,
        CAST(scheduled_service AS VARCHAR(100)) AS scheduled_service,
        CASE WHEN gps_code = '' THEN NULL ELSE CAST(gps_code AS VARCHAR(100)) END AS gps_code,
        CASE WHEN iata_code = '' THEN NULL ELSE CAST(iata_code AS VARCHAR(100)) END AS iata_code,
        CASE WHEN local_code = '' THEN NULL ELSE CAST(local_code AS VARCHAR(100)) END AS local_code,
        CASE WHEN home_link = '' THEN NULL ELSE CAST(home_link AS VARCHAR(100)) END AS home_link,
        CASE WHEN wikipedia_link = '' THEN NULL ELSE CAST(wikipedia_link AS VARCHAR(100)) END AS wikipedia_link,
        CASE WHEN keywords = '' THEN NULL ELSE CAST(keywords AS VARCHAR(100)) END AS keywords
    FROM ods.airport_code;
$$;

call etl.all_airports();
