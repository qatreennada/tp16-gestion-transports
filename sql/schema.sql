
CREATE TABLE station(
    id INT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    commune VARCHAR(100) NOT NULL,
    latitude VARCHAR(9,6) NOT NULL,
    longitude DECIMAL(9,6) NOT NULL
);


CREATE TABLE ligne(
    id INT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    typee VARCHAR(50) NOT NULL
);


CREATE TABLE vehicule (
    id VARCHAR(20) PRIMARY KEY,
    modele VARCHAR(100) NOT NULL,
    capacite INT NOT NULL CHECK (capacite > 0)
);


CREATE TABLE horaire (
    id SERIAL PRIMARY KEY,
    ligne_id INT NOT NULL REFERENCES ligne(id) ON DELETE CASCADE,
    station_id INT NOT NULL REFERENCES station(id) ON DELETE CASCADE,
    timestamp TIMESTAMP NOT NULL
);


CREATE INDEX idx_horaire_station_timestamp ON horaire(station_id, timestamp);
CREATE INDEX idx_horaire_timestamp ON horaire(timestamp);