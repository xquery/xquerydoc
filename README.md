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
generate documentation from xquery containing xqdoc comments. This
uses XML Calabash XProc pipeline (which comes with SAXON XQuery
processor) to invoke XQuery v1.0 xquerydoc and generate documentation
by applying XSLT transformation.

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

In addition we provide a MarkLogic variant of this script which will
connect to MarkLogic server (via XDBC) and invoke the MarkLogic v1.0
xquerydoc and generate documentation.

```
   > ml-xquerydoc /some/directory/containing/xquery/ /output/html/to/some/directory/
```

To use this variant you will need to setup MarkLogic XDBC server and
provide details in etc/config.xml file.

Note that you do not need to use ml-xquerydoc to genreate
documentation from a set of 1.0-ml version scripts, xquerydoc will do
that for you. 

###from xquery

As xquerydoc is itself written in pure XQuery v1.0  you can invoke xquerydoc directly
from your own xquery applications and employing the xqdoc:xqdoc() function to extract xqDoc comments.

Whilst xquerydoc itself is written in XQuery v1.0, as a convenience we have provided XQuery processor specific 
implementations to apply stying.

####XQuery v1.0 Example (Saxon)
```

   xquery version "1.0" encoding "UTF-8";

   import module namespace xqdoc="http://github.com/xquery/xquerydoc" at "/xquery/xquerydoc.xq";

   xqdoc:xqdoc(fn:collection('/some/xquery/?select=file.xqy;unparsed=yes')) 
```
As with the commandline version we provide for your convenience a
MarkLogic version (though the XQuery v1.0 should also run, within
MarkLogic just as well). 

####MarkLogic Example
```
   xquery version "1.0-ml" encoding "UTF-8";

   import module namespace xqdoc="http://github.com/xquery/xquerydoc" at "/xquery/ml-xquerydoc.xq";

   xqdoc:xqdoc(xdmp:document-get(fn:concat($distpath,$example))) 
```

## API Docs

Yup we eat our own dog chow, view API docs here.


##Running Tests

To run all tests

```
   > bin/run-all-tests.sh
```

All this script does is run the following xquery processor specific scripts.

```
> bin/run-saxon-tests.sh 
> bin/run-marklogic-tests.sh
```

Test scripts work by invoking an XProc pipeline in src/tests (either saxon-test.xpl or marklogic-test.xpl).

To run MarkLogic tests you will need to setup XDBC server and edit
src/tests/config.xml with relevant details.

If you want to invoke these scripts manually please review the test
run scripts to understand what needs to be passed into Calabash.


##Resources

xquerydoc github: http://www.github.com/xquery/xquerydoc

xqdoc: 

Calabash:

##Dependencies

For convenience we have included all the dependencies xquerydoc
requires.

  * XML Calabash - to install run > java -jar calabash-0.9.34.jar
  * Saxon (ships with XML Calabash)
  * xqDoc 

Please review the licenses of included software.



##Credit, Acknowledgements

Copyright 2011 John Snelson and James Fuller

original xqDoc - http://xqdoc.org/

XQuery parsers were generated from EBNF using Gunther Rademacher
excellent http://www.bottlecaps.de/rex/

XML Calabash is released under {TBD}

Saxon XQuery and XSLT 2.0 Processor by Michael Kay is released under {TBD}

Prettify (used by api doc and testsuite) is released under {TBD}

XQuery prettify was provided by Patrick Wied
http://www.patrick-wied.at/static/xquery/prettify/ 


## License

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

