#!/bin/bash

# Script to run tests with coverage and generate HTML report

set -e

echo "Running tests with coverage..."
dart test --coverage=coverage

echo "Formatting coverage data..."
dart run coverage:format_coverage \
  --lcov \
  --in=coverage \
  --out=coverage/lcov.info \
  --check-ignore \
  --packages=.dart_tool/package_config.json \
  --report-on=lib 

echo "Generating HTML coverage report..."
if command -v genhtml &> /dev/null; then
  genhtml coverage/lcov.info -o coverage/html
  echo "HTML coverage report generated at: coverage/html/index.html"
else
  echo "Warning: genhtml not found. Install lcov to generate HTML report:"
  echo "  macOS: brew install lcov"
  echo "  Ubuntu/Debian: sudo apt-get install lcov"
  echo ""
  echo "Coverage data is available at: coverage/lcov.info"
fi

echo "Done!"

