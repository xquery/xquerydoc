#!/bin/bash
cd src/tests

/usr/local/bin/calabash -isource=config.xml -oresult=result/Saxon/default.xml saxon-test.xpl test=/tests/unit/simple.xqy example=/src/tests/examples/?select=default.xqy
/usr/local/bin/calabash -isource=config.xml -oresult=result/saxon-report.html report.xpl processor=Saxon
