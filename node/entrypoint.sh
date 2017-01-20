#!/bin/bash

cd /fuel-ui
npm install > npm_install.log
bash run_real_plugin_tests_on_real_nailgun.sh
