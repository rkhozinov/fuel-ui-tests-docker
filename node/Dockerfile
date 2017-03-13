FROM node:0.12.18

RUN  echo "deb http://ftp.cz.debian.org/debian/ jessie main\n" > /etc/apt/sources.list \
  && echo "deb http://ftp.cz.debian.org/debian/ jessie-updates main\n" >> /etc/apt/sources.list \
  && echo "deb http://security.debian.org jessie/updates main\n" >> /etc/apt/sources.list

ARG TZ
RUN echo "${TZ}" > /etc/timezone \
  && dpkg-reconfigure --frontend noninteractive tzdata

RUN apt-get update -qqy \
  && apt-get -qqy --no-install-recommends install \
     ssh \
     sshpass #\
#  && rm -rf /var/lib/apt/lists/* /var/cache/apt/* \
#  && apt-get -y autoremove

RUN npm install -g gulp

RUN apt-get update && \
    apt-get install --yes software-properties-common && \
    apt-get -y dist-upgrade && \
    apt-get -y update && \
    apt-get -y upgrade && \
    apt-get install --yes --reinstall libcanberra-gtk3-module \
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
                                      dpkg-dev

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8 && \
    echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" > /etc/apt/sources.list.d/pgdg.list && \
    sed -ir 's/peer/trust/' /etc/postgresql/9.*/main/pg_hba.conf

RUN echo "postgres ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/postgres && \
    chmod 0440 /etc/sudoers.d/postgres

RUN apt-get remove -y python-pip && easy_install pip && pip install tox

USER postgres
RUN sudo /etc/init.d/postgresql start && \
    psql -c "CREATE ROLE nailgun WITH LOGIN PASSWORD 'nailgun'" && \
    createdb nailgun && \
    sudo mkdir /var/log/nailgun

