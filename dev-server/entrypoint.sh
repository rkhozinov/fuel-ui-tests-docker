#!/bin/bash

set -x
NAILGUN_ROOT=$FUEL_WEB_ROOT/nailgun

export NAILGUN_STATIC=$ARTIFACTS/static
export NAILGUN_TEMPLATES=$NAILGUN_STATIC

export NAILGUN_START_MAX_WAIT_TIME=${NAILGUN_START_MAX_WAIT_TIME:-30}

export NAILGUN_FIXTURE_FILES="${NAILGUN_ROOT}/nailgun/fixtures/sample_environment.json ${NAILGUN_ROOT}/nailgun/fixtures/sample_plugins.json"
export NAILGUN_CHECK_URL='/api/version'

pushd "$FUEL_WEB_ROOT" > /dev/null
tox -e stop
tox -e cleanup
tox -e start
popd > /dev/null

bash -c "trap : TERM INT; sleep infinity & wait"

