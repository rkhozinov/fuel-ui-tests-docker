FROM node:0.12.18

RUN  echo "deb http://ftp.cz.debian.org/debian/ jessie main\n" > /etc/apt/sources.list \
  && echo "deb http://ftp.cz.debian.org/debian/ jessie-updates main\n" >> /etc/apt/sources.list \
  && echo "deb http://security.debian.org jessie/updates main\n" >> /etc/apt/sources.list

ARG TZ
RUN echo "${TZ}" > /etc/timezone \
  && dpkg-reconfigure --frontend noninteractive tzdata

RUN npm install -g gulp

RUN apt-get update && \
    apt-get install --yes software-properties-common && \
    apt-get -y dist-upgrade && \
    apt-get -y update && \
    apt-get -y upgrade && \
    apt-get install --yes --reinstall libcanberra-gtk3-module \
                                      ssh \
                                      sshpass \
                                      python-software-properties \
                                      postgresql \
                                      postgresql-client \
                                      postgresql-contrib \
                                      python-dev \
                                      python-pip \
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
                                      dpkg-dev \
    && apt-get -y autoremove \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

RUN apt-get remove -y python-pip && easy_install pip && pip install python-fuelclient && \
    pip install --allow-all-external -r https://raw.githubusercontent.com/openstack/fuel-web/stable/newton/nailgun/test-requirements.txt && \
    pip uninstall -y tox && \
    pip install --upgrade tox

RUN sudo mkdir /var/log/nailgun
