<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:template match="/">
        <html>
            <body>
                <h2>CORRECCIÓN</h2>
                <table border="1">
                    <tr bgcolor="#9acd32">
                        <th style="text-align:left">Pregunta</th>
                        <th style="text-align:left">Respuesta</th>
                    </tr>
                    <xsl:for-each select="questions/question">
                        <tr>
                            <td>
                                <xsl:value-of select="text"/>
                            </td>
                            <td>
                                <xsl:value-of select="correct"/>
                            </td>
                        </tr>
                    </xsl:for-each>
                </table>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>