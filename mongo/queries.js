
//partie 4 :mongoDB
//1)
db.lignes.find(
  { nom: "T1" },
  { _id: 0, nom: 1, horaires: 1 }
);

//2)
db.lignes.aggregate([
  { $unwind: "$horaires" },
  {
    $match: {
      "horaires.timestamp": {
        $gte: ISODate("2025-02-19T07:00:00Z"),
        $lt: ISODate("2025-02-19T09:00:00Z")
      }
    }
  },
  {
    $project: {
      _id: 0,
      ligne: "$nom",
      station_id: "$horaires.station_id",
      timestamp: "$horaires.timestamp"
    }
  },
  { $sort: { timestamp: 1 } }
]);

//3)
db.lignes.aggregate([
  {
    $project: {
      _id: 0,
      nom: 1,
      type: 1,
      nb_passages: { $size: "$horaires" }
    }
  },
  { $sort: { nb_passages: -1 } }
]);
