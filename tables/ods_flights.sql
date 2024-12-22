--так как слой ods это сырые данные, все столбцы просто текстовые
CREATE TABLE ods.flights33 (
	"year" text NULL,
	quarter text NULL,
	"month" text NULL,
	fl_date text NULL,
	op_unique_carrier text NULL,
	tail_num text NULL,
	op_carrier_fl_num text NULL,
	origin text NULL,
	dest text NULL,
	crs_dep_time text NULL,
	dep_time text NULL,
	dep_delay_new text NULL,
	cancelled text NULL,
	cancellation_code text NULL,
	air_time text NULL,
	distance text NULL,
	weather_delay text NULL,
	processed_dttm timestamp DEFAULT now() NULL
);
