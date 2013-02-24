<?xml version="1.0" encoding="UTF-8"?>
<!--
  Copyright (c) 2011-2012 Jim Fuller, John Snelson

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
//-->
<p:declare-step 
    xmlns:xqd="http://github.com/xquery/xquerydoc"
    xmlns:c="http://www.w3.org/ns/xproc-step"
    xmlns:p="http://www.w3.org/ns/xproc"
    xmlns:ml="http://xmlcalabash.com/ns/extensions/marklogic" 
    xmlns:cx="http://xmlcalabash.com/ns/extensions"
    name="xquerydoc"
    type="xqd:xquerydoc"
    version="1.0"
    exclude-inline-prefixes="c ml p">

  <p:documentation>generates documentation of a single xquery module</p:documentation>

  <!-- config file is main import //-->
   
  <p:input port="source"/>
 

  <!-- generate xml output which is transformed by report.xpl //-->
  <p:output port="result" />

  <!-- path of xquery document //-->
  <p:option name="xquery" required="true"/>  

  <!-- path of current dir  //-->
  <p:option name="currentdir" required="true"/>  

  <!-- path of for o/p  //-->
  <p:option name="output" required="true"/>  
  
  <!-- desired output format  //-->
  <p:option name="format" required="true"/>  
  
  <!-- import Calabash library //-->
  <p:import href="deps/xmlcalabash/library-1.0.xpl"/>
 <p:variable name="dirpath" select="if(starts-with($xquery,'/')) then
                                     $xquery else concat($currentdir,'/',$xquery)
                                    
                                     "/>

  <p:variable name="outdir1" select="replace(
                                  replace(
                                     if(starts-with($output,'/')) then
                                     $output else concat($currentdir,'/',$output),
                                     '\\','/'),
                                     ' ','%20')
                                     "/>
  <!-- APB @TODO fix for unix -->
  <p:variable name="outputdirpath" select="concat('file://',$outdir1)"/>
  <!-- import recursive directory list step //-->
  <p:import href="deps/xmlcalabash/recursive-directory-list.xpl"/>
  <p:in-scope-names name="vars"/>
 
  <cx:recursive-directory-list name="dirlist" exclude-filter=".svn">
    <p:with-option name="path" select="$dirpath"/>
  </cx:recursive-directory-list>

  <p:xslt name="generate-manifest">
    <p:input port="stylesheet">
      <p:inline>
        <xsl:stylesheet
            xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
            version="1.0">
          <xsl:template match="/">
            <manifest ts="">
              <xsl:apply-templates select="*:directory"/>
            </manifest>
          </xsl:template>
          <xsl:template match="*:directory">
            <xsl:param name="base"/>
            <xsl:apply-templates select="*:file">
              <xsl:with-param name="base" select="concat($base,'/',@name)"/>
              <xsl:with-param name="base1" select="@xml:base"/>
          </xsl:apply-templates>
          <xsl:apply-templates select="*:directory">
              <xsl:with-param name="base" select="concat($base,'/',@name)"/>
          </xsl:apply-templates>
          </xsl:template>          
          <xsl:template match="*:file[ends-with(@name,'xq') or
                               ends-with(@name,'xqm') or
                               ends-with(@name,'xqy') or ends-with(@name,'xql')]">
            <xsl:param name="base"/>
              <xsl:param name="base1"/>
              <xsl:variable name="gname" select="concat($base,'/',@name)"/>
              <file name="{@name}" base="{$base}"
                    href="{$gname}" base1="{$base1}"
                    gname="xqdoc{replace($gname,'/','_')}"/>
          </xsl:template>
          <xsl:template match="*:file"/>
        </xsl:stylesheet>
      </p:inline>
    </p:input>
    <p:input port="parameters">
      <p:pipe step="vars" port="result"/>
    </p:input>   
  </p:xslt>

  <p:for-each name="iterate">
    <p:iteration-source select="//file"/>

    <p:variable name="format" select="$format"/>

    <p:variable name="filename" select="file/@name"/>
    <p:variable name="base" select="file/@base"/>
    <p:variable name="base1" select="file/@base1"/>

    <p:variable name="gname" select="file/@gname"/>
    <p:variable name="href" select="file/@href"/>

    <p:variable name="source" select='collection(concat($base1,"?select=",$filename,";unparsed=yes"))'/>

  <p:xquery name="run"> 
    <p:with-param name="source" select='$source'/>
    <p:input port="query">
      <p:inline>
        <query>
          xquery version "1.0" encoding "UTF-8";
          import module namespace xqdoc="http://github.com/xquery/xquerydoc" at "src/xquery/xquerydoc.xq";
          import module namespace xqp="XQueryML30" at "src/xquery/parsers/XQueryML30.xq";

          declare variable $format as xs:string external;
          declare variable $source as xs:string external;

          if($format eq 'raw') then
             xqp:parse-XQuery($source)
          else  if($format eq 'raw2') then
               let $markup := xqp:parse-XQuery($source)
               let $markup := xqdoc:_simplify($markup)
               let $ns :=  xqdoc:_build_namespaces($markup)
               return xqdoc:_analyze($markup,$ns)
          else 
             xqdoc:parse($source)
        </query>
      </p:inline>
    </p:input>
    <p:input port="parameters">
      <p:pipe step="vars" port="result"/>
    </p:input>   
  </p:xquery>

<p:choose>
<p:when test="$format eq 'raw'">
  <p:store>
    <p:with-option name="href" select="concat($outputdirpath,'/',$gname,'_raw.xml')"/>
  </p:store>
</p:when>
<p:when test="$format eq 'raw2'">
  <p:store>
    <p:with-option name="href" select="concat($outputdirpath,'/',$gname,'_raw2.xml')"/>
  </p:store>
</p:when>
<p:when test="$format eq 'xqdoc'">
  <p:store>
    <p:with-option name="href" select="concat($outputdirpath,'/',$gname,'.xml')"/>
  </p:store>
</p:when>
<p:when test="$format eq 'markdown'">
  <p:xslt name="transform_markdown">
    <p:with-param name="source" select='$source'/>    
    <p:input port="stylesheet">
      <p:document href="src/lib/markdown-module.xsl"/>
    </p:input>
    <p:input port="parameters">
      <p:empty/>
    </p:input>
  </p:xslt>
  <p:store method="text">
    <p:with-option name="href" select="concat($outputdirpath,'/',$gname,'.md')"/>
  </p:store>
</p:when>
<p:otherwise>
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
    <p:with-option name="href" select="concat($outputdirpath,'/',$gname,'.html')"/>
  </p:store>
</p:otherwise>
</p:choose>
 
  </p:for-each>		

  <!-- generate xquerydoc index page  //-->
  <p:xslt name="generate-home">
  <p:input port="source">
    <p:pipe step="generate-manifest" port="result"/>
  </p:input>
    <p:input port="stylesheet">
      <p:document href="src/lib/html-index.xsl"/>
    </p:input>
    <p:input port="parameters">
      <p:empty/>
    </p:input>   
  </p:xslt>
  
</p:declare-step>
