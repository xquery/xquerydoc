<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
xmlns="http://www.w3.org/1999/xhtml"
xmlns:doc="http://www.xqdoc.org/1.0"
xmlns:xs="http://www.w3.org/2001/XMLSchema"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:fn="http://www.w3.org/2005/02/xpath-functions"
exclude-result-prefixes="xs doc"
version="2.0">

<xsl:output method="xhtml" encoding="UTF-8" omit-xml-declaration="yes" indent="no"/>

  <!-- generate module html //-->
  <xsl:template match="doc:xqdoc">
    <html version="-//W3C//DTD XHTML 1.1//EN">
      <head>
	<title>xqDoc - </title>
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
    <br/>
    <xsl:apply-templates/>
  </xsl:template>


  <xsl:template match="doc:variables">
    <h2>Variables</h2>
    <xsl:apply-templates select="doc:variable"/>
  </xsl:template>

  <xsl:template match="doc:variable">

  </xsl:template>

  <xsl:template match="doc:functions">
    <h2>Function Summary</h2>
    <xsl:apply-templates select="doc:function"/>
  </xsl:template>

  <xsl:template match="doc:function">
    <h4>name:<xsl:value-of select="doc:name"/></h4>
    signature: <xsl:value-of select="doc:signature"/>
    parameters: <xsl:apply-templates select="doc:parameters"/>
  </xsl:template>

  <xsl:template match="doc:parameters">
    <ul>
      <xsl:apply-templates select="doc:parameter"/>
    </ul>
  </xsl:template>

  <xsl:template match="doc:parameter">
    <li><xsl:value-of select="doc:name"/>: <xsl:value-of select="doc:type"/></li>
  </xsl:template>

  <xsl:template match="text()"/>

</xsl:stylesheet>
