<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step 
    xmlns:c="http://www.w3.org/ns/xproc-step"
    xmlns:p="http://www.w3.org/ns/xproc"
    xmlns:ml="http://xmlcalabash.com/ns/extensions/marklogic" 
    xmlns:cx="http://xmlcalabash.com/ns/extensions"
    name="xquerydoc-process"
    version="1.0"
    exclude-inline-prefixes="c ml p">

  <p:documentation>generates documentation of a single xquery module</p:documentation>

  <!-- import Calabash library //-->
  <p:import href="src/lib/library-1.0.xpl"/>

  <!-- import recursive directory list step //-->
  <p:import href="src/lib/recursive-directory-list.xpl"/>

  <!-- config file is main import //-->
  <p:input port="source"/>

  <!-- generate xml output which is transformed by report.xpl //-->
  <p:output port="result"/>

  <!-- path of xquery document //-->
  <p:option name="xquery" required="true"/>  

  <!-- path of current dir  //-->
  <p:option name="currentdir" required="true"/>  

  <!-- path of current dir  //-->
  <p:option name="output" required="true"/>  

  <!-- desired output format  //-->
  <p:option name="format" required="true"/>  

  <cx:recursive-directory-list name="dirlist"
                               include-filter="^(.)*.xq$"
                               exclude-filter="(XQueryML10.xq|XQueryV10.xq|XQueryV30.xq)">
    <p:with-option name="path" select="concat($currentdir,'/',$xquery)"/>
  </cx:recursive-directory-list>

  <p:variable name="dirpath" select="concat($currentdir,'/',$xquery)"/>

  <p:for-each name="iterate">
    <p:iteration-source select="/c:directory/c:file"/>
    <p:variable name="filename" select="c:file/@name"/>

  <!-- this step will run xquerydoc.xq on supplied xquery document //-->
  <p:xquery name="run"> 
    <p:with-param name="currentdir" select="$currentdir"/>
    <p:with-param name="format"     select="$format"/>
    <p:with-param name="dirpath"  select="$dirpath"/>
    <p:with-param name="filename"  select="$filename"/>

    <p:input port="query">
      <p:inline>
        <query>
          xquery version "1.0" encoding "UTF-8";
          import module namespace xqdoc="http://github.com/xquery/xquerydoc" at "src/xquery/xquerydoc.xq";

          declare variable $format as xs:string external;
          declare variable $currentdir as xs:string external;
          declare variable $dirpath as xs:string external;
          declare variable $filename as xs:string external;

          let $xquerydoc := fn:collection(fn:concat($dirpath,'?select=',$filename,";unparsed=yes")) 
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

  <p:store>
    <p:with-option name="href" select="if
                                       (starts-with($output,'/'))
                                       then
                                       concat('file://',$output,'/',$filename,'.html')
                                       else
                                       concat('file://',$currentdir,'/',$output,'/',$filename,'.html')"/>
  </p:store>

  </p:for-each>		


  <!-- generate xquerydoc index page //-->
  <p:xslt name="generate-home">
  <p:input port="source">
    <p:pipe step="dirlist" port="result"/>
  </p:input>
    <p:input port="stylesheet">
      <p:document href="src/lib/html-index.xsl"/>
    </p:input>
    <p:input port="parameters">
      <p:empty/>
    </p:input>   
  </p:xslt>


  <!-- run pipeline manually with m-x compile //-->
  <p:documentation>
    (:
    -- Local Variables:
    -- compile-command: "/usr/local/bin/calabash -isource=$XQUERYDOC_HOME/etc/config.xml -oresult=$OUTPUT/index.html $XQUERYDOC_HOME/xquerydoc.xpl xquery=$XQUERY output=$OUTPUT currentdir=$CURRENTDIR format=$FORMAT"
    -- End:
    :)
  </p:documentation>


</p:declare-step>
