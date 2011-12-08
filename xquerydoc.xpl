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
  
  <!-- import Calabash library //-->
  <p:import href="src/lib/library-1.0.xpl"/>

  <!-- import recursive directory list step //-->
  <p:import href="src/lib/recursive-directory-list.xpl"/>

  <p:variable name="dirpath" select="if(starts-with($xquery,'/')) then
                                     $xquery else concat($currentdir,'/',$xquery)"/>

  <p:variable name="outputdirpath" select="if(starts-with($output,'/')) then
                                     $output else concat($currentdir,'/',$output)"/>

  <cx:recursive-directory-list name="dirlist"
                               include-filter="^(.)*.xq(.)*$"
                               exclude-filter="(XQueryML10.xq|XQueryV10.xq|XQueryV30.xq)">
    <p:with-option name="depth" select="3"/>
    <p:with-option name="path" select="$dirpath"/>
  </cx:recursive-directory-list>


  <p:for-each name="iterate">
    <p:iteration-source select="/c:directory/c:file"/>

    <p:variable name="filename" select="c:file/@name"/>
    <p:variable name="source" select='collection(concat($dirpath,"?select=",$filename,";unparsed=yes"))'/>

  <!-- this step will run xquerydoc.xq on supplied xquery document //-->
  <p:xquery name="run"> 
    <p:with-param name="source" select='$source'/>
    <p:input port="query">
      <p:inline>
        <query>
          xquery version "1.0" encoding "UTF-8";
          import module namespace xqdoc="http://github.com/xquery/xquerydoc" at "src/xquery/xquerydoc.xq";

          declare variable $source as xs:string external;

          xqdoc:parse($source)
        </query>
      </p:inline>
    </p:input>
    <p:input port="parameters">
      <p:empty/>
    </p:input>    
  </p:xquery>

  <!-- apply html transform //-->
  <p:xslt name="transform">
    <p:with-param name="source" select='$source'/>    
    <p:input port="stylesheet">
      <p:document href="src/lib/html-module.xsl"/>
    </p:input>
    <p:input port="parameters">
      <p:empty/>
    </p:input>    
  </p:xslt>

  <p:store>
    <p:with-option name="href" select="concat('file://',$outputdirpath,'/',$filename,'.html')"/>
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


  <!-- run pipeline manually in emacs with m-x compile //-->
  <p:documentation>
    (:
    -- Local Variables:
    -- compile-command: "/usr/local/bin/calabash -isource=$XQUERYDOC_HOME/etc/config.xml -oresult=$OUTPUT/index.html $XQUERYDOC_HOME/xquerydoc.xpl xquery=$XQUERY output=$OUTPUT currentdir=$CURRENTDIR format=$FORMAT"
    -- End:
    :)
  </p:documentation>


</p:declare-step>
