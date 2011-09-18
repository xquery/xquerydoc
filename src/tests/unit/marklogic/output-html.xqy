xquery version "1.0-ml" encoding "UTF-8";

(:~
: This module tests the output of html generated documentation
: from MarkLogic flavoured XQuery containing xqDoc commenting.

: @author Jim Fuller
: @version 1.0
:
: @return element(tests) 
:)

import module namespace test = "http://www.marklogic.com/test" at "/lib/test.xqy";
import module namespace xqdoc="http://github.com/xquery/xquerydoc" at "/xquery/ml-xquerydoc.xq";

declare variable $distpath as xs:string external;
declare variable $example as xs:string external;
declare variable $expected as xs:string external;
declare variable $t as xs:string external;

let $expect    := xdmp:document-get(fn:concat($distpath,$expected))
let $xquerydoc := xdmp:document-get(fn:concat($distpath,$example),
<options xmlns="xdmp:document-get">
  <encoding>UTF-8</encoding>
  <format>text</format>
</options>
)
let $actual    := xqdoc:parse($xquerydoc,'test') 


  let $params := map:map()
  let $_put := map:put(
                    $params,
                    xdmp:key-from-QName(fn:QName("", "source")),
                    $xquerydoc)
let $transform := xdmp:xslt-invoke(
                        '/lib/html-module.xsl',
	                $actual,$params) 
  return
    <tests name="Output HTML" t="{$t}" example="{$example}" expected="{$expected}">
    <test name="ml2" desc="output-html manually">
      <expected>{$expect}</expected>
      <actual>{$transform}</actual>
    </test>
    <test name="ml3" desc="output-html with xqdoc:generate-docs">
      <expected>{$expect}</expected>
      <actual>{xqdoc:generate-docs('html',$actual,$xquerydoc)}</actual>
    </test>
    </tests>
