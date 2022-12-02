#!/bin/sh

## Run Dart tests and output them at directory `./coverage`:
dart run test --coverage=./coverage

## Activate package `coverage` (if needed):
dart pub global activate coverage

## Format collected coverage to LCOV (only for directory "lib")
dart pub global run coverage:format_coverage --packages=.dart_tool/package_config.json --report-on=lib --lcov -o ./coverage/lcov.info -i ./coverage
