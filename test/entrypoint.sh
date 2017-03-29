#!/bin/bash -eu

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

cd /var/lib/fuel-ui

mkdir -p ${ARTIFACTS:?}
export NAILGUN_STATIC="${ARTIFACTS}/static"
export NAILGUN_PORT=${NAILGUN_PORT:?}

GULP="./node_modules/.bin/gulp"

echo "Building tests..."
${GULP} intern:transpile

echo "Running tests..."
${GULP} intern:run --browser='firefox' --suites=${TEST_PATH:?}

