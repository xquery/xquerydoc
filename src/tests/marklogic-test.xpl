<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step 
    xmlns:c="http://www.w3.org/ns/xproc-step"
    xmlns:p="http://www.w3.org/ns/xproc"
    xmlns:ml="http://xmlcalabash.com/ns/extensions/marklogic" 
    xmlns:test="http://www.marklogic.com/test"
    name="ml-single-test"
    version="1.0"
    exclude-inline-prefixes="c ml p">

  <p:documentation>runs a single xquerydoc test using  MarkLogic
  XQuery Processor</p:documentation>

  <!-- import Calabash library so we can use ml:adhoc-query step //-->
  <p:import href="../lib/library-1.0.xpl"/>

  <!-- config file is main import //-->
  <p:input port="source"/>

  <!-- generate xml output which is transformed by report.xpl //-->
  <p:output port="result"/>

  <!-- path of test desired to be run, for example /tests/unit/simple.xqy //-->
  <p:option name="test" required="true"/>  

  <!-- path of example xquery containing xqdoc code comments //-->
  <p:option name="example" required="true"/>  

  <!-- path of expected output  //-->
  <p:option name="expected" required="true"/>  

  <!-- path of xquerydoc dist //-->
  <p:variable name="distpath" select="/config/path"/>

  <!-- obtain configuration details for accessing XDBC //-->
  <p:filter select="/config/connection[@protocol = 'xdbc']"/>

  <!-- this step will run xquery test via XDBC //-->
  <ml:adhoc-query name="run"> 
    <p:with-param name="test" select="$test"/>
    <p:with-param name="example" select="$example"/>
    <p:with-param name="distpath" select="$distpath"/>
    <p:with-param name="expected" select="$expected"/>

    <p:input port="source">
      <p:inline>
        <query>
          xquery version "1.0-ml" encoding "UTF-8";

          declare variable $test as xs:string external;
          declare variable $example as xs:string external;
          declare variable $distpath as xs:string external;
          declare variable $expected as xs:string external;
          declare variable $t as xs:string external;

          xdmp:invoke($test,(
            xs:QName("distpath"), $distpath,
            xs:QName("example"), $example,
            xs:QName("expected"), $expected,
            xs:QName("t"), $test
            )
          )
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

  <!-- run individual tests with  m-x compile //-->
  <p:documentation>
    (:
    -- Local Variables:
    -- compile-command: "/usr/local/bin/calabash -isource=config.xml -oresult=result/report.xml marklogic-test.xpl expected=/src/tests/expected/marklogic/default.xml test=/tests/unit/marklogic/simple.xqy example=/src/tests/examples/default.xqy"
    -- End:
    :)
  </p:documentation>

</p:declare-step>
