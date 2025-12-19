
BEGIN;

DROP TABLE IF EXISTS _xml_in;
CREATE TEMP TABLE _xml_in (doc xml);


\copy _xml_in(doc) FROM PROGRAM 'type data\horaires.xml';

INSERT INTO horaire(ligne_id, station_id, timestamp)
SELECT
  (xpath('ligne/text()', h))[1]::text::int        AS ligne_id,
  (xpath('station/text()', h))[1]::text::int      AS station_id,
  (xpath('timestamp/text()', h))[1]::text::timestamp AS timestamp
FROM _xml_in,
     unnest(xpath('/horaires/horaire', doc)) AS h;

COMMIT;
