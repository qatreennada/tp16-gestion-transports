# tp16-gestion-transports

## Contexte
Ce projet correspond au **TP n°16 – Gestion des données du Web**.  
L’objectif est de réaliser un prototype de système d’information pour gérer un service de transports urbains (stations, lignes, horaires et véhicules) à partir de données fournies sous différents formats (CSV, JSON, XML).

---

## PARTIE 1 – Modélisation (SQL & NoSQL)

### Modélisation SQL
Le schéma relationnel est composé des tables suivantes :
- station (id, nom, commune, latitude, longitude)
- ligne (id, nom, type)
- vehicule (id, modele, capacite)
- horaire (id, ligne_id, station_id, timestamp)

Chaque table possède une clé primaire **id**.  
La table **horaire** contient deux clés étrangères : `ligne_id` et `station_id`.

### Justification de la 3FN
La base est en troisième forme normale (3FN) car chaque table représente une seule entité.  
Les attributs dépendent uniquement de la clé primaire et il n’y a pas de dépendance transitive.  
Les informations ne sont pas dupliquées, ce qui évite les redondances.

### Index SQL
Deux index ont été définis :
- un index sur `(station_id, timestamp)` pour optimiser les recherches des prochaines arrivées dans une station
- un index sur `timestamp` pour les requêtes par plage horaire

---

### Modélisation NoSQL (MongoDB)
Pour MongoDB, les horaires sont intégrés directement dans les documents **ligne** (embedding).  
Les véhicules sont stockés dans une collection séparée et référencés depuis les lignes (referencing).

### Avantages / Inconvénients
L’embedding permet un accès rapide aux horaires d’une ligne mais peut rendre les documents plus volumineux.  
Le referencing évite la duplication des données mais peut nécessiter une requête supplémentaire.

---

## PARTIE 2 – Imports

### Import CSV (stations.csv)
Les stations sont importées dans la base SQL à partir du fichier `stations.csv` à l’aide d’un script SQL (`import_stations.sql`).

Les champs importés sont : id, nom, commune, latitude et longitude.

### Import JSON (lignes.json)
Les données du fichier `lignes.json` ont été importées dans la base SQL à l’aide de requêtes `INSERT INTO`.
