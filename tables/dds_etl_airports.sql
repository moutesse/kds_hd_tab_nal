-- создание таблицы dds.airport_code с нужными форматами колонок и таблицы-справочника на etl

CREATE TABLE dds.airport_code33 (
	id int4 NOT NULL,
	ident varchar(100) NOT NULL,
	"type" varchar(100) NOT NULL,
	"name" varchar(100) NOT NULL,
	latitude_deg float8 NOT NULL,
	longitude_deg float8 NOT NULL,
	elevation_ft int4 NULL,
	continent varchar(100) NOT NULL,
	iso_country varchar(100) NOT NULL,
	iso_region varchar(100) NOT NULL,
	municipality varchar(100) NOT NULL,
	scheduled_service varchar(100) NOT NULL,
	gps_code varchar(100) NULL,
	iata_code varchar(100) NULL,
	local_code varchar(100) NULL,
	home_link varchar(100) NULL,
	wikipedia_link varchar(100) NULL,
	keywords varchar(100) NULL,
	processed_dttm timestamp DEFAULT now() NULL,
	CONSTRAINT airport_code_pkey PRIMARY KEY (id)
);

--решили справочник сделать именно по тем аэропортам, по которым есть полная информация
CREATE TABLE etl.id_translate_airport33 (
	id int4 NOT NULL,
	icao_code varchar NOT NULL,
	iata_code varchar NOT NULL,
	processed_dttm timestamp DEFAULT now() NULL,
	CONSTRAINT id_translate_airport_pkey PRIMARY KEY (id)
);
