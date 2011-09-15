<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step 
    xmlns:c="http://www.w3.org/ns/xproc-step"
    xmlns:p="http://www.w3.org/ns/xproc"
    xmlns:ml="http://xmlcalabash.com/ns/extensions/marklogic" 
    xmlns:test="http://www.marklogic.com/test"
    name="xqdoc-parse"
    version="1.0"
    exclude-inline-prefixes="c ml p">
  
  <p:input port="source"/>
  <p:output port="result"/>
  
  <p:import href="../lib/library-1.0.xpl"/>
  
  <p:documentation>simple test case invoking xqdoc:parse</p:documentation>

  <p:variable name="distpath" select="/config/path"/>
  <p:filter select="/config/connection[@protocol = 'xdbc']"/>
  
  <ml:adhoc-query name="retrieve"> 
    <p:with-param name="distpath" select="$distpath"/>
    <p:input port="source">
      <p:inline>
        <query>
          xquery version "1.0-ml" encoding "UTF-8";
          
          import module namespace test = "http://www.marklogic.com/test" at "/lib/test.xqy";
          import module namespace xqdoc="http://github.com/xquery/xquerydoc" at "/xquery/xquerydoc.xq";
          
          declare variable $distpath as xs:string external;

          let $expected := xdmp:document-get(fn:concat($distpath,'/src/tests/expected/default.xml'))
          let $actual  := xqdoc:parse(
          xdmp:quote(xdmp:document-get(fn:concat($distpath,'/src/tests/examples/default.xqy'))) )
          return
             test:assertXMLEqual($expected//*:description,$actual//*:description) 
             (: NOTE - due to  timestamp can only select a portion of xml,
             will expand on this test e.g. add schematron-validate :)
        </query>
      </p:inline>
    </p:input>
    <p:input port="parameters">
      <p:empty/>
    </p:input>
    
    <p:with-option name="host" select="/connection/@host"/>
    <p:with-option name="port" select="/connection/@port"/>
    <p:with-option name="user" select="/connection/@username"/>
    <p:with-option name="password" select="/connection/@password"/>
    <p:with-option name="content-base" select="//*"/>
  </ml:adhoc-query>

  <p:documentation>
    (:
    -- Local Variables:
    -- compile-command: "/usr/local/bin/calabash -isource=config.xml -oresult=result/report.xml test.xpl"
    -- End:
    :)
  </p:documentation>

</p:declare-step>
