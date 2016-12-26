#!/bin/bash

cat << CONFIG > /opt/selenium/config.json
{
  "capabilities": [
    {
      "browserName": "firefox",
      "maxInstances": ${NODE_MAX_INSTANCES:-1},
      "seleniumProtocol": "WebDriver"
    }
  ],
  "proxy": "org.openqa.grid.selenium.proxy.DefaultRemoteProxy",
  "maxSession": ${NODE_MAX_SESSION:-1},
  "port": ${SELENIUM_SERVER_PORT:-4444},
  "register": true,
  "registerCycle": ${NODE_REGISTER_CYCLE:-1}
}
CONFIG

export GEOMETRY="${SCREEN_WIDTH:-1920}""x""${SCREEN_HEIGHT:-1080}""x""${SCREEN_DEPTH:-24}"

if [ ! -e /opt/selenium/config.json ]; then
  echo No Selenium Node configuration file, the node-base image is not intended to be run directly. 1>&2
  exit 1
fi

function shutdown {
  kill -s SIGTERM $NODE_PID
  wait $NODE_PID
}

if [ ! -z "$SE_OPTS" ]; then
  echo "appending selenium options: ${SE_OPTS}"
fi

SERVERNUM=$(echo $DISPLAY | sed -r -e 's/([^:]+)?:([0-9]+)(\.[0-9]+)?/\2/')

rm -f /tmp/.X*lock

# FROM StandaloneFirefox

#xvfb-run -n $SERVERNUM --server-args="-screen 0 $GEOMETRY -ac +extension RANDR" \
#  java ${JAVA_OPTS} -jar /opt/selenium/selenium-server-standalone.jar \
#    -role node \
#    -hub http://$HUB_PORT_4444_TCP_ADDR:$HUB_PORT_4444_TCP_PORT/grid/register \
#    -nodeConfig /opt/selenium/config.json \
#    ${SE_OPTS} &
#NODE_PID=$!

xvfb-run -n ${SERVERNUM:?} --server-args="-screen 0 ${GEOMETRY:?} -ac +extension RANDR" \
  java ${JAVA_OPTS} -jar /opt/selenium/selenium-server-standalone.jar \
  ${SE_OPTS} &
NODE_PID=$!

trap shutdown SIGTERM SIGINT
wait ${NODE_PID:?}
