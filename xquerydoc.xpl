<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step 
    xmlns:c="http://www.w3.org/ns/xproc-step"
    xmlns:p="http://www.w3.org/ns/xproc"
    xmlns:ml="http://xmlcalabash.com/ns/extensions/marklogic" 
    xmlns:test="http://www.marklogic.com/test"
    name="ml-process-single-doc"
    version="1.0"
    exclude-inline-prefixes="c ml p">

  <p:documentation>generates documentation of a single xquery module </p:documentation>

  <!-- import Calabash library so we can use ml:adhoc-query step //-->
  <p:import href="src/lib/library-1.0.xpl"/>

  <!-- config file is main import //-->
  <p:input port="source"/>

  <!-- generate xml output which is transformed by report.xpl //-->
  <p:output port="result"/>

  <!-- path of xquery document //-->
  <p:option name="xquery" required="true"/>  

  <!-- obtain configuration details for accessing XDBC //-->
  <p:filter select="/config/connection[@protocol = 'xdbc']"/>

  <!-- this step will run xquery test via XDBC //-->
  <ml:adhoc-query name="run"> 
    <p:with-param name="xquery" select="$xquery"/>
    <p:input port="source">
      <p:inline>
        <query>
          xquery version "1.0-ml" encoding "UTF-8";
          import module namespace xqdoc="http://github.com/xquery/xquerydoc" at "/xquery/ml-xquerydoc.xq";
          declare variable $xquery as xs:string external;


          let $xquerydoc    :=xdmp:document-get($xquery,
          &lt;options xmlns="xdmp:document-get"&gt;
            &lt;encoding>UTF-8&lt;/encoding&gt;
            &lt;format>text&lt;/format&gt;
          &lt;/options&gt;
          )
          let $parse := xqdoc:parse($xquerydoc)
          return
           xqdoc:generate-docs('html',$parse,$xquerydoc)
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
    -- compile-command: "/usr/local/bin/calabash -isource=config.xml -oresult=result/report.xml marklogic-test.xpl expected=/src/tests/expected/default.xml test=/tests/unit/marklogic/simple.xqy example=/src/tests/examples/default.xqy"
    -- End:
    :)
  </p:documentation>

</p:declare-step>
