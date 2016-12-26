#!/bin/bash
cd /fuel-plugins/examples/fuel_plugin_example_v4
fpb --build .
/etc/init.d/postgresql start
source /usr/local/bin/virtualenvwrapper.sh
workon fuel-venv
cd /fuel-ui
echo "Starting X virtual framebuffer (Xvfb) in background..."
pkill Xvfb
rm -rf /tmp/.X*-lock
export LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu/
Xvfb $DISPLAY -render +xinerama -ac -screen 0 1920x1080x24 +extension GLX +extension RANDR +render -noreset &
sleep 5
xdpyinfo -display :99 | grep "number of extensions"  -A 25
gksu npm run component-tests
