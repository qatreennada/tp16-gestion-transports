INSERT INTO ligne (id, nom, type) VALUES
(1, 'T1', 'Tram'),
(2, 'F2', 'Bus Rapide');



--partie 4 :requete SQL


--1)
SELECT h.timestamp, l.nom AS ligne, s.nom AS station
FROM horaire h
JOIN station s ON s.id = h.station_id
JOIN ligne l ON l.id = h.ligne_id
WHERE s.nom = 'Gare Centre'
  AND h.timestamp >= NOW()
ORDER BY h.timestamp ASC
LIMIT 5;

--2)
SELECT DISTINCT s.id, s.nom, s.commune
FROM horaire h
JOIN station s ON s.id = h.station_id
JOIN ligne l ON l.id = h.ligne_id
WHERE l.nom = 'T1'
ORDER BY s.nom;

--3)
SELECT h.timestamp, l.nom AS ligne, s.nom AS station
FROM horaire h
JOIN station s ON s.id = h.station_id
JOIN ligne l ON l.id = h.ligne_id
WHERE EXTRACT(HOUR FROM h.timestamp) >= 7
  AND EXTRACT(HOUR FROM h.timestamp) < 9
ORDER BY h.timestamp;

--4)
SELECT s.nom, COUNT(*) AS nb_passages
FROM horaire h
JOIN station s ON s.id = h.station_id
GROUP BY s.nom
ORDER BY nb_passages DESC
LIMIT 1;
