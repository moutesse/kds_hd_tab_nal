--так как слой ods это сырые данные, все столбцы просто текстовые
CREATE TABLE ods.weather (
	icao_code text NULL,
	local_datetime text NULL,
	t_air_temperature text NULL,
	p_station_lvl text NULL,
	p0_sea_lvl text NULL,
	u_humidity text NULL,
	dd_wind_direction text NULL,
	ff_wind_speed text NULL,
	ff10_max_gust_value text NULL,
	ww_present text NULL,
	ww_recent text NULL,
	c_total_clouds text NULL,
	vv_horizontal_visibility text NULL,
	td_temperature_dewpoint text NULL,
	processed_dttm timestamp DEFAULT now() NULL
);
