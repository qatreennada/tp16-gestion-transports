<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="html" encoding="UTF-8" indent="yes"/>

  <xsl:template match="/horaires">
    <html>
      <head>
        <meta charset="UTF-8"/>
        <title>Horaires</title>
      </head>
      <body>
        <h2>Horaires (XML → HTML)</h2>

        <table border="1" cellpadding="6">
          <tr>
            <th>Ligne</th>
            <th>Station</th>
            <th>Heure</th>
          </tr>

          <xsl:for-each select="horaire">
            <xsl:sort select="timestamp" order="ascending"/>
            <tr>
              <td><xsl:value-of select="ligne"/></td>
              <td><xsl:value-of select="station"/></td>
              <td><xsl:value-of select="timestamp"/></td>
            </tr>
          </xsl:for-each>

        </table>
      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>
