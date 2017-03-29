#!/bin/bash -e

export GEOMETRY="$SCREEN_WIDTH""x""$SCREEN_HEIGHT""x""$SCREEN_DEPTH"

function shutdown {
  kill -s SIGTERM $NODE_PID
  wait $NODE_PID
}

if [ ! -z "$SE_OPTS" ]; then
  echo "appending selenium options: ${SE_OPTS}"
fi

SERVERNUM=$(echo $DISPLAY | sed -r -e 's/([^:]+)?:([0-9]+)(\.[0-9]+)?/\2/')

rm -f /tmp/.X*lock

xvfb-run -n $SERVERNUM --server-args="-screen 0 $GEOMETRY -ac +extension RANDR" \
  java ${JAVA_OPTS} -jar /opt/selenium/selenium-server-standalone.jar \
  ${SE_OPTS} &
NODE_PID=$!

ps -p $NODE_PID > /dev/null && touch /selenium/started

trap shutdown SIGTERM SIGINT
wait $NODE_PID
