#!/bin/bash -xe

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

cd /fuel-ui

NAILGUN_ROOT=$FUEL_WEB_ROOT/nailgun

mkdir -p $ARTIFACTS

export NAILGUN_STATIC=$ARTIFACTS/static

GULP="./node_modules/.bin/gulp"
TESTS_DIR=static/tests/functional
TESTS=$TESTS_DIR/test_*.js

echo "Building UI..."
${GULP} build --no-sourcemaps --extra-entries=sinon --static-dir=$NAILGUN_STATIC

cd /fuel-web
NAILGUN_ROOT=$FUEL_WEB_ROOT/nailgun

export NAILGUN_STATIC=$ARTIFACTS/static
export NAILGUN_TEMPLATES=$NAILGUN_STATIC

export NAILGUN_START_MAX_WAIT_TIME=${NAILGUN_START_MAX_WAIT_TIME:-30}

export NAILGUN_FIXTURE_FILES="${NAILGUN_ROOT}/nailgun/fixtures/sample_environment.json ${NAILGUN_ROOT}/nailgun/fixtures/sample_plugins.json"
export NAILGUN_CHECK_URL='/api/version'

pushd "$FUEL_WEB_ROOT" > /dev/null
tox -e stop
rm -f /dev-server/started
tox -e start && touch /dev-server/started
popd > /dev/null

bash -c "trap : TERM INT; sleep infinity & wait"

