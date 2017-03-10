#!/bin/bash

cp node/run_ui_func_tests.sh fuel-ui/

cd fuel-ui
npm install > npm_install.log

bash run_ui_func_tests.sh ${TEST_PATH}
