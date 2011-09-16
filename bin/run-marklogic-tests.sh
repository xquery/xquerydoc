#!/bin/bash
cd src/tests

/usr/local/bin/calabash -isource=config.xml -oresult=result/report.xml marklogic-test.xpl test=/tests/unit/simple.xqy example=/src/tests/examples/default.xqy
