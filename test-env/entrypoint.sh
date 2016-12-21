export DISPLAY=:0                          && \
xhost +local:                              && \
/etc/init.d/postgresql start               && \
source /usr/local/bin/virtualenvwrapper.sh && \
workon fuel-venv                           && \
pip uninstall --upgrade -y tox             && \
cd /fuel-ui                                && \
gksu npm run component-tests
