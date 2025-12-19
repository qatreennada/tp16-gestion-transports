# PARTIE 5 – Optimisation MongoDB

## Requête analysée
Recherche des horaires compris entre 7h00 et 9h00 pour les lignes de transport.

### Requête MongoDB
```js
db.lignes.aggregate([
  { $unwind: "$horaires" },
  {
    $match: {
      "horaires.timestamp": {
        $gte: ISODate("2025-02-19T07:00:00Z"),
        $lt: ISODate("2025-02-19T09:00:00Z")
      }
    }
  }
]);
