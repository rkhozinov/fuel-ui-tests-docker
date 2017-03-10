FROM node:0.12.18

RUN echo "deb http://ftp.cz.debian.org/debian/ jessie main\n" > /etc/apt/sources.list && \
    echo "deb http://ftp.cz.debian.org/debian/ jessie-updates main\n" >> /etc/apt/sources.list && \
    echo "deb http://security.debian.org jessie/updates main\n" >> /etc/apt/sources.list

ARG TZ
RUN echo "${TZ}" > /etc/timezone && \
    dpkg-reconfigure --frontend noninteractive tzdata

RUN apt-get update && \
    apt-get install --yes software-properties-common && \
    apt-get -y dist-upgrade && \
    apt-get -y update && \
    apt-get -y upgrade && \
    apt-get install --yes --reinstall postgresql \
                                      python-dev \
                                      python-pip \
                                      libjpeg-dev \
                                      curl && \
    apt-get -y autoremove && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/*

RUN apt-get remove -y python-pip && easy_install pip && \
    pip install -r https://raw.githubusercontent.com/openstack/fuel-web/stable/newton/nailgun/test-requirements.txt && \
    pip uninstall -y tox && \
    pip install --upgrade tox

RUN mkdir -p /var/log/nailgun

