CREATE TABLE mart.fact_departure33 (
    airport_origin_dk INT NOT NULL,
    airport_destination_dk INT NOT NULL,
    flight_scheduled_ts TIMESTAMP NOT NULL,
    flight_number VARCHAR(15) NOT NULL,
    weather_type_dk BPCHAR(6),
    flight_actual_time TIMESTAMP,
    distance FLOAT8,
    tail_number VARCHAR(10),
    airline VARCHAR(10),
    dep_delay_min FLOAT8,
    cancelled INT,
    cancellation_code BPCHAR(1),
    max_gws INT,
    w_speed INT,
    air_time FLOAT8,
    processed_dttm TIMESTAMP DEFAULT NOW(),
    CONSTRAINT fact_departure_pk PRIMARY KEY (airport_origin_dk, airport_destination_dk, flight_scheduled_ts, flight_number)
);
