<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step 
    xmlns:c="http://www.w3.org/ns/xproc-step"
    xmlns:p="http://www.w3.org/ns/xproc"
    xmlns:ml="http://xmlcalabash.com/ns/extensions/marklogic" 
    xmlns:test="http://www.marklogic.com/test"
    name="process-single-doc"
    version="1.0"
    exclude-inline-prefixes="c ml p">

  <p:documentation>generates documentation of a single xquery module</p:documentation>

  <!-- config file is main import //-->
  <p:input port="source"/>

  <!-- generate xml output which is transformed by report.xpl //-->
  <p:output port="result"/>

  <!-- path of xquery document //-->
  <p:option name="xquery" required="true"/>  

  <!-- this step will run xquery test via XDBC //-->
  <p:xquery name="run"> 
    <p:with-param name="xquery" select="$xquery"/>
    <p:input port="query">
      <p:inline>
        <query>
          xquery version "1.0" encoding "UTF-8";
          import module namespace xqdoc="http://github.com/xquery/xquerydoc" at "src/xquery/xquerydoc.xq";
          declare variable $xquery as xs:string external;

          let $xquerydoc := fn:collection(fn:concat($xquery,";unparsed=yes"))
          return
            xqdoc:parse($xquerydoc)
        </query>
      </p:inline>
    </p:input>
    <p:input port="parameters">
      <p:empty/>
    </p:input>    
  </p:xquery>


  <!-- apply html transform //-->
  <p:xslt name="transform">
    <p:with-param name="source" select="'test'"/>
    
    <p:input port="stylesheet">
      <p:document href="src/lib/html-module.xsl"/>
    </p:input>
    <p:input port="parameters">
      <p:empty/>
    </p:input>    
    
  </p:xslt>


  <!-- run individual tests with  m-x compile //-->
  <p:documentation>
    (:
    -- Local Variables:
    -- compile-command: "/usr/local/bin/calabash -isource=config.xml -oresult=result/report.xml marklogic-test.xpl expected=/src/tests/expected/default.xml test=/tests/unit/marklogic/simple.xqy example=/src/tests/examples/default.xqy"
    -- End:
    :)
  </p:documentation>

</p:declare-step>
