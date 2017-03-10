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

export NAILGUN_STATIC=$ARTIFACTS/static
export NAILGUN_TEMPLATES=$NAILGUN_STATIC

export NAILGUN_START_MAX_WAIT_TIME=${NAILGUN_START_MAX_WAIT_TIME:-30}

export NAILGUN_FIXTURE_FILES="${NAILGUN_ROOT}/nailgun/fixtures/sample_environment.json ${NAILGUN_ROOT}/nailgun/fixtures/sample_plugins.json"
export NAILGUN_CHECK_URL='/api/version'

run_nailgun_server() {
  pushd "$FUEL_WEB_ROOT" > /dev/null
  tox -e stop
  tox -e cleanup
  tox -e start
  popd > /dev/null
}

run_nailgun_server
