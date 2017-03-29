#!/bin/bash -e

set -x

cd /var/lib/fuel-ui

NAILGUN_ROOT=/var/lib$FUEL_WEB_ROOT/nailgun

mkdir -p $ARTIFACTS

export NAILGUN_STATIC=$ARTIFACTS/static

GULP="/var/lib/fuel-ui/node_modules/.bin/gulp"
TESTS_DIR=static/tests/functional
TESTS=$TESTS_DIR/test_*.js

echo "Building UI..."
${GULP} build --no-sourcemaps --extra-entries=sinon --static-dir=$NAILGUN_STATIC

cd /var/lib/fuel-web

export NAILGUN_STATIC=$ARTIFACTS/static
export NAILGUN_TEMPLATES=$NAILGUN_STATIC

export NAILGUN_START_MAX_WAIT_TIME=${NAILGUN_START_MAX_WAIT_TIME:-30}

export NAILGUN_FIXTURE_FILES="${NAILGUN_ROOT}/nailgun/fixtures/sample_environment.json ${NAILGUN_ROOT}/nailgun/fixtures/sample_plugins.json"
export NAILGUN_CHECK_URL='/api/version'

pushd "/var/lib$FUEL_WEB_ROOT" > /dev/null
tox -e stop
rm -f /var/lib/dev-server/started
tox -e start && touch var/lib/dev-server/started
popd > /dev/null

bash -c "trap : TERM INT; sleep infinity & wait"

