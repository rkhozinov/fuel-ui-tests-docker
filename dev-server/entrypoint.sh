#!/bin/bash

/etc/init.d/postgresql start

bash dev-server/run_dev_server.sh

while :
do
	sleep 1;
done
