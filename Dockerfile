FROM ubuntu:14.04

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN apt-get update && \
    apt-get install --yes software-properties-common && \
    apt-get remove --yes nodejs nodejs-legacy && \
    add-apt-repository --yes ppa:chris-lea/node.js && \
    apt-get -y update && \
    apt-get -y dist-upgrade && \
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
    xvfb \
    gtk2-engines-pixbuf \
    xfonts-cyrillic \
    xfonts-100dpi \
    xfonts-75dpi \
    xfonts-base \
    xfonts-scalable\
    imagemagick \
    x11-apps \
    dpkg-dev

ARG FIREFOX_URL
USER root
RUN cd /usr/local && \
    wget -qO firefox.tar.bz2 $FIREFOX_URL && \
    tar xjf firefox.tar.bz2 && \
    ln -s /usr/local/firefox/firefox /usr/bin/firefox

RUN apt-key adv --keyserver keyserver.ubuntu.com \
    --recv-keys B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8 && \
    echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" > \
    /etc/apt/sources.list.d/pgdg.list && \
    sed -ir 's/peer/trust/' /etc/postgresql/9.*/main/pg_hba.conf

RUN pip install fuel-plugin-builder virtualenv virtualenvwrapper

RUN gem install fpm

USER root
RUN echo "postgres ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/postgres && \
    chmod 0440 /etc/sudoers.d/postgres

USER postgres
RUN sudo /etc/init.d/postgresql start && \
    psql -c "CREATE ROLE nailgun WITH LOGIN PASSWORD 'nailgun'" && \
    createdb nailgun && \
    sudo mkdir /var/log/nailgun

USER root
ARG FUEL_WEB_PIP_REQS
RUN chmod +x /usr/local/bin/virtualenvwrapper.sh && \
    source /usr/local/bin/virtualenvwrapper.sh && \
    mkvirtualenv fuel-venv && \
    pip install --allow-all-external -r $FUEL_WEB_PIP_REQS && \
    pip install --upgrade python-fuelclient tox

ARG FUEL_UI_NPM_REQS
RUN npm install -g gulp && \
    wget --no-check-certificate -O package.json $FUEL_UI_NPM_REQS && \
    npm install
