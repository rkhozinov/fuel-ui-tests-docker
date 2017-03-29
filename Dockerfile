FROM ubuntu:14.04

RUN rm /bin/sh && \
    ln -s /bin/bash /bin/sh

RUN apt-get update && \
    apt-get install --yes software-properties-common && \
    apt-get remove --yes nodejs nodejs-legacy && \
    add-apt-repository --yes ppa:chris-lea/node.js && \
    apt-get -y dist-upgrade && \
    apt-get -y update && \
    apt-get -y upgrade && \
    apt-get install --yes --reinstall libcanberra-gtk3-module \
                                      nodejs \
                                      python-software-properties \
                                      postgresql-9.3 \
                                      postgresql-client-9.3 \
                                      postgresql-contrib-9.3 \
                                      python-dev \
                                      python-pip \
                                      git \
                                      postgresql-server-dev-all \
                                      libjpeg-dev \
                                      openjdk-7-jdk \
                                      puppet-common \
                                      x11-xserver-utils \
                                      wget \
                                      lsof \
                                      gksu \
                                      libcanberra-gtk-module \
                                      curl \
                                      alien \
                                      ruby-dev \
                                      createrepo \
                                      rpm \
                                      dpkg-dev

RUN cd /usr/local && \
    wget http://ftp.mozilla.org/pub/mozilla.org/firefox/releases/46.0.1/linux-x86_64/en-US/firefox-46.0.1.tar.bz2 && \
    tar xvjf firefox-46.0.1.tar.bz2 && \
    sudo ln -s /usr/local/firefox/firefox /usr/bin/firefox

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8 && \
    echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" > /etc/apt/sources.list.d/pgdg.list && \
    sed -ir 's/peer/trust/' /etc/postgresql/9.*/main/pg_hba.conf

RUN pip install fuel-plugin-builder \
                virtualenv \
                virtualenvwrapper && \
    gem install fpm && \
    git clone https://github.com/openstack/fuel-plugins && \
    cd fuel-plugins/examples/fuel_plugin_example_v4 && \
    fpb --build .

ENV PLUGIN_RPM=/fuel-plugins/examples/fuel_plugin_example_v4/fuel_plugin_example_v4-4.0-4.0.0-1.noarch.rpm
ENV VENV=/root/.virtualenvs/fuel-venv

RUN echo "postgres ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/postgres && \
    chmod 777 /etc/sudoers.d/postgres

USER postgres
RUN sudo /etc/init.d/postgresql start && \
    psql -c "CREATE ROLE nailgun WITH LOGIN PASSWORD 'nailgun'" && \
    createdb nailgun && \
    sudo mkdir /var/log/nailgun

RUN git clone https://github.com/openstack/fuel-web.git && \
    git clone https://github.com/openstack/fuel-ui.git

RUN cd /fuel-ui && \
    git checkout stable/mitaka && \
    npm install -g gulp && \
    npm install

RUN chmod 777 /usr/local/bin/virtualenvwrapper.sh && \
    source /usr/local/bin/virtualenvwrapper.sh && \
    mkvirtualenv fuel-venv && \
    workon fuel-venv && \
    cd /fuel-web && \
    git checkout stable/mitaka && \
    cd nailgun && \
    pip install --allow-all-external -r test-requirements.txt && \
    pip install python-fuelclient

ENTRYPOINT export DISPLAY=:0 && \
           xhost +local: && \
           /etc/init.d/postgresql start && \
           source /usr/local/bin/virtualenvwrapper.sh && \
           workon fuel-venv && \
           pip uninstall -y tox && \
           pip install tox && \
           cd /fuel-ui && \
           gksu npm run component-tests
