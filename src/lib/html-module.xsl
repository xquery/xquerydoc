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
        <style type="text/css">
          body {
          font-family: Helvetica;
          padding: 0.5em  1em;
          }
          pre {
          font-family: Inconsolata, Consolas, monospace;
          }
          ol.results {
          padding-left: 0;
          }
          .result {
          border-top: solid 4px;
          padding: 0.25em 0.5em;
          font-size: 85%;
          }
          .footer {
          border-top: solid 4px;
          padding: 0.25em 0.5em;
          font-size: 85%;
          color: #999;
          }
          li.result {
          list-style-position: inside;
          list-style: none;
          height:140px;
          }
          .result h3 {
          font-weight: normal;
          font-size: inherit;
          margin: 0;
          }
          .result.fail h3 {
          color: red;
          }
          .pass {
          border-color: green;
          }
          .fail {
          border-color: red;
          }
          h2 {
          display: inline-block;
          margin: 0;
          }
          h2+div.stats {
          display: inline-block;
          margin-left: 1em;
          }
          strong.fail, 
          h2.fail {
          border: none;
          color: red;
          }
          h2.fail:before {
          content: "✘ ";
          }
          h2.pass:before {
          content: "✔ ";
          }
          h2 a,
          .result h3 a {
          text-decoration: inherit;
          color: inherit;
          }
          .fail .message {
          font-weight: bold;
          }
          .namespace {
          margin-left: 1em;
          color: #999;
          }
          .namespace:before {
          content: "{";
          }
          .namespace:after {
          content: "}";
          }
          table{
          width:75%;
          float:right;
          }
          td {
          height:100px;
          width:50%;
          vertical-align:text-top;
          }
        </style>
        <link href="src/tests/result/resource/prettify/prettify.css" type="text/css" rel="stylesheet" />
        <script type="text/javascript" src="src/tests/result/resource/prettify/prettify.js">&#160;</script>

      </head>
      <body class="home">
	<div id="main">
          <xsl:apply-templates/>
        </div>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="doc:module">
    <h1>Module</h1>
    type: <xsl:value-of select="@type"/> 
    <p>
      <xsl:apply-templates select="doc:comment/doc:description"/>
    </p>
    <h3>Module URI</h3>
    <div class="namespace"><xsl:value-of select="doc:uri"/></div>
    <br/>
    <xsl:apply-templates/>
  </xsl:template>


  <xsl:template match="doc:variables">
    <h3>Variables</h3>
    <xsl:apply-templates select="doc:variable"/>
  </xsl:template>

  <xsl:template match="doc:variable">
    <xsl:copy-of select="."/>
  </xsl:template>

  <xsl:template match="doc:functions">
    <h3>Functions</h3>
    <xsl:apply-templates select="doc:function"/>
  </xsl:template>

  <xsl:template match="doc:function">
    <h4><u>Function:<xsl:value-of select="doc:name"/></u></h4>
    
     <pre class="prettyprint"><xsl:value-of select="doc:signature"/></pre>

    <h5>Params</h5>
    <xsl:apply-templates select="doc:parameters"/>

    <h5>Description</h5>
    <xsl:apply-templates select="doc:comment"/>

    <h5>Returns</h5>
    <xsl:apply-templates select="doc:returns"/>

  </xsl:template>


  <xsl:template match="doc:parameters">
    <ul>
      <xsl:apply-templates select="doc:parameter"/>
    </ul>
  </xsl:template>

  <xsl:template match="doc:parameter">
    <li><xsl:value-of select="doc:name"/>: <xsl:value-of select="doc:type"/></li>
  </xsl:template>


  <xsl:template match="doc:return">
    <ul><li><xsl:value-of select="@occurrencee"/>: <xsl:value-of select="."/></li></ul>
  </xsl:template>



  <xsl:template match="doc:comment">
    <xsl:apply-templates select="." mode="custom"/>
  </xsl:template>

  <xsl:template match="doc:description" mode="custom">
    <p><xsl:apply-templates select="."/></p>
  </xsl:template>

  <xsl:template match="*:p" mode="custom">
    <p><xsl:copy-of select="."/></p>
  </xsl:template>

  <xsl:template match="*:pre">
     <pre class="prettyprint"><xsl:copy-of select="."/></pre>
  </xsl:template>


  <!--xsl:template match="doc:custom">
    <xsl:copy/>
  </xsl:template>

  <xsl:template match="doc:param">
    <xsl:copy/>
  </xsl:template>

  <xsl:template match="doc:author">
    <xsl:copy/>
  </xsl:template>

  <xsl:template match="doc:version">
    <xsl:copy/>
  </xsl:template//-->


  <xsl:template match="text()"/>


</xsl:stylesheet>
