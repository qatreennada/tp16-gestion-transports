\copy station(id, nom, commune, latitude, longitude)
FROM 'data/stations.csv'
WITH (FORMAT csv, DELIMITER ';', HEADER true);