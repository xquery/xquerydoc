#xquerydoc


  * XQuery v1.0 (Saxon, XQilla)
  * XQuery v3.0 (Saxon)
  * XQuery 1.0-ml (MarkLogic)


##Install



##Usage


As xquerydoc comes with bin/xquerydoc script

   > xquerydoc -v 1.0-ml /some/directory

   > xquerydoc -v 1.0 /some/specific/file.xqy


Or you can choose to import xquerydoc into your xquery and use the
xqdoc:xqdoc() entry function.


   XQuery v1.0 Example (XQilla)
   ---------------------------

   TBD


   XQuery v1.0 Example (Saxon)
   ---------------------------

   xquery version "1.0" encoding "UTF-8";

   import module namespace xqdoc="http://github.com/xquery/xquerydoc" at "/xquery/xquerydoc.xq";

   xqdoc:xqdoc(fn:collection('/some/xquery/?select=file.xqy;unparsed=yes')) 


   MarkLogic Example
   -----------------

   xquery version "1.0-ml" encoding "UTF-8";

   import module namespace xqdoc="http://github.com/xquery/xquerydoc" at "/xquery/ml-xquerydoc.xq";

   xqdoc:xqdoc(xdmp:quote(xdmp:document-get(fn:concat($distpath,$example)))) 



##Running Tests


To run all tests

   > bin/run-all-tests.sh

To run tests related to a specific processor

   > bin/run-saxon-tests.sh 
   > bin/run-marklogic-tests.sh

To run MarkLogic tests you will need to;

   1) Setup MarkLogic XCC Application Server setting root to /src directory

   2) edit src/tests/config.xml to reflect your setup

   3) you can run tests using /bin scripts are directly using
   src/tests/{}-test.xpl for your processor

All tests are run using XML Calabash XProc processor and can be
manually invoked, as follows;

    > /usr/local/bin/calabash -isource=config.xml -oresult=result/MarkLogic/default.xml marklogic-test.xpl test=/tests/unit/marklogic/simple.xqy example=/src/tests/examples/default.xqy
    > /usr/local/bin/calabash -isource=config.xml -oresult=result/marklogic-report.html report.xpl processor=MarkLogic

The above would run the first test then generate report in the
src/tests/result directory. To get a better understanding of how tests
are run please inspect the run scripts in /bin.



##Resources

xquerydoc github: http://www.github.com/xquery/xquerydoc

xqdoc: 


##Dependencies

For convenience we have included all the dependencies xquerydoc
requires.

  * XML Calabash - to install run > java -jar calabash-0.9.34.jar
  * Saxon (ships with XML Calabash)
  * xqDoc 

Please review the licenses of included software.



##Credit, Acknowledgements, License

original xqDoc - http://xqdoc.org/

John Snelson

James Fuller

parsers were generated from EBNF using Gunther Rademacher http://www.bottlecaps.de/rex/

xquerydoc is released under Apache License v2.0

Copyright 2011 John Snelson, James Fuller

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and

XML Calabash is released under {TBD}

Saxon XQuery and XSLT 2.0 Processor by Michael Kay is released under {TBD}

Prettify (used by testsuite) is released under {TBD}
XQuery prettify http://www.patrick-wied.at/static/xquery/prettify/



##Contact


{TBD}









--------------------------------

Jim's Notes
-----------

* docs
  * embed xqdoc in xquerydoc own code and generate for /docs
  * create markdown version of README

* build based on xproc
  * upload EBNF (loop through all EBNF) to http://www.bottlecaps.de/rex/ 
  * download result and place in src/xquery
  
* test
  * test xquery1, xquery3, xquery-ml
  * create tests 

* xquery
  * create xquery entry point for parsing and generating output
  * create documentation targets for the following formats
    * html
    * text
    * markdown
    * docbook

* integrate existing xqdoc disply routines

* make work across several xquery processors

