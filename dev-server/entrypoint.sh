#!/bin/bash

set -x

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
tox -e start && touch /dev-server/started
popd > /dev/null

bash -c "trap : TERM INT; sleep infinity & wait"

