--так как слой ods это сырые данные, все столбцы просто текстовые

CREATE TABLE ods.airport_code (
	id text NULL,
	ident text NULL,
	"type" text NULL,
	"name" text NULL,
	latitude_deg text NULL,
	longitude_deg text NULL,
	elevation_ft text NULL,
	continent text NULL,
	iso_country text NULL,
	iso_region text NULL,
	municipality text NULL,
	scheduled_service text NULL,
	gps_code text NULL,
	iata_code text NULL,
	local_code text NULL,
	home_link text NULL,
	wikipedia_link text NULL,
	keywords text NULL,
	processed_dttm timestamp DEFAULT now() NULL
);
