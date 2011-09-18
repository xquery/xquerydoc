#!/bin/bash

# This script runs the xquerydoc testsuite for the Saxon  processor
# using an XProc pipeline (src/tests/marklogic-test.xpl), which is a generic
# testrunner.
#
# MarkLogic unit tests are located under src/tests/unit/saxon
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

calabash -isource=config.xml -oresult=result/Saxon/default.xml saxon-test.xpl example=/src/tests/examples/?select=default.xqy expected=/src/tests/expected/saxon/default.xml

calabash -isource=config.xml -oresult=result/Saxon/get-code.xml saxon-test.xpl example=/src/tests/examples/?select=get-code.xqy expected=/src/tests/expected/saxon/get-code.xml

calabash -isource=config.xml -oresult=result/saxon-report.html report.xpl processor=Saxon

