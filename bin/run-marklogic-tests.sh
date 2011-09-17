#!/bin/bash
cd src/tests

/usr/local/bin/calabash -isource=config.xml -oresult=result/MarkLogic/default.xml marklogic-test.xpl test=/tests/unit/marklogic/simple.xqy example=/src/tests/examples/default.xqy expected=/src/tests/expected/default.xml


/usr/local/bin/calabash -isource=config.xml -oresult=result/MarkLogic/output-html.xml marklogic-test.xpl test=/tests/unit/marklogic/output-html.xqy example=/src/tests/examples/default.xqy  expected=/src/tests/expected/output-html.xml

/usr/local/bin/calabash -isource=config.xml -oresult=result/MarkLogic/json.xml marklogic-test.xpl test=/tests/unit/marklogic/simple.xqy example=/src/tests/examples/json.xqy  expected=/src/tests/expected/json.xml

/usr/local/bin/calabash -isource=config.xml -oresult=result/MarkLogic/json-output-html.xml marklogic-test.xpl test=/tests/unit/marklogic/output-html.xqy example=/src/tests/examples/json.xqy  expected=/src/tests/expected/json-html-output.xml

/usr/local/bin/calabash -isource=config.xml -oresult=result/marklogic-report.html report.xpl processor=MarkLogic
