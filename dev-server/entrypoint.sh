#!/bin/bash

cd /fuel-web/nailgun
#sudo pip install --allow-all-external -r test-requirements.txt

cd /fuel-ui
#npm install > npm_install.log

#pip uninstall -y tox
#pip install tox

/etc/init.d/postgresql start
bash run_dev_server.sh
while :
do
	sleep 1;
done
