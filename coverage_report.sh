#!/bin/sh

./coverage.sh

## Generate LCOV report:
genhtml -o ./coverage/report ./coverage/lcov.info

## Open the HTML coverage report:
open ./coverage/report/index.html
