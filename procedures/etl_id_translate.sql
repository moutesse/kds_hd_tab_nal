--процедура, которая заполняет справочник по аэропортам

CREATE PROCEDURE etl.id_translate()
LANGUAGE sql
AS $$
    TRUNCATE TABLE etl.id_translate_airport33;
    INSERT INTO etl.id_translate_airport33 (id, icao_code, iata_code)
    SELECT 
        id,
        gps_code AS icao_code,
        iata_code
    FROM dds.airport_code33 WHERE gps_code IS NOT null and iata_code IS NOT NULL;
$$;

call etl.id_translate();
