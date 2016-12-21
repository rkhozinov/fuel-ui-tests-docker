FROM ubuntu:14.04

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN apt-get update                                   && \
    apt-get install --yes software-properties-common && \
    apt-get remove --yes nodejs nodejs-legacy        && \
    add-apt-repository --yes ppa:chris-lea/node.js   && \
    apt-get -y update                                && \
    apt-get -y dist-upgrade                          && \
    apt-get -y upgrade                               && \
    apt-get install --yes --reinstall libcanberra-gtk3-module    \
                                      nodejs                     \
                                      python-software-properties \
                                      postgresql-9.3             \
                                      postgresql-client-9.3      \
                                      postgresql-contrib-9.3     \
                                      python-dev                 \
                                      python-pip                 \
                                      git                        \
                                      postgresql-server-dev-all  \
                                      libjpeg-dev                \
                                      openjdk-7-jdk              \
                                      puppet-common              \
                                      x11-xserver-utils          \
                                      wget                       \
                                      lsof                       \
                                      gksu                       \
                                      libcanberra-gtk-module     \
                                      curl                       \
                                      alien                      \
                                      ruby-dev                   \
                                      createrepo                 \
                                      rpm                        \
                                      dpkg-dev

USER root
RUN cd /usr/local                                     && \
    wget -O firefox.tar.bz2 $FIREFOX_URL              && \
    tar xvjf firefox.tar.bz2                          && \
    ln -s /usr/local/firefox/firefox /usr/bin/firefox

RUN apt-key adv --keyserver keyserver.ubuntu.com                               \
    --recv-keys B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8                    && \
    echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" >    \
    /etc/apt/sources.list.d/pgdg.list                                       && \
    sed -ir 's/peer/trust/' /etc/postgresql/9.*/main/pg_hba.conf

RUN pip install fuel-plugin-builder                        \
                virtualenv                                 \
                virtualenvwrapper
RUN gem install fpm
RUN git clone https://github.com/openstack/fuel-plugins && \
    cd fuel-plugins/examples/fuel_plugin_example_v4     && \
    fpb --build .

USER root
RUN echo "postgres ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/postgres && \
    chmod 0440 /etc/sudoers.d/postgres

USER postgres
RUN sudo /etc/init.d/postgresql start                           && \
    psql -c "CREATE ROLE nailgun WITH LOGIN PASSWORD 'nailgun'" && \
    createdb nailgun && \
    sudo mkdir /var/log/nailgun

RUN cd /fuel-ui                && \
    git checkout stable/mitaka && \
    npm install -g gulp        && \
    npm install

RUN chmod +x /usr/local/bin/virtualenvwrapper.sh              && \
    source /usr/local/bin/virtualenvwrapper.sh                && \
    mkvirtualenv fuel-venv                                    && \
    workon fuel-venv                                          && \
    cd /fuel-web                                              && \
    git checkout stable/mitaka                                && \
    cd nailgun                                                && \
    pip install --allow-all-external -r test-requirements.txt && \
    pip install python-fuelclient
