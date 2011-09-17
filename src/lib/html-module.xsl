<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
xmlns="http://www.w3.org/1999/xhtml"
xmlns:doc="http://www.xqdoc.org/1.0"
xmlns:xs="http://www.w3.org/2001/XMLSchema"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
exclude-result-prefixes="xs doc"
version="2.0">

<xsl:output method="html" encoding="UTF-8" omit-xml-declaration="yes" indent="no"/>

  <!-- generate module html //-->
  <xsl:template match="doc:xqdoc">
    <html version="-//W3C//DTD XHTML 1.1//EN">
      <head>
	<title></title>
      </head>
      <body class="home">
	<div id="main">
          <xsl:apply-templates/>
        </div>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="doc:module">
    <h2>Module</h2>
    type: <xsl:value-of select="@type"/> 
    <p>
      <xsl:value-of select="doc:comment/doc:description"/>
    </p>
    <h2>Module URI</h2>
    <xsl:value-of select="doc:uri"/>
    <h2>Variables</h2>
    
    <h2>Function Summary</h2>
    <h2>Function Detail</h2>
  </xsl:template>



  <xsl:template match="text()"/>

</xsl:stylesheet>
