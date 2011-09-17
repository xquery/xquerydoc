#!/bin/bash

# This script runs the xquerydoc testsuite for the MarkLogic processor
# using an XProc pipeline (src/tests/marklogic-test.xpl), which is a generic
# testrunner.
#
# MarkLogic unit tests are located under src/tests/unit/marklogic
#
# to add new tests review existing tests there and add an entry here to run them.
#
# the following describes the input/output and options passed in through XProc
#
# -isource: XProc input takes in MarkLogic configuration file (src/tests/config.xml)
# -oresult: XProc output writes result of tests to src/tests/results/marklogic
#
#     test: option contains the unit test path (unit tests are written in xquery)
#  example: option contains the path to the example xquery document to apply unit test too
# expected: option contains the path to the expected result for the test
#

cd src/tests

/usr/local/bin/calabash -isource=config.xml -oresult=result/MarkLogic/default.xml marklogic-test.xpl test=/tests/unit/marklogic/simple.xqy example=/src/tests/examples/default.xqy expected=/src/tests/expected/default.xml

/usr/local/bin/calabash -isource=config.xml -oresult=result/MarkLogic/get-code.xml marklogic-test.xpl test=/tests/unit/marklogic/simple.xqy example=/src/tests/examples/get-code.xqy expected=/src/tests/expected/get-code.xml

/usr/local/bin/calabash -isource=config.xml -oresult=result/MarkLogic/output-html.xml marklogic-test.xpl test=/tests/unit/marklogic/output-html.xqy example=/src/tests/examples/default.xqy  expected=/src/tests/expected/output-html.xml

/usr/local/bin/calabash -isource=config.xml -oresult=result/MarkLogic/json.xml marklogic-test.xpl test=/tests/unit/marklogic/simple.xqy example=/src/tests/examples/json.xqy  expected=/src/tests/expected/json.xml

/usr/local/bin/calabash -isource=config.xml -oresult=result/MarkLogic/json-output-html.xml marklogic-test.xpl test=/tests/unit/marklogic/output-html.xqy example=/src/tests/examples/json.xqy  expected=/src/tests/expected/json-html-output.xml

/usr/local/bin/calabash -isource=config.xml -oresult=result/marklogic-report.html report.xpl processor=MarkLogic
