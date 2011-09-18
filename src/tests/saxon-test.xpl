<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step 
    xmlns:c="http://www.w3.org/ns/xproc-step"
    xmlns:p="http://www.w3.org/ns/xproc"
    xmlns:ml="http://xmlcalabash.com/ns/extensions/marklogic" 
    xmlns:test="http://www.marklogic.com/test"
    name="saxon-single-test"
    version="1.0"
    exclude-inline-prefixes="c ml p">

  <p:documentation>runs a single xquerydoc test using SAXON XQuery processor</p:documentation>

  <!-- import Calabash library  //-->
  <p:import href="../lib/library-1.0.xpl"/>

  <!-- config file is main import //-->
  <p:input port="source"/>

  <!-- generate xml output which is transformed by report.xpl //-->
  <p:output port="result"/>

  <!-- path of example xquery containing xqdoc code comments //-->
  <p:option name="expected" required="true"/>  

  <!-- path of example xquery containing xqdoc code comments //-->
  <p:option name="example" required="true"/>  

  <!-- path of xquerydoc dist //-->
  <p:variable name="distpath" select="/config/path"/>

  <!-- this step will run xquery test via XDBC //-->
  <p:xquery name="run"> 
    <p:with-param name="example" select="$example"/>
    <p:with-param name="expected" select="$expected"/>

    <p:with-param name="distpath" select="$distpath"/>
    <p:input port="query">
      <p:inline>
        <c:query>
          xquery version "1.0" encoding "UTF-8";

          import module namespace test = "http://www.marklogic.com/test" at "../lib/test.xqy";
          import module namespace xqdoc="http://github.com/xquery/xquerydoc" at "../xquery/xquerydoc.xq";

          declare variable $distpath as xs:string external;
          declare variable $expected as xs:string external;

          declare variable $example as xs:string external;
          declare variable $t as xs:string external;

          let $expectedpath  := fn:concat('file://',$distpath,$expected)
          let $expect        := fn:doc($expectedpath)
          let $xquerypath    := fn:concat('file://',$distpath,$example,';unparsed=yes')
          let $xquery        := fn:collection($xquerypath)
          let $actual        := xqdoc:parse($xquery,'test')

          return
          &lt;tests expected="{$expectedpath}" example="{$example}"&gt;
          &lt;test desc="generate xqdoc"&gt;
            &lt;expected&gt;{$expect}&lt;/expected&gt;
            &lt;actual&gt;{$actual}&lt;/actual&gt;
          &lt;/test&gt;
          &lt;/tests&gt;

        </c:query>
      </p:inline>
    </p:input>
    <p:input port="parameters">
      <p:empty/>
    </p:input>    
  </p:xquery>

  <!-- run individual tests with  m-x compile //-->
  <p:documentation>
    (:
    -- Local Variables:
    -- compile-command: "/usr/local/bin/calabash -isource=config.xml -oresult=result/Saxon/default.xml saxon-test.xpl example=/src/tests/examples/?select=default.xqy expected=/src/tests/expected/saxon/default.xml"
    -- End:
    :)
  </p:documentation>

</p:declare-step>
