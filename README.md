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

### Import XML (horaires.xml)
Import réalisé directement en SQL (PostgreSQL) avec `xpath()` : le fichier XML est chargé puis chaque noeud `<horaire>` est transformé en lignes dans la table `horaire`.

## PARTIE 3 – XSLT
Le fichier `xml/horaires.xslt` transforme `xml/horaires.xml` en une page HTML contenant un tableau (Ligne | Station | Heure), avec tri sur `timestamp` (bonus).


## PARTIE 4 – Requêtes (SQL + MongoDB)
Les requêtes SQL sont dans `sql/queries.sql` et les requêtes MongoDB dans `mongo/queries.js` (horaires d’une ligne, plage horaire 7h–9h, et aggregation du nombre de passages par ligne).


## PARTIE 5 – Optimisation

### Optimisation SQL
Les requêtes SQL ont été analysées avec `EXPLAIN ANALYZE` pour voir comment la base exécute les requêtes.  
Sans index, certaines requêtes parcourent toute la table, ce qui prend plus de temps.

Pour améliorer ça, des index ont été ajoutés, surtout sur les clés utilisées dans les jointures et sur les champs liés au temps (station_id, timestamp).

Les détails sont dans le fichier `explain/sql_explain.md`.

---

### Optimisation MongoDB
Les requêtes MongoDB ont été testées avec `explain("executionStats")`.  
Sans index, MongoDB fait un `COLLSCAN`, donc il lit toute la collection.

Un index a été ajouté sur `horaires.timestamp` pour rendre les recherches par heure plus rapides.  
Les détails sont dans `explain/mongo_explain.md`.
