-- таблицы из презентации, но мало ли

CREATE TABLE dds.flights (
	"year" int4 NULL,
	quarter int4 NULL,
	"month" int4 NULL,
	flight_scheduled_date date NULL,
	flight_actual_date date NULL,
	flight_dep_scheduled_ts timestamp NOT NULL,
	flight_dep_actual_ts timestamp NULL,
	report_airline varchar(10) NOT NULL,
	tail_number varchar(10) NOT NULL,
	flight_number_reporting_airline varchar(15) NOT NULL,
	airport_origin_dk int4 NULL,
	origin_code varchar(5) NOT NULL,
	airport_dest_dk int4 NULL,
	dest_code varchar(5) NOT NULL,
	dep_delay_minutes float8 NULL,
	cancelled int4 NOT NULL,
	cancellation_code bpchar(1) NULL,
	weather_delay float8 NULL,
	air_time float8 NULL,
	distance float8 NULL,
	processed_dttm timestamp DEFAULT now() NULL,
	CONSTRAINT lights_pk PRIMARY KEY (flight_dep_scheduled_ts, flight_number_reporting_airline, origin_code, dest_code)
);

CREATE TABLE dds.airport_weather (
	airport_dk int4 NOT NULL,
	weather_type_dk bpchar(6) NOT NULL,
	cold int2 DEFAULT 0 NULL,
	rain int2 DEFAULT 0 NULL,
	snow int2 DEFAULT 0 NULL,
	thunderstorm int2 DEFAULT 0 NULL,
	drizzle int2 DEFAULT 0 NULL,
	fog_mist int2 DEFAULT 0 NULL,
	t int4 NULL,
	max_gws int4 NULL,
	w_speed int4 NULL,
	date_start timestamp NOT NULL,
	date_end timestamp DEFAULT '3000-01-01 00:00:00'::timestamp without time zone NOT NULL,
	processed_dttm timestamp DEFAULT now() NULL,
	CONSTRAINT airport_weather_pkey PRIMARY KEY (airport_dk, date_start)
);
