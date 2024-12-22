CREATE PROCEDURE etl.mart_fact_departure()
LANGUAGE sql
AS $$
    TRUNCATE TABLE mart.fact_departure33;
    INSERT INTO mart.fact_departure33 (
        airport_origin_dk,
        airport_destination_dk,
        flight_scheduled_ts,
        flight_number,
        weather_type_dk,
        flight_actual_time,
        distance,
        tail_number,
        airline,
        dep_delay_min,
        cancelled,
        cancellation_code,
        max_gws,
        w_speed,
        air_time
    )
    SELECT
        f.airport_origin_dk,
        f.airport_dest_dk AS airport_destination_dk,
        f.flight_dep_scheduled_ts AS flight_scheduled_ts,
        f.flight_number_reporting_airline AS flight_number,
        w.weather_type_dk,
        f.flight_dep_actual_ts AS flight_actual_time,
        f.distance,
        f.tail_number,
        f.report_airline AS airline,
        f.dep_delay_minutes AS dep_delay_min,
        f.cancelled,
        f.cancellation_code,
        w.max_gws,
        w.w_speed,
        f.air_time
    FROM dds.flights33 f JOIN dds.airport_weather33 w ON f.airport_origin_dk = w.airport_dk AND f.flight_dep_scheduled_ts > w.date_start AND f.flight_dep_scheduled_ts <= w.date_end;
$$;

CALL etl.mart_fact_departure();
