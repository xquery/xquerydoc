xquery version "1.0-ml" encoding "UTF-8";

import module namespace test = "http://www.marklogic.com/test" at "/lib/test.xqy";
import module namespace xqdoc="http://github.com/xquery/xquerydoc" at "/xquery/ml-xquerydoc.xq";

declare variable $distpath as xs:string external;
declare variable $example as xs:string external;

let $expected  := xdmp:document-get(fn:concat($distpath,'/src/tests/expected/output-html.xml'))
let $actual    := xqdoc:parse(xdmp:quote(xdmp:document-get(fn:concat($distpath,$example)))) 
let $transform := xdmp:xslt-invoke(
                        '/lib/html-module.xsl',
	                $actual) 
  return
    <tests name="Output HTML">
    <test name="output-html manually">
      <expected>{$expected}</expected>
      <actual>{$transform}</actual>
    </test>
    <test name="output-html with xqdoc:generate-docs">
      <expected>{$expected}</expected>
      <actual>{xqdoc:generate-docs('html',$actual)}</actual>
    </test>
    </tests>
