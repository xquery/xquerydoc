#xquerydoc

Parses xqDoc comments from your xquery and generates a set of API
level documentation using pure XQuery.


  * XQuery v1.0 (Saxon, XQilla)
  * XQuery v3.0 (Saxon)
  * XQuery 1.0-ml (MarkLogic)


##Install



##Usage

There are several ways to use xquerydoc.

###commandline

The  bin/xquerydoc script can be invoked from the commandline and
generate documentation from xquery containing xqdoc comments.

To use you simply point xquerydoc to a directory or single xquery file
as well as provide a directory for the documentation to be generated
into to.

```
   > xquerydoc {xquerydoc} {output html}
```

The following example will process a directory containing xquery and
output documentation to another directory.

```
   > xquerydoc /some/directory/containing/xquery/ /output/html/to/some/directory/
```

###from xquery

As xquerydoc is pure xquery you can also invoke xquerydoc directly
from your own xquery applications and employing the
xqdoc:xqdoc() function to extract xqDoc comments.

Whilst xquerydoc itself is written in XQuery v1.0, as a convenience we have provided XQuery processor specific 
implementations to apply stying.

####XQuery v1.0 Example (Saxon)
```

   xquery version "1.0" encoding "UTF-8";

   import module namespace xqdoc="http://github.com/xquery/xquerydoc" at "/xquery/xquerydoc.xq";

   xqdoc:xqdoc(fn:collection('/some/xquery/?select=file.xqy;unparsed=yes')) 
```

####MarkLogic Example
```
   xquery version "1.0-ml" encoding "UTF-8";

   import module namespace xqdoc="http://github.com/xquery/xquerydoc" at "/xquery/ml-xquerydoc.xq";

   xqdoc:xqdoc(xdmp:quote(xdmp:document-get(fn:concat($distpath,$example)))) 
```


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

