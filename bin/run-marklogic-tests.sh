#!/bin/bash
cd src/tests

/usr/local/bin/calabash -isource=config.xml -oresult=result/MarkLogic/default.xml marklogic-test.xpl test=/tests/unit/marklogic/simple.xqy example=/src/tests/examples/default.xqy
/usr/local/bin/calabash -isource=config.xml -oresult=result/marklogic-report.html report.xpl processor=MarkLogic
