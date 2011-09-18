<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="2.0">
  <xsl:output omit-xml-declaration="yes" method="html" encoding="utf-8" indent="yes" />
  <xsl:strip-space elements="*"/> 

  <xsl:param name="title"/>
  <xsl:variable name="total" select="count(//*:test)"/>
  <xsl:variable name="pass" select="count(//*:test[ deep-equal(actual/node(),expected/node())])"/>
  <xsl:variable name="fail" select="$total - $pass"/>
  <xsl:template match="/">
    <html>
      <head>
        <meta http-equiv="content-type" content="text/html; charset=utf-8" />
        <title><xsl:value-of select="$title"/></title>
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

	<script src="../../lib/prettify.js"
                type="text/javascript">&#160; </script>
	<script src="../../lib/lang-xq.js"
                type="text/javascript">&#160; </script>
	<link rel="stylesheet" type="text/css" href="../../lib/prettify.css">&#160;</link>

      </head>
      <body onload="prettyPrint()">
        <h1><xsl:value-of select="$title"/> Results</h1>
        <p> <strong>
<xsl:value-of select="round(($pass div ($pass + $fail)) * 100)"/>%
pass rate: 
</strong><strong class="fail"><xsl:value-of select="$fail"/></strong> failed tests and <strong><xsl:value-of select="$pass"/></strong> passed tests.</p>
          <xsl:apply-templates/>
        <br/><br/>
        <div class="footer"><p
                                style="text-align:right"><i><xsl:value-of
                                select="current-dateTime()"/></i></p></div>
	<script type="application/javascript">
	  window.onload = function(){ prettyPrint(); }
	</script>
      </body>
    </html>
  </xsl:template>
  <xsl:template match="*:tests">
    <h2> [ unit-test: <xsl:value-of
    select="substring-after(@t,'/tests/unit')"/> ] [ example: <xsl:value-of
    select="substring-after(@example,'/src/tests')"/>]<span
    style="font-size:75%;color:grey"> <xsl:value-of select="@name"/> 
 </span></h2>
    <ol class="results">
      <xsl:apply-templates/>
    </ol>
  </xsl:template>
  <xsl:template match="*:test[deep-equal(actual/node(), expected/node())]">
    <li class="result pass">
      <h3><input name="test" value="" type="checkbox" checked="checked"><b><xsl:value-of select="@name"/>.</b></input>
      <a href="?test="><xsl:value-of select="@desc"/> <span
      class="namespace">ns: <xsl:value-of select="namespace-uri(actual/node())"/></span></a>
      <table>
        <thead>
          <th>expected  (<xsl:value-of select="../@expected"/>)</th>
          <th>actual</th>
        </thead>
        <tbody><tr>
          <td>
            <pre style="border: 1px solid #888;padding: 2px"
><textarea rows="5" cols="60"><xsl:copy-of
                                               select="expected/node()"/></textarea></pre>
          </td>
          <td>
            <pre style="border: 1px solid #888;padding: 2px"
><textarea rows="5" cols="60"><xsl:copy-of
                                               select="actual/node()"/></textarea></pre>
          </td>
        </tr>
        </tbody>
      </table>
      </h3><br/>
    </li>
  </xsl:template>
  <xsl:template match="*:test">
    <li class="result fail">
      <h3><input name="test" value="" type="checkbox"><b><xsl:value-of select="@name"/>.</b></input>
      <a href="?test="><xsl:value-of select="@desc"/> <span class="namespace">ns: <xsl:value-of select="namespace-uri(actual/node())"/></span></a>
      <table>
        <thead>
          <th>expected  (<xsl:value-of select="../@expected"/>)</th>
          <th>actual </th>
        </thead>
        <tbody>
          <tr>
          <td>
            <pre style="border: 1px solid #888;padding: 2px"
><textarea rows="5" cols="60"><xsl:copy-of
                                               select="expected/node()"/></textarea></pre>
          </td>
          <td>
            <pre style="border: 1px solid #888;padding: 2px"
><textarea rows="5" cols="60"><xsl:copy-of
                                               select="actual/node()"/></textarea></pre>
          </td>
        </tr>
        </tbody>
      </table>
      </h3><br/>
    </li>
  </xsl:template>
</xsl:stylesheet>
