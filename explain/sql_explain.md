# PARTIE 5 – Optimisation SQL

## Requête 1 – 5 prochaines arrivées à "Gare Centre"

### Requête
```sql
SELECT h.timestamp, l.nom, s.nom
FROM horaire h
JOIN station s ON s.id = h.station_id
JOIN ligne l ON l.id = h.ligne_id
WHERE s.nom = 'Gare Centre'
ORDER BY h.timestamp
LIMIT 5;
