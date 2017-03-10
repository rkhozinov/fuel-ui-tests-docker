#!/bin/bash

#    Copyright 2016 Mirantis, Inc.
#
#    Licensed under the Apache License, Version 2.0 (the "License"); you may
#    not use this file except in compliance with the License. You may obtain
#    a copy of the License at
#
#         http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
#    WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
#    License for the specific language governing permissions and limitations
#    under the License.

set -x

function usage {
  echo "Usage: $0 [OPTION]..."
  echo "Run Fuel UI functional tests"
  echo ""
  echo "  -h, --help                  Print this usage message"
  echo "      --no-ui-build           Skip UI build"
  exit
}

no_ui_build=0
no_nailgun_start=0
tests=

function process_options {
  for arg in $@; do
    case "$arg" in
      -h|--help) usage;;
      --no-ui-build) no_ui_build=1;;
      -*);;
      *) tests="$tests $arg"
    esac
  done
}

NAILGUN_ROOT=$FUEL_WEB_ROOT/nailgun

mkdir -p $ARTIFACTS

export NAILGUN_STATIC=$ARTIFACTS/static

export NAILGUN_PORT=${NAILGUN_PORT:-5544}

# Run UI functional tests.
#
# Arguments:
#
#   $@ -- tests to be run; with no arguments all tests will be run
function run_ui_func_tests {
  local GULP="./node_modules/.bin/gulp"
  local TESTS_DIR=static/tests/functional
  local TESTS=$TESTS_DIR/test_*.js

  if [ $# -ne 0 ]; then
    TESTS=$@
  fi

  if [ $no_ui_build -ne 1 ]; then
    echo "Building UI..."
    ${GULP} build --no-sourcemaps --extra-entries=sinon --static-dir=$NAILGUN_STATIC
  else
    echo "Using pre-built UI from $NAILGUN_STATIC"
    if [ ! -f "$NAILGUN_STATIC/index.html" ]; then
      echo "Cannot find pre-built UI. Don't use --no-ui-build key"
      return 1
    fi
  fi

  echo "Building tests..."
  ${GULP} intern:transpile

  local result=0

  ARTIFACTS=$ARTIFACTS \
  ${GULP} functional-tests --no-transpile --suites=$TESTS || result=1

  return $result
}


# parse command line arguments and run the tests
process_options $@
run_ui_func_tests $tests
