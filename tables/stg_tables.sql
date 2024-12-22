-- таблицы из презентации, но мало ли надо

CREATE TABLE stg.flights33 (
	"year" int4 NOT NULL,
	quarter int4 NULL,
	"month" int4 NOT NULL,
	flight_date date NOT NULL,
	dep_time time NULL,
	crs_dep_time time NOT NULL,
	air_time float8 NULL,
	dep_delay_minutes float8 NULL,
	cancelled int4 NOT NULL,
	cancellation_code bpchar(1) NULL,
	weather_delay float8 NULL,
	reporting_airline varchar(10) NULL,
	tail_number varchar(10) NULL,
	flight_number varchar(15) NOT NULL,
	distance float8 NULL,
	origin varchar(10) NOT NULL,
	dest varchar(10) NOT NULL,
	processed_dttm timestamp DEFAULT now() NULL,
	CONSTRAINT flights_pkey PRIMARY KEY (flight_date, flight_number, origin, dest, crs_dep_time)
);

CREATE TABLE stg.weather (
	icao_code varchar(10) NOT NULL,
	local_datetime varchar(25) NOT NULL,
	t_air_temperature numeric(3, 1) NOT NULL,
	p0_sea_lvl numeric(4, 1) NOT NULL,
	p_station_lvl numeric(4, 1) NOT NULL,
	u_humidity int4 NOT NULL,
	dd_wind_direction varchar(100) NULL,
	ff_wind_speed int4 NULL,
	ff10_max_gust_value int4 NULL,
	ww_present varchar(100) NULL,
	ww_recent varchar(50) NULL,
	c_total_clouds varchar(200) NOT NULL,
	vv_horizontal_visibility numeric(3, 1) NOT NULL,
	td_temperature_dewpoint numeric(3, 1) NOT NULL,
	processed_dttm timestamp DEFAULT now() NOT NULL,
	CONSTRAINT weather_pkey PRIMARY KEY (icao_code, local_datetime)
);
