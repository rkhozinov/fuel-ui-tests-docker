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

NAILGUN_ROOT=$FUEL_WEB_ROOT/nailgun

mkdir -p $ARTIFACTS

export NAILGUN_STATIC=$ARTIFACTS/static

local GULP="./node_modules/.bin/gulp"
local TESTS_DIR=static/tests/functional
local TESTS=$TESTS_DIR/test_*.js


echo "Building UI..."
${GULP} build --no-sourcemaps --extra-entries=sinon --static-dir=$NAILGUN_STATIC
