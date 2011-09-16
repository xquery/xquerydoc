<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step 
    xmlns:c="http://www.w3.org/ns/xproc-step"
    xmlns:p="http://www.w3.org/ns/xproc"
    xmlns:ml="http://xmlcalabash.com/ns/extensions/marklogic" 
    xmlns:test="http://www.marklogic.com/test"
    name="unit-test-report"
    version="1.0"
    exclude-inline-prefixes="c ml p">

  <p:import href="../lib/library-1.0.xpl"/>
	
  <p:input port="source"/>
  <p:output port="result"/>

  <p:option name="processor" required="true"/>

  <p:documentation>generate unit test report</p:documentation>

  <p:directory-list include-filter=".*\.xml">
      <p:with-option name="path" select="concat('result/',$processor)"/>
  </p:directory-list>

  <p:for-each name="iterate">
    <p:iteration-source select="/c:directory/c:*"/>
    <p:load> 
      <p:with-option name="href" select="concat('result/',$processor,'/',c:file/@name)"/>
    </p:load>   
  </p:for-each>		
  <p:wrap-sequence wrapper="results"/>

  <p:xslt>
    <p:with-param name="title" select="concat($processor,' xquerydoc Unit Tests')" port="parameters"/>
    <p:input port="stylesheet">
      <p:document href="result/unit-report.xsl"/>
    </p:input>  
  </p:xslt>

<p:documentation>
(:
-- Local Variables:
-- compile-command: "/usr/local/bin/calabash -isource=config.xml -oresult=result/report.html report.xpl processor=MarkLogic"
-- End:
:)
</p:documentation>

</p:declare-step>


