--процедура, которая заполняет справочник по аэропортам

CREATE PROCEDURE etl.id_translate()
LANGUAGE sql
AS $$
    TRUNCATE TABLE etl.id_translate_airport;
    INSERT INTO etl.id_translate_airport (id, icao_code, iata_code)
    SELECT 
        id,
        gps_code AS icao_code,
        iata_code
    FROM dds.airport_code WHERE gps_code IS NOT null and iata_code IS NOT NULL;
$$;

call etl.id_translate();
